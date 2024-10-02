import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Domain/orders/order_details.dart';
import '../../fire_store_collection.dart';

class OrderProductData {
  final fireStore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser?.uid;
  List<OrderDetails> orderProductList=[];

//==========================================place order=-=-=-===-=-==-=============
  Future<void> placeOrder({required OrderDetails orderDetails}) async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return;
    // var orderList = await _firestore
    //     .collection(FireStoreCollection.orders)
    //     .doc(currentUserId)
    //     .get();
    // List<dynamic> updated = orderList.data()?['orders'] ?? [];
    final orderRef = fireStore.collection(FireStoreCollection.order).doc(
        currentUserId);

    final currentProduct = await orderRef.get();
    List<dynamic> orderProductList = currentProduct.data()?['order'] ?? [];
    if (orderProductList.isEmpty) {
      orderProductList.add(orderDetails.toJson());
      final productData = {'order': orderProductList};
      await orderRef.update(productData);
      return;
    }



    orderProductList.add(orderDetails.toJson());
    final productData = {'order': orderProductList};

    await orderRef.update(productData);
  }

 //---------------clear Cart--------------------------
  Future<void> clearBasket() async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) return;
    final productData = {
      'products': [],
    };
    await fireStore
        .collection(FireStoreCollection.cart)
        .doc(currentUserId)
        .update(productData);
  }


  Future<List<OrderDetails>> getOrderData()async{
    final orderRef = await fireStore.collection(FireStoreCollection.order).doc(userId).get();
    final productList = await orderRef.data()?['order'];

    for (var product in productList) {
      orderProductList.add(OrderDetails.fromJson(product));
    }
    return orderProductList;
  }



}
