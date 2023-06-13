import 'package:em_test/models/category_model.dart';
import 'package:em_test/models/dish_model.dart';
import 'package:equatable/equatable.dart';

abstract class DishesState extends Equatable {}

class DishesLoadingState extends DishesState {
  @override
  List<Object?> get props => [];
}

class DishesLoadedState extends DishesState {
  DishesLoadedState(this.dishes);
  final List<DishModel> dishes;
  @override
  List<Object?> get props => [dishes];
}

class DishesLoadingErrorState extends DishesState {
  DishesLoadingErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
