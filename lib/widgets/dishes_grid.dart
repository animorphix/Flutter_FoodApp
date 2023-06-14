import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/dishes_bloc/dishes_bloc.dart';
import '../bloc/dishes_bloc/dishes_state.dart';
import '../models/dish_model.dart';
import 'build_dish_card.dart';

class DishesGrid extends StatefulWidget {
  final List<String> tags;
  final List<DishModel> dishesList;

  const DishesGrid({
    Key? key,
    required this.tags,
    required this.dishesList,
  }) : super(key: key);

  @override
  _DishesGridState createState() => _DishesGridState();
}

class _DishesGridState extends State<DishesGrid> {
  String? selectedTag = null;
  int? selectedDishIndex;

  void onImageClicked(int index) {
    final dish = widget.dishesList[index];
    void closeCard() {
      Navigator.of(context, rootNavigator: true).pop(context);
    }

    showDialog(
        context: context,
        builder: (context) => Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 50, 16, 100),
                child: AlertDialog(
                  content: buildDishCard(dish, closeCard),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ));
  }

  void onTagSelected(String tag) {
    setState(() {
      if (selectedTag != tag) {
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.tags.length,
                itemBuilder: (context, index) {
                  final tag = widget.tags[index];
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
                        color:
                            isSelected ? Colors.blueAccent : Colors.grey[100],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
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
                    if (selectedTag == null && widget.tags.isNotEmpty) {
                      selectedTag = widget.tags[0];
                    }
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                        top: const Radius.circular(10.0),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(dish.imageUrl),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    dish.name,
                                    style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.left,
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
          buildDishCard(widget.dishesList[selectedDishIndex!], closeCard)
      ],
    );
  }
}
