import 'package:ecommerce_app/Core/extension.dart';
import 'package:ecommerce_app/Domain/ProductModel/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {}, icon: const Icon(CupertinoIcons.back, size: 30,)),
            const Text('Product Detail'),
            IconButton(
                onPressed: () {}, icon: const Icon(CupertinoIcons.heart, size: 30,)),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: const [],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              height: context.screenHeight(context) * 0.45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.red
              ),
            ),
          )
        ],
      ),
    );
  }
}
