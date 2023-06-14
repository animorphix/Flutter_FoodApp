import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../bloc/app_blocs.dart';
import '../bloc/app_events.dart';
import '../bloc/app_states.dart';
import '../bloc/cart_bloc/cart_bloc.dart';
import '../bloc/dishes_bloc/dishes_bloc.dart';
import '../bloc/dishes_bloc/dishes_event.dart';
import '../bloc/dishes_bloc/dishes_state.dart';
import '../resources/api_repository.dart';
import '../models/dish_model.dart';
import '../widgets/build_dish_card.dart';
import '../widgets/custom_dishes_app_bar.dart';
import '../widgets/dishes_grid.dart';
import './home_screen.dart';

class DishesMainScreen extends StatelessWidget {
  const DishesMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DishesRepository(),
        ),
        BlocProvider(
          create: (context) => DishesBloc(
            RepositoryProvider.of<DishesRepository>(context),
          )..add(LoadDishesEvent()),
        )
      ],
      child: DishesScreen(),
    );
  }
}

class DishesScreen extends StatelessWidget {
  const DishesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomDishesAppBar(),
      body: BlocBuilder<DishesBloc, DishesState>(
        builder: (context, state) {
          List<String> tags = [];

          if (state is DishesLoadedState) {
            List<DishModel> dishesList = state.dishes;
            for (var element in dishesList) {
              for (var tag in element.tegs) {
                if (!tags.contains(tag)) {
                  tags.add(tag);
                }
              }
            }
            tags.sort();
            print(tags);

            return DishesGrid(
              tags: tags,
              dishesList: dishesList,
            );
          } else if (state is DishesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
