import 'package:ecommerce_app/Infra/CartService/order_product_data.dart';
import 'package:flutter/foundation.dart';

import '../Domain/orders/order_details.dart';

class OrderProvider with ChangeNotifier{
  List<OrderDetails> orderProductList=[];

  Future<void> getAllOrderProductData()async{
    orderProductList= await OrderProductData().getOrderData();
    notifyListeners();
  }
}