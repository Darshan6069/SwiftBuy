import 'package:ecommerce_app/Core/extension.dart';
import 'package:ecommerce_app/Domain/orders/order_details.dart';
import 'package:flutter/material.dart';

import '../../Domain/ProductModel/product_model.dart';
import 'product_card.dart';

class OrderProductCard extends StatelessWidget {
  const OrderProductCard({super.key,required this.orderProduct});
  final List<ProductModel> orderProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: orderProduct.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: orderProduct[index],
              showDeleteIcon: true,
            );
          },
        ),
      ),
    );
  }
}
