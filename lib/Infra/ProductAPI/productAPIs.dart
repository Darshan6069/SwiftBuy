import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/Domain/ProductModel/product_model.dart';

class ProductApiData {
  Future<List<ProductModel>> getAllProductData() async {
    List<ProductModel> productDataList = [];
    http.Response res =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    var d = jsonDecode(res.body);
    for (var e in d) {
      productDataList.add(ProductModel.fromJson(e));
    }
    return productDataList;
  }
}
