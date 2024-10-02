import 'package:ecommerce_app/Core/extension.dart';
import 'package:ecommerce_app/Presentation/common/order_product_card.dart';
import 'package:ecommerce_app/Provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderProvider>(context, listen: false).getAllOrderProductData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Product'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, value, child) {
          return (value.orderProductList.isEmpty)
              ? const Center(child: Text('No data'))
              : Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.orderProductList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.push(
                              context,
                              target: OrderProductCard(
                                orderProduct:
                                    value.orderProductList[index].products,
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: context.screenHeight(context) * .10,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                        value.orderProductList[index]
                                                .userEmail ??
                                            '',
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }));
        },
      ),
    );
  }
}
