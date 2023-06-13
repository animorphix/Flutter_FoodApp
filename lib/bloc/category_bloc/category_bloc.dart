import 'package:em_test/resources/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc(this._categoryRepository) : super(CategoryLoadingState()) {
    on<CategoryEvent>((event, emit) async {
      emit(CategoryLoadingState());

      try {
        final categories = await _categoryRepository.getCategoryList();
        emit(CategoryLoadedState(categories));
      } catch (e) {
        emit(CategoryLoadingErrorState(e.toString()));
      }
    });
  }
}
