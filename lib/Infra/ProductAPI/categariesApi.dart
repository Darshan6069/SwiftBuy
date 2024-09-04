import 'package:dio/dio.dart';

import '../../Domain/ProductModel/categories_model.dart';

class ApiService {
  static final _dio = Dio();

  static Future<List<CategoryModel>> getAllCategories() async {
    List<CategoryModel> categoriesDataList = [];
    final response =
        await _dio.get("https://fakestoreapi.com/products/categories");
    final categoryList = response.data;

    for (int i = 0; i < categoryList.length; i++) {
      categoriesDataList.add(
        CategoryModel(
          id: categoryList[i],
          name: categoryList[i].toUpperCase(),
        ),
      );
    }

    return categoriesDataList;
  }
}
