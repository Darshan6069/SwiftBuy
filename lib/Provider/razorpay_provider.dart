import 'package:ecommerce_app/Domain/ProductModel/product_model.dart';
import 'package:ecommerce_app/Infra/PaymentService/payment_service.dart';
import 'package:flutter/material.dart';

class RazorpayProvider with ChangeNotifier {
  void getPayment(
      {required int orderValue, required List<ProductModel> products}) {
    PaymentService()
        .getPaymentService(orderValue: orderValue, products: products);
    notifyListeners();
  }
}
