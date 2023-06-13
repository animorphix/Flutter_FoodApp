// class Dish {

//   Dish({required this.dishes});

//   late  List<DishModel> dishes;
//   Dish.fromJson(Map<String, dynamic> json) {
//     if (json['dishes'] != null) {
//       dishes = List<DishModel>();
//       json['dishes'].forEach((v) {
//         dishes.add(DishModel.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.dishes != null) {
//       data['dishes'] = this.dishes.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class DishModel {
  late int id;
  late String name;
  late int price;
  late int weight;
  late String description;
  late String imageUrl;
  late List<String> tegs;

  DishModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.weight,
      required this.description,
      this.imageUrl =
          'https://t4.ftcdn.net/jpg/04/99/93/31/360_F_499933117_ZAUBfv3P1HEOsZDrnkbNCt4jc3AodArl.jpg',
      required this.tegs});

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      weight: json['weight'],
      description: json['description'],
      imageUrl: json['image_url'] ??
          'https://t4.ftcdn.net/jpg/04/99/93/31/360_F_499933117_ZAUBfv3P1HEOsZDrnkbNCt4jc3AodArl.jpg',
      tegs: List<String>.from(json['tegs']),
    );
  }

  // DishModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   price = json['price'];
  //   weight = json['weight'];
  //   description = json['description'];
  //   imageUrl = json['image_url'];
  //   tegs = json['tegs'].cast<String>();
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['weight'] = this.weight;
    data['description'] = this.description;
    data['image_url'] = this.imageUrl;
    data['tegs'] = this.tegs;
    return data;
  }
}
