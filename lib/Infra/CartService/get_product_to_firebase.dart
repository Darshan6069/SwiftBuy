import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Domain/ProductModel/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../fire_store_collection.dart';


class GetProductToFirebase {

  List<ProductModel> cartProductList = [];
  double totalCartValue = 0;


  Future<List<ProductModel>> getCartProduct() async {
    final fireStore = FirebaseFirestore.instance;
    final userId = FirebaseAuth.instance.currentUser?.uid;
    cartProductList = [];

    final cartRef = await fireStore.collection(FireStoreCollection.cart).doc(
        userId).get();
    final productList = await cartRef.data()?['products'];

    for (var product in productList) {
      cartProductList.add(ProductModel.fromJson(product));
    }
    return cartProductList;
  }



}