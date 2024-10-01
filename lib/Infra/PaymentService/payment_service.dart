import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Domain/ProductModel/product_model.dart';
import 'package:ecommerce_app/Domain/orders/order_details.dart';
import 'package:ecommerce_app/fire_store_collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uuid/uuid.dart';

class PaymentService {
  final _razorpay = Razorpay();
  final _firestore = FirebaseFirestore.instance;
  final uuid = const Uuid();

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response,
      {required OrderDetails orderDetails}) async {
    await _placeOrder(
      orderDetails: orderDetails.copyWith(paymentId: response.paymentId),
    );
    await _clearBasket();
  }

  Future<void> _placeOrder({required OrderDetails orderDetails}) async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return;
    // var orderList = await _firestore
    //     .collection(FireStoreCollection.orders)
    //     .doc(currentUserId)
    //     .get();
    // List<dynamic> updated = orderList.data()?['orders'] ?? [];

    final orderData = {
      'orders': orderDetails.toJson(),
    };
    await _firestore
        .collection(FireStoreCollection.orders)
        .doc(currentUserId)
        .update(orderData);
  }

  Future<void> _clearBasket() async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return;
    final productData = {
      'products': [],
    };
    await _firestore
        .collection(FireStoreCollection.cart)
        .doc(currentUserId)
        .update(productData);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

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
