import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Domain/ProductModel/product_model.dart';
import '../../fire_store_collection.dart';

class AddProductCart {
  static Future<dynamic> addProductToCart(ProductModel product) async {
    final fireStore = FirebaseFirestore.instance;
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final cartRef = fireStore.collection(FireStoreCollection.cart).doc(userId);

    final currentProducts = await cartRef.get();
    List<dynamic> currentProductList =
        currentProducts.data()?['products'] ?? [];

//-------  add  first item -----------------
    if (currentProductList.isEmpty) {
      currentProductList.add(product.toJson());
      final productData = {'products': currentProductList};
      await cartRef.update(productData);
      return;
    }

// ------- add existing product in cart (increase Quantity)-----------------
    for (var element in currentProductList) {
      if (element['id'] == product.id) {
        element['quantity']++;
        final productData = {'products': currentProductList};

        await cartRef.update(productData);
        return;
      }
    }
// ------- add new product in cart -----------------
    currentProductList.add(product.toJson());
    final productData = {'products': currentProductList};

    await cartRef.update(productData);
  }




}
