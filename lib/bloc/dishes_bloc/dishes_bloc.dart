import 'package:em_test/resources/api_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'dishes_event.dart';
import 'dishes_state.dart';

class DishesBloc extends Bloc<DishesEvent, DishesState> {
  final DishesRepository _dishesRepository;

  DishesBloc(this._dishesRepository) : super(DishesLoadingState()) {
    on<DishesEvent>(
      (event, emit) async {
        emit(DishesLoadingState());
        print('dishes loading');
        try {
          print(1);
          final dishes = await _dishesRepository.getDishesList();
          print(2);
          emit(DishesLoadedState(dishes));
          print('dishes loaded');
        } catch (e) {
          emit(DishesLoadingErrorState(e.toString()));
          print('error occured, ${e}');
        }
      },
    );
  }
}
