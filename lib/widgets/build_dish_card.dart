import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc/cart_bloc.dart';
import '../models/dish_model.dart';

Widget buildDishCard(DishModel dish, closeCard()) {
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
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
                          fontSize: 16.0, color: Colors.black.withOpacity(0.4)),
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
              ElevatedButton(
                onPressed: () {
                  if (state is CartLoaded) {
                    context.read<CartBloc>().add(AddProduct(dish));
                    print(state.cart.products);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3364E0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Container(
                  height: 48,
                  width: 311,
                  child: const Center(
                    child: Text(
                      'Добавить в корзину',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
              //icon: const Icon(Icons.add_shopping_cart))
            ],
          ),
        );
      },
    ),
  );
}
