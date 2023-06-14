import 'package:em_test/models/dish_model.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final List<DishModel> products;
  const Cart({this.products = const <DishModel>[]});

  @override
  List<Object?> get props => [products];

  Map productQuantity() {
    var quantity = Map();

    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });

    return quantity;
  }

  double get total =>
      products.fold(0, (total, current) => total + current.price);
}
