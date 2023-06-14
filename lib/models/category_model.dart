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
}
