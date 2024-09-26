import 'package:ecommerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Provider/api_provider.dart';
import '../../common/product_card.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.iD});
  final String iD;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isLoad = false;
  @override
  void initState() {
    super.initState();
    Provider.of<ApiProvider>(context, listen: false)
        .ProductByCategories(Id: widget.iD);
  }

  @override
  Widget build(BuildContext context) {
    var height = context.screenHeight(context);

    return Scaffold(
      appBar: AppBar(),
      body: (isLoad == true)
          ? const CircularProgressIndicator()
          : SingleChildScrollView(child:
              Consumer<ApiProvider>(builder: (context, productPro, child) {
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisExtent: height * 0.359,
                      mainAxisSpacing: 8),
                  itemCount: productPro.productByCategoriesData.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: productPro.productByCategoriesData[index],
                    );
                  });
            })),
    );
  }
}
