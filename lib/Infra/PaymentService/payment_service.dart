import 'package:ecommerce_app/Domain/ProductModel/product_model.dart';
import 'package:ecommerce_app/Domain/orders/order_details.dart';
import 'package:ecommerce_app/Infra/CartService/order_product_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

class PaymentService {
  final _razorpay = Razorpay();
  final uuid = const Uuid();

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response,
      {required OrderDetails orderDetails}) async {
    await OrderProductData().placeOrder(
      orderDetails: orderDetails.copyWith(paymentId: response.paymentId),
    );
    await OrderProductData().clearBasket();
  }

  void _handlePaymentError(PaymentFailureResponse response) {}

  void _handleExternalWallet(ExternalWalletResponse response) {}

  void getPaymentService({
    required int orderValue,
    required List<ProductModel> products,
  }) {
    final authUser = FirebaseAuth.instance.currentUser;
    final orderDetails = OrderDetails(
      orderId: uuid.v1(),
      timeStamp: DateTime.now(),
      orderValue: orderValue,
      products: products,
      userEmail: authUser?.email,
    );

    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _razorpay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      (response) => _handlePaymentSuccess(response, orderDetails: orderDetails),
    );


    var options = {
      'user_id': authUser?.uid ?? '',
      'customer': {
        "email": authUser?.email ?? '',
      },
      "notify": {
        "email": true,
      },
      'email': 'savaliyadarshan96@gmail.com',
      'contact': '812312312',
      'key': 'rzp_test_8q6i0nQ3mc239Y',
      'amount': orderValue * 100,
      'name': 'SwiftBuy',
      'description': 'Enjoy Swiftbuy fast services !',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    _razorpay.open(options);
  }
}
