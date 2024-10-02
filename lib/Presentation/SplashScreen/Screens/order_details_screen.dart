import 'package:ecommerce_app/Core/extension.dart';
import 'package:ecommerce_app/Presentation/SplashScreen/Screens/order_product_card.dart';
import 'package:ecommerce_app/Provider/order_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/product_card.dart';

class OrderDetailsScreen extends StatefulWidget {
  const  OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
@override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context,listen: false).getAllOrderProductData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Product'),
      ),
      body: Consumer<OrderProvider>(builder: (context, value, child) {
        return (value.orderProductList.isEmpty)?const Center(child: Text('No data')):Container(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: value.orderProductList.length,
            itemBuilder: (context, index) {
              return  OrderProductCard(orderProduct: value.orderProductList[index].products);
            },
          ),
        );
      },),
    );
  }
}
