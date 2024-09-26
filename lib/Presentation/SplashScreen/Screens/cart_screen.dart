import 'package:ecommerce_app/Presentation/common/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Provider/ProductCartProvider/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).GetProductToCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                CupertinoIcons.back,
                color: Colors.white,
              )),
          title: const Text('Cart',
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Consumer<CartProvider>(builder: (context, value, index) {
                return value.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: value.cartProductList.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: value.cartProductList[index],
                            showDeleteIcon: true,
                          );
                        },
                      );
              }),
              Consumer<CartProvider>(builder: (context, value, child) {
                return Text(value.totalCartProductValue.toStringAsFixed(2));
              })
            ],
          ),
        )));
  }
}
