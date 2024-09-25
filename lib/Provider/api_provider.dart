import 'package:ecommerce_app/Infra/ProductAPI/categariesApi.dart';
import 'package:flutter/foundation.dart';

import '../Domain/ProductModel/categories_model.dart';
import '../Domain/ProductModel/product_model.dart';
import '../Infra/ProductAPI/productAPIs.dart';
import '../Infra/ProductAPI/product_by_category.dart';

class ApiProvider with ChangeNotifier {
  List<CategoryModel> categoriesDataList = [];
  List<ProductModel> productDataList=[];
  List<ProductModel> productByCategoriesData=[];


  Future<void> CategoryApi() async {

    categoriesDataList = await ApiService.getAllCategories();
    notifyListeners();
  }

  Future<void> ProductApi() async {
    productDataList = await ProductApiData().getAllProductData();
    notifyListeners();
  }


  Future<void> ProductByCategories({required String Id}) async{

    productByCategoriesData = await ProductByCategory().CategorieOfProductData(Id: Id);
    notifyListeners();
  }
}
