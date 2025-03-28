import 'package:flutter/material.dart';
import 'constants.dart';
import 'menu_item_button.dart' as customWidgets;

class MenuGrid extends StatelessWidget {
  const MenuGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        itemCount: menuItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return customWidgets.MenuItemButton(
            imagePath: menuItems[index]["image"]!,
            label: menuItems[index]["label"]!,
          );
        },
      ),
    );
  }
}


