import 'package:flutter/material.dart';

import '../../Domain/ProductModel/product_model.dart';
import '../../Infra/CartService/add_product_cart.dart';
import '../../Infra/CartService/delet_product_to_cart.dart';
import '../../Infra/CartService/get_product_to_firebase.dart';

class CartProvider with ChangeNotifier {
  bool isLoading = false;
  List<ProductModel>  cartProductList=[];

  void setLoading(bool val) {
    isLoading = val;
  }

  Future<void> addProductToCart(ProductModel product) async {
    await AddProductCart.addProductToCart(product);
    notifyListeners();
  }

  Future<void> GetProductToCart() async {
    setLoading(true);
    cartProductList = await GetProductToFirebase().getCartProduct();
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
