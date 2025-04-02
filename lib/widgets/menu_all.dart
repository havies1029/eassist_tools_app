import 'package:flutter/material.dart';
import 'package:eassist_tools_app/blocs/home/home_bloc.dart';
import 'constants.dart';
import 'menu_item_button.dart' as customWidgets;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'header_section.dart';
import 'horizontal_divider.dart';

class MenuAllWidget extends StatelessWidget {
  const MenuAllWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Seluruh konten, termasuk header, divider, dan grid, dapat discroll bersama
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HeaderSection(),
            SizedBox(height: 21),
            HorizontalDivider(),
            SizedBox(height: 38),
            MenuGrid(),
          ],
        ),
      ),
    );
  }
}

class MenuGrid extends StatefulWidget {
  const MenuGrid({super.key});

  @override
  MenuGridState createState() => MenuGridState();
}

class MenuGridState extends State<MenuGrid> {
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Main Menu',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buildMenuGrid(menuItems, homeBloc),
          const SizedBox(height: 16.0),
          const Text(
            'Claim Services',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buildMenuGrid(claimServices, homeBloc),
        ],
      ),
    );
  }

  Widget _buildMenuGrid(List<Map<String, String>> items, HomeBloc homeBloc) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // Nonaktifkan scroll internal
      shrinkWrap: true, // Ukuran grid mengikuti kontennya
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            var menuid = items[index]["menuid"];
            switch (menuid) {
              case 'simulpar':
                homeBloc.add(SimulPARPageActiveEvent());
                break;
              case 'simulflexas':
                homeBloc.add(SimulFlexasPageActiveEvent());
                break;
              case 'simulmv':
                homeBloc.add(SimulMVPageActiveEvent());
                break;
              case 'simuleei':
                homeBloc.add(SimulEEIPageActiveEvent());
                break;
              case 'simulcargo':
                homeBloc.add(SimulCARGOPageActiveEvent());
                break;
              case 'simulgit':
                homeBloc.add(SimulGITPageActiveEvent());
                break;
              case 'simulgis':
                homeBloc.add(SimulGISPageActiveEvent());
                break;
              case 'simulbon':
                homeBloc.add(SimulBONPageActiveEvent());
                break;
              case 'simulwp':
                homeBloc.add(SimulWPPageActiveEvent());
                break;
              case 'simulcar':
                homeBloc.add(SimulCARPageActiveEvent());
                break;
              case 'simultree':
                homeBloc.add(SimulTREEPageActiveEvent());
                break;
              case 'simulmb':
                homeBloc.add(SimulMBPageActiveEvent());
                break;
              default:
                homeBloc.add(HomePageActiveEvent());
                break;
            }
          },
          child: customWidgets.MenuItemButton(
            imagePath: items[index]["image"]!,
            label: items[index]["label"]!,
          ),
        );
      },
    );
  }
}
