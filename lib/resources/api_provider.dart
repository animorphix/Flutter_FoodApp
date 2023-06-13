// import 'package:dio/dio.dart';
// import 'package:em_test/models/category_model.dart';

// class CategoryProvider {
//   final Dio _dio = Dio();
//   final String _url =
//       'https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54';

//   Future<CategoryListModel> fetchCategoryList() async {
//     try {
//       Response response = await _dio.get(_url);
//       return CategoryListModel.fromJson(response.data);
//     } catch (error) {
//       rethrow;
//     }
//   }
// }
