import 'package:ecommerce_app/Domain/ProductModel/product_model.dart';
import 'package:ecommerce_app/Domain/orders/order_details.dart';
import 'package:ecommerce_app/Infra/CartService/order_product_data.dart';
import 'package:ecommerce_app/Presentation/order/order_confirmation_screen.dart';
import 'package:ecommerce_app/core/extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

class PaymentService {
  final _razorpay = Razorpay();
  final uuid = const Uuid();
  static const _failureSnackBar = SnackBar(
    content: Text(
      "Something went wrong",
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.red,
  );

  Future<void> _handlePaymentSuccess(
    PaymentSuccessResponse response, {
    required OrderDetails orderDetails,
    required BuildContext context,
  }) async {
    await OrderProductData().placeOrder(
      orderDetails: orderDetails.copyWith(paymentId: response.paymentId),
    );
    await OrderProductData().clearBasket();
    if (!context.mounted) return;
    context.pushAndRemoveUntil(
      context,
      target: OrderConfirmationScreen(orderDetails: orderDetails),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response,
      {required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(_failureSnackBar);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  void getPaymentService({
    required int orderValue,
    required List<ProductModel> products,
    required BuildContext context,
  }) {
    final authUser = FirebaseAuth.instance.currentUser;
    final orderDetails = OrderDetails(
      orderId: uuid.v1(),
      timeStamp: DateTime.now(),
      orderValue: orderValue,
      products: products,
      userEmail: authUser?.email,
    );

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_ERROR,
      (response) => _handlePaymentError(
        response,
        context: context,
      ),
    );
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _razorpay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      (response) => _handlePaymentSuccess(response,
          orderDetails: orderDetails, context: context),
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
