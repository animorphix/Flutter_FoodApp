// class CategoryListModel {
//   CategoryListModel({
//     required this.categories,
//   });
//   late final List<CategoryModel> categories;

//   // CategoryListModel.fromJson(Map<String, dynamic> json){
//   //   categories = List<CategoryModel>.from(json['сategories']).map((e)=>categories.fromJson(e)).toList<CategoryModel();
//   // }
//   CategoryListModel.fromJson(Map<String, dynamic> json) {
//     if (json['categories'] != null) {
//       json['categories'].forEach((v) {
//         categories.add(CategoryModel.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['categories'] = categories.map((e) => e.toJson()).toList();
//     return _data;
//   }
// }

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  late final int id;
  late final String name;
  late final String imageUrl;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'], name: json['name'], imageUrl: json['image_url']);
  }

  // Map<String, dynamic> toJson() {
  //   final _data = <String, dynamic>{};
  //   _data['id'] = id;
  //   _data['name'] = name;
  //   _data['image_url'] = imageUrl;
  //   return _data;
  // }
}
