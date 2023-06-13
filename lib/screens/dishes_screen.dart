//import 'package:em_test/bloc/cart_bloc/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../bloc/app_blocs.dart';
import '../bloc/app_events.dart';
import '../bloc/app_states.dart';
import '../bloc/cart_bloc/cart_bloc.dart';
//import '../bloc/cart_bloc/cart_state.dart';
import '../bloc/dishes_bloc/dishes_bloc.dart';
import '../bloc/dishes_bloc/dishes_event.dart';
import '../bloc/dishes_bloc/dishes_state.dart';
import '../resources/api_repository.dart';
import '../models/dish_model.dart';
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

class DishesScreen extends StatefulWidget {
  const DishesScreen({Key? key}) : super(key: key);

  @override
  _DishesScreenState createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  String? selectedTag;
  int? selectedDishIndex;

  void onImageClicked(int index) {
    setState(() {
      selectedDishIndex = index;
    });
  }

  void onTagSelected(String tag) {
    setState(() {
      if (selectedTag == tag) {
        selectedTag = null;
      } else {
        selectedTag = tag;
      }
    });
  }

  bool isDishMatchFilter(DishModel dish) {
    if (selectedTag == null) {
      return true;
    }

    return dish.tegs.contains(selectedTag);
  }

  void closeCard() {
    setState(() {
      selectedDishIndex = null;
    });
  }

  Widget buildDishCard(DishModel dish) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              // Handle favorite button click
                            },
                            icon: Icon(Icons.favorite_border),
                          ),
                          IconButton(
                            onPressed: closeCard,
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 230,
                      child: Image.network(
                        dish.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    dish.name,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${dish.price} ₽',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(' · '),
                      Text(
                        '${dish.weight} г',
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black.withOpacity(0.4)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        dish.description,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    if (state is CartLoaded) {
                      context.read<CartBloc>().add(AddProduct(dish));
                      print(state.cart.products);
                    }
                  },
                  child: Text('Добавить в корзину'),
                )
                //icon: const Icon(Icons.add_shopping_cart))
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          alignment: Alignment.centerLeft,
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
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

            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: tags.length,
                        itemBuilder: (context, index) {
                          final tag = tags[index];
                          final isSelected = (selectedTag == tag);
                          return GestureDetector(
                            onTap: () => onTagSelected(tag),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 11.0,
                              ),
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blueAccent
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<DishesBloc, DishesState>(
                        builder: (context, state) {
                          if (state is DishesLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is DishesLoadedState) {
                            List<DishModel> dishesList = state.dishes;
                            List<DishModel> filteredDishes = dishesList
                                .where((dish) => isDishMatchFilter(dish))
                                .toList();

                            return GridView.builder(
                              padding: const EdgeInsets.all(8.0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 10.0,
                              ),
                              itemCount: filteredDishes.length,
                              itemBuilder: (context, index) {
                                final dish = filteredDishes[index];
                                return GestureDetector(
                                  onTap: () => onImageClicked(index),
                                  child: Card(
                                    color: const Color(0xFFF8F7F5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top:
                                                    const Radius.circular(10.0),
                                              ),
                                              image: DecorationImage(
                                                image:
                                                    NetworkImage(dish.imageUrl),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            dish.name,
                                            style:
                                                const TextStyle(fontSize: 16.0),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                if (selectedDishIndex != null)
                  buildDishCard(dishesList[selectedDishIndex!])
              ],
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
