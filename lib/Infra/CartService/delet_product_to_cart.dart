import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Domain/ProductModel/product_model.dart';
import '../../fire_store_collection.dart';

class DeletProductToCart {


  static Future<void> deleteProductFromCart(String productId) async{
    final fireStore = FirebaseFirestore.instance;
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final cartRef =  fireStore.collection(FireStoreCollection.cart).doc(userId);

    final currentProducts = await cartRef.get();
    List<dynamic> currentProductList = await currentProducts.data() ?['products'] ?? [];
     List<ProductModel> productList = currentProductList.map((e) => ProductModel.fromJson(e)).toList();

    productList.removeWhere((e)=>(productId==e.id.toString()));
    final productData = {
      'products': productList.map((e) => e.toJson()).toList(),
    };
     await cartRef.update(productData);

  }


  static Future<void> DecreaseQnt(String productId) async {
    final fireStore = FirebaseFirestore.instance;
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final cartRef = fireStore.collection(FireStoreCollection.cart).doc(userId);

    final currentProducts = await cartRef.get();
    List<dynamic> currentProductList = currentProducts.data()?['products'] ?? [];

    // Convert the product data to a list of ProductModel objects
    final productList = currentProductList.map((e) => ProductModel.fromJson(e)).toList();

    // Find the product in the cart by ID
    for (var element in productList)
    {
      if (productId==element.id.toString() ) {
        element.quantity != null
            ? (element.quantity! > 1
            ? element.quantity = element.quantity! - 1 // Decrease quantity if more than 1
            : productList.removeWhere((e)=>(productId==e.id.toString()))) // Remove the product if quantity is 1
            : null;

        // Update the cart with the new product list
        final productData = {
          'products': productList.map((e) => e.toJson()).toList(),
        };
        await cartRef.update(productData);
        return;
      }
    }
  }


}
