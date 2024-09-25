import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../Domain/ProductModel/product_model.dart';

class ProductByCategory {
  Future<List<ProductModel>> CategorieOfProductData({required String Id}) async {
    List<ProductModel> productByCategoriesData = [];
    http.Response res =
    await http.get(Uri.parse('https://fakestoreapi.com/products/category/$Id'));
    var d = jsonDecode(res.body);
    for (var e in d) {


      productByCategoriesData.add(ProductModel.fromJson(e));
    }
    return productByCategoriesData;
  }
}