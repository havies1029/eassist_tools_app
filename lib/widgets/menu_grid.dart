import 'package:eassist_tools_app/blocs/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'constants.dart';
import 'menu_item_button.dart' as customWidgets;
import 'package:flutter_bloc/flutter_bloc.dart';

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
          return InkWell(
            onTap: () {
              var menuid = menuItems[index]["menuid"];
              switch (menuid) {
                case 'simulpar':
                  homeBloc.add(SimulPARPageActiveEvent());
                  break;
                case 'simulmv':
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    homeBloc.add(SimulMVPageActiveEvent());                                
                  });
                  break;
                case 'simuleei':
                  homeBloc.add(SimulEEIPageActiveEvent());
                  break;
                case 'simulcarear':
                  // homeBloc.add(Simul());
                  break;
                case 'simulmarinecargo':
                  // homeBloc.add(SimulMarineCargoPageActiveEvent());
                  break;
                case 'simulmarinehull':
                  // homeBloc.add(SimulMarineHullPageActiveEvent());
                  break;
                case 'simulgit':
                  homeBloc.add(SimulGITPageActiveEvent());
                  break;
                case 'simulgic':
                  // homeBloc.add(SimulGICPageActiveEvent());
                  break;
                default:
                  homeBloc.add(HomePageActiveEvent());
                  break;
              }
            },
            child: customWidgets.MenuItemButton(
              imagePath: menuItems[index]["image"]!,
              label: menuItems[index]["label"]!,
            ),
          );
        },
      ),
    );
  }
}
