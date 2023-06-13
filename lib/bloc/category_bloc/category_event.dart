import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class LoadCategoriesEvent extends CategoryEvent {
  @override
  List<Object> get props => [];
}
