// import 'package:em_test/models/category_model.dart';

// import 'api_provider.dart';

// class CategoryRepository {
//   final _provider = CategoryProvider();

//   Future<CategoryListModel> fetchCategoryList() {
//     return _provider.fetchCategoryList();
//   }
// }

// class NetworkError extends Error {}

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:em_test/models/category_model.dart';
import 'package:em_test/models/dish_model.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  String endpoint =
      'https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54';

  Future<List<CategoryModel>> getCategoryList() async {
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final jsonList =
          json.decode(response.body)['сategories'] as List<dynamic>;
      return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  // final Dio _dio = Dio();
  // final String _url =
  //     'https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54';

  // Future<List<CategoryModel>> fetchCategoryList() async {
  //   var response = await _dio.get(_url);
  //   if (response.statusCode == 200) {
  //     print(response.data);
  //     final jsonList =
  //         json.decode(response.data)['сategories'] as List<dynamic>;
  //     return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
  //   } else {
  //     throw Exception(response.statusMessage);
  //   }

  //return CategoryModel.fromJson(response.data);
  //}
}

class DishesRepository {
  String endpoint =
      'https://run.mocky.io/v3/c7a508f2-a904-498a-8539-09d96785446e';

  Future<List<DishModel>> getDishesList() async {
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final dishesData = jsonData['dishes'] as List<dynamic>;

      return dishesData.map((dishData) {
        return DishModel.fromJson(dishData);
      }).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
