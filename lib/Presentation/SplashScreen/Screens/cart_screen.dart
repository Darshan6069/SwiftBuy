import 'dart:developer';

import 'package:ecommerce_app/Presentation/common/product_card.dart';
import 'package:ecommerce_app/core/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../Provider/ProductCartProvider/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    Provider.of<CartProvider>(context, listen: false).GetProductToCart();
  }

  // @override
  // void dispose() {
  //   _razorpay.clear();
  //   super.dispose();
  // }

  void _placeOrder({required double orderValue}) {
    var options = {
      'email': 'vgajjar1010@gmail.com',
      'contact': '7984472376',
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': orderValue,
      'name': 'SwiftBuy',
      'description': 'Enjoy Swiftbuy fast services !',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    log(response.error.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
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
        body: Consumer<CartProvider>(builder: (context, value, index) {
          return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    value.isLoading
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
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total"),
                        Row(
                          children: [
                            const Text("Rs."),
                            Text(value.cartValue.toStringAsFixed(2)),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: context.screenHeight(context) * 0.01,
                    ),
                    TextButton(
                      onPressed: () => _placeOrder(
                        orderValue: value.cartValue,
                      ),
                      child: const Text("Place Order"),
                    ),
                  ],
                ),
              ));
        }));
  }
}
