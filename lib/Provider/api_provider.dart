import 'package:ecommerce_app/Infra/ProductAPI/categariesApi.dart';
import 'package:flutter/foundation.dart';

import '../Domain/ProductModel/categories_model.dart';
import '../Domain/ProductModel/product_model.dart';
import '../Infra/ProductAPI/productAPIs.dart';

class ApiProvider with ChangeNotifier {
  List<CategoryModel> categoriesDataList = [];
  List<ProductModel> productDataList=[];

  CategoryApi() async {

    categoriesDataList = await ApiService.getAllCategories();
    notifyListeners();
  }

  ProductApi() async {
    productDataList = await LoadProductApiData().ProductApi();
    notifyListeners();
  }
}
