import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/cart_bloc/cart_bloc.dart';
import '../models/cart_model.dart';
import '../widgets/custom_app_bar.dart';

class CartScreen extends StatelessWidget {
  final formattedDate = DateFormat('dd.MM').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        location: 'Санкт-Петербург',
        formattedDate: formattedDate,
        imageUrl: 'https://xsgames.co/randomusers/assets/avatars/male/8.jpg',
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            return ListView.builder(
              itemCount: state.cart.products.length,
              itemBuilder: (context, index) {
                final cartItem = state.cart.products[index];
                return ListTile(
                  leading: Image.network(cartItem.imageUrl),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartItem.name),
                      Row(
                        children: [
                          Text('${cartItem.price.toStringAsFixed(2)} ₽'),
                          const Text(' · '),
                          Text(
                            ' ${cartItem.weight.toString()} г',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.4)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(AddProduct(cartItem));
                    },
                    child: Text('Add'),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
      persistentFooterButtons: [
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoaded) {
              double totalCost = state.cart.products
                  .fold(0.0, (sum, item) => sum + item.price);

              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3364E0), // Button color
                  elevation: 0, // Remove shadow
                  minimumSize: Size.fromHeight(48),
                  // Button height
                ),
                onPressed: () {
                  // Handle payment
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Оплатить ${totalCost.toStringAsFixed(2)} ₽'),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
