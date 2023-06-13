import 'package:em_test/screens/dishes_screen.dart';
import 'package:em_test/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/app_blocs.dart';
import '../bloc/app_events.dart';
import '../bloc/app_states.dart';
import '../bloc/category_bloc/category_bloc.dart';
import '../bloc/category_bloc/category_event.dart';
import '../bloc/category_bloc/category_state.dart';
import '../models/category_model.dart';
import '../resources/api_repository.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  //const Home(Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => CategoryRepository(),
        child: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final formattedDate = DateFormat('dd.MM').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(
        RepositoryProvider.of<CategoryRepository>(context),
      )..add(LoadCategoriesEvent()),
      child: Scaffold(
        appBar: CustomAppBar(
          location: 'Санкт-Петербург',
          formattedDate: formattedDate,
          imageUrl: 'https://xsgames.co/randomusers/assets/avatars/male/8.jpg',
        ),
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CategoryLoadedState) {
              List<CategoryModel> categoryList = state.categories;
              return ListView.builder(
                  itemCount: categoryList.length,
                  itemBuilder: (_, index) {
                    return Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Ink.image(
                              image: NetworkImage(categoryList[index].imageUrl),
                              fit: BoxFit.cover,
                              height: 148,
                              child: InkWell(onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DishesMainScreen()));
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 12, 0, 0),
                              child: Text(
                                categoryList[index].name,
                                style: const TextStyle(
                                  fontFamily: '.SF Pro Display',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,

                                  //height: 25,
                                ),
                              ),
                            ),
                          ],
                        ));
                  });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
