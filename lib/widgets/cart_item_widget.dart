import 'package:em_test/models/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc/cart_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final DishModel cartItem;
  final int quantity;

  const CartItemWidget({required this.cartItem, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(cartItem.imageUrl),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItem.name,
              ),
              Row(
                children: [
                  Text('${cartItem.price.toStringAsFixed(2)} ₽'),
                  const Text(' · '),
                  Text(
                    ' ${cartItem.weight.toString()} г',
                    style: TextStyle(color: Colors.black.withOpacity(0.4)),
                  ),
                ],
              ),
            ],
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
            color: Colors.grey[200],
            child: Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(RemoveProduct(cartItem));
                    },
                    icon: Icon(Icons.minimize_rounded),
                    color: Colors.black,
                    iconSize: 18,
                    padding: EdgeInsets.zero,
                  ),
                  Text(quantity.toString()),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(AddProduct(cartItem));
                    },
                    icon: Icon(Icons.add),
                    color: Colors.black,
                    iconSize: 18,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
