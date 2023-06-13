// import 'package:em_test/resources/api_repository.dart';

// import 'app_events.dart';
// import 'app_states.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
//   final CategoryRepository _categoryRepository;

//   CategoryBloc(this._categoryRepository) : super(CategoryLoadingState()) {
//     on<CategoryEvent>((event, emit) async {
//       emit(CategoryLoadingState());

//       try {
//         final categories = await _categoryRepository.getCategoryList();
//         emit(CategoryLoadedState(categories));
//       } catch (e) {
//         emit(CategoryLoadingErrorState(e.toString()));
//       }
//     });
//   }
// }

// class DishesBloc extends Bloc<DishesEvent, DishesState> {
//   final DishesRepository _dishesRepository;

//   DishesBloc(this._dishesRepository) : super(DishesLoadingState()) {
//     on<DishesEvent>(
//       (event, emit) async {
//         emit(DishesLoadingState());
//         print('dishes loading');
//         try {
//           print(1);
//           final dishes = await _dishesRepository.getDishesList();
//           print(2);
//           emit(DishesLoadedState(dishes));
//           print('dishes loaded');
//         } catch (e) {
//           emit(DishesLoadingErrorState(e.toString()));
//           print('error occured, ${e}');
//         }
//       },
//     );
//   }
// }
