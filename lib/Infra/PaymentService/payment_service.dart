import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService {
  final _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  void getPaymentService({required int orderValue}) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    var options = {
      'email': 'savaliyadarshan96@gmail.com',
      'contact': '812312312',
      'key': 'rzp_test_8q6i0nQ3mc239Y',
      'amount': orderValue,
      'name': 'SwiftBuy',
      'description': 'Enjoy Swiftbuy fast services !',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    _razorpay.open(options);
  }
}
