import 'package:flutter/material.dart';

import '../../Domain/ProductModel/product_model.dart';
import '../../Infra/CartService/add_product_cart.dart';
import '../../Infra/CartService/delet_product_to_cart.dart';
import '../../Infra/CartService/get_product_to_firebase.dart';

class CartProvider with ChangeNotifier {
  bool isLoading = false;
  List<ProductModel> cartProductList = [];
  double cartValue = 0;

  void setLoading(bool val) {
    isLoading = val;
  }

  void totalCartValue() {
    cartValue = 0;
    for (var product in cartProductList) {
      cartValue = cartValue +
          (product.price * double.parse(product.quantity.toString()));
    }
  }

  Future<void> addProductToCart(ProductModel product) async {
    setLoading(true);
    await AddProductCart.addProductToCart(product);
    setLoading(false);
    notifyListeners();
  }

  Future<void> GetProductToCart() async {
    setLoading(true);
    cartProductList = await GetProductToFirebase().getCartProduct();
    totalCartValue();
    setLoading(false);
    notifyListeners();
  }

  Future<void> DeleteProduct(String productId) async {
    setLoading(true);
    await DeletProductToCart.deleteProductFromCart(productId);
    setLoading(false);
    
    notifyListeners();
  }

  Future<void> DecreaseQnty(String productId) async {
    setLoading(true);
    await DeletProductToCart.DecreaseQnt(productId);
    
    setLoading(false);
    notifyListeners();
  }


}
