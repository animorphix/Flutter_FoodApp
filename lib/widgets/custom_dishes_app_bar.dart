import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

class CustomDishesAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomDishesAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      toolbarHeight: preferredSize.height,
      backgroundColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.transparent,
    );
  }
}
