import 'package:flutter/material.dart';

import '../../Domain/ProductModel/product_model.dart';
import '../../Infra/CartService/add_product_cart.dart';
import '../../Infra/CartService/delet_product_to_cart.dart';
import '../../Infra/CartService/get_product_to_firebase.dart';

class CartProvider with ChangeNotifier {
  bool isLoading = false;
  List<ProductModel>  cartProductList=[];
   double totalCartProductValue =0;

  void loding(bool val) {
    isLoading = val;
  }

  Future<void> addProductToCart(ProductModel product) async {
    await AddProductCart.addProductToCart(product);
    totalOfItem();
    notifyListeners();
  }

  Future<void> GetProductToCart() async {
    loding(true);
    cartProductList = await GetProductToFirebase().getCartProduct();
    totalOfItem();
    loding(false);
    notifyListeners();
  }

  Future<void> DeleteProduct(String productId) async {
    loding(true);
    await DeletProductToCart.deleteProductFromCart(productId);
    loding(false);
    totalOfItem();
    notifyListeners();
  }

  Future<void> DecreaseQnty(String productId) async {
    loding(true);
    await DeletProductToCart.DecreaseQnt(productId);
    totalOfItem();
    loding(false);
    notifyListeners();
  }

  void totalOfItem() {
    totalCartProductValue =0;
    for (var element in cartProductList) {
      double productVal = double.parse(element.quantity.toString()) *
          double.parse(element.price.toString());
      totalCartProductValue = totalCartProductValue + productVal;
    }
  }
}
