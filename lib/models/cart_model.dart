import 'package:em_test/models/dish_model.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final List<DishModel> products;
  const Cart({this.products = const <DishModel>[]});

  double get total =>
      products.fold(0, (total, current) => total + current.price);

  @override
  List<Object?> get props => [products];
}
