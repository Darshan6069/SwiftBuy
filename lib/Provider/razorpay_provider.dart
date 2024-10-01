import 'package:ecommerce_app/Infra/PaymentService/payment_service.dart';
import 'package:flutter/material.dart';

class RazorpayProvider with ChangeNotifier{

  void getPayment({required double orderValue}){
    PaymentService().getPaymentService(orderValue: orderValue);
    notifyListeners();
  }

}