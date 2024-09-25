import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Domain/ProductModel/product_model.dart';
import '../../Provider/ProductCartProvider/cart_provider.dart';
import '../../Provider/api_provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key, required this.product, this.showDeleteIcon = false});

  final bool showDeleteIcon;
  final ProductModel product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                width: .5,
              ),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => DiscriptionScreen(products: product)));
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: height * .18,
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage(widget.product.image ?? ''),
                                  fit: BoxFit.contain),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: height * 0.020,
                                  width: width * 0.11,
                                  decoration: BoxDecoration(
                                      // color:value.getTheme == true ?  Colors.black87 : Colors.white70,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        CupertinoIcons.star_fill,
                                        size: 14,
                                        color: (widget.product.rating!.rate! <=
                                                2)
                                            ? Colors.red
                                            : (widget.product.rating!.rate! <=
                                                    3.5)
                                                ? Colors.orange
                                                : Colors.green,
                                      ),
                                      Text(
                                        ' ${widget.product.rating?.rate}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  // backgroundColor: value.getTheme == true ?  Colors.black87 : Colors.white54,
                                  radius: height * 0.020,
                                  child: Center(
                                      child: IconButton(
                                          icon: const Icon(CupertinoIcons.heart,
                                              size: 22),
                                          onPressed: () {})),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .01),
                    Text(
                      widget.product.category ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Text(
                      widget.product.title ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Consumer<CartProvider>(builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$ ${widget.product.price}',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          if (widget.showDeleteIcon) ...[
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      if (widget.product.id != null) {
                                        await value
                                            .addProductToCart(widget.product);
                                        if (!context.mounted) return;
                                        await value.GetProductToCart();
                                      }
                                    },
                                    icon: Icon(CupertinoIcons.plus)),
                                Text(
                                  widget.product.quantity.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                IconButton(
                                    onPressed: () async {
                                      if (widget.product.id != null) {
                                        await value
                                            .DecreaseQnty(widget.product.id.toString());
                                        if (!context.mounted) return;
                                        await value.GetProductToCart();
                                      }
                                    },
                                    icon: Icon(CupertinoIcons.minus)),
                              ],
                            )
                          ],
                          if (!widget.showDeleteIcon)
                            IconButton(
                                onPressed: () async {
                                  await value.addProductToCart(widget.product);
                                },
                                icon: const Icon(CupertinoIcons.cart)),
                          if (widget.showDeleteIcon) ...[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.01,
                            ),
                            IconButton(
                                onPressed: () async {
                                  if (widget.product.id != null) {
                                    await value
                                        .DeleteProduct(widget.product.id.toString());
                                    if (!context.mounted) return;
                                    await value.GetProductToCart();
                                  }
                                },
                                icon: const Icon(CupertinoIcons.delete))
                          ],
                        ],
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
