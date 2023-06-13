import 'package:equatable/equatable.dart';

abstract class DishesEvent extends Equatable {
  const DishesEvent();
}

class LoadDishesEvent extends DishesEvent {
  @override
  List<Object> get props => [];
}
