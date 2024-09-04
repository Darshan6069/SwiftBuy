import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/Domain/ProductModel/product_model.dart';

class LoadProductApiData {


  Future<List<ProductModel>> ProductApi() async {
    List<ProductModel> productDataList=[];
    http.Response res =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    print(res);
    var d = jsonDecode(res.body);
    for (var e in d) {
      productDataList.add(ProductModel.fromJson(e));
    }
    return productDataList;
  }


}
