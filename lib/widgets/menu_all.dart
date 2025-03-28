import 'package:flutter/material.dart';
import 'header_section.dart';
import 'horizontal_divider.dart';
import 'menu_grid.dart';

class MenuAllWidget extends StatelessWidget {
  const MenuAllWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return getFilterBarUI();
  }

  Widget getFilterBarUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: const [
          HeaderSection(),
          SizedBox(height: 21),
          HorizontalDivider(),
          SizedBox(height: 38),
          Expanded(child: MenuGrid()),
        ],
      ),
    );
  }
}
