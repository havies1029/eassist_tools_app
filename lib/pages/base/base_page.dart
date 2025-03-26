/*
 * Copyright 2018 Eric Windmill. All rights reserved.
 * Use of this source code is governed by the MIT license that can be found in the LICENSE file.
 */
import 'package:eassist_tools_app/blocs/onboardmenu/onboardmenucari_bloc.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/home/home_bloc.dart';
import 'package:eassist_tools_app/common/img.dart';

enum PageType {
  home,
  profile,
  groupchat,
  roomchat,
  changepswd,
  simulmv,
  simulpar,
  simuleei
}

abstract class PageContainerBase extends StatefulWidget {
  Widget get body;
  String get pageTitle;
  Widget? get menuDrawer;
  Widget get background;
  Color get backgroundColor;
  PageType? get parentModal;

  const PageContainerBase({required super.key});

  @override
  PageContainerBaseState createState() => PageContainerBaseState();
}

class PageContainerBaseState extends State<PageContainerBase> {  
  late OnBoardMenuCariBloc onBoardMenuCariBloc;

  @override
  Widget build(BuildContext context) {
    
    onBoardMenuCariBloc = BlocProvider.of<OnBoardMenuCariBloc>(context);

    return MobileDesignWidget(
      child: Container(
        color: Colors.grey[200],
        child: pageContainerType(
            context,
            widget.body,
            widget.pageTitle,
            widget.menuDrawer,
            widget.background,
            widget.backgroundColor,
            widget.parentModal),
      ),
    );

  }

  Widget pageContainerType(
      BuildContext context,
      Widget body,
      String pageTitle,
      Widget? menuDrawer,
      Widget background,
      Color backgroundColor,
      PageType? parentModal) {
    Widget baseWidget;

    if (pageTitle != "Login Page") {
      Widget titlePage(BuildContext context) {
        Paint paint = Paint();
        //paint.color = Color(0xffff6101);
        paint.color = Colors.transparent;
        return Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            color: paint.color,
            child: Center(
                child: Text(
              pageTitle,
              style: const TextStyle(
                  fontSize: 25.0,
                  //color: Colors.white,
                  color: Color(0xffff6101),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Hind'),
            )));
      }

      baseWidget = Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.background,
          ),
          background,
          Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              leading: menuDrawer == null
                  ? IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                      onPressed: () {},
                    )
                  : null,
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0.0,
              title: titlePage(context),
              actions: <Widget>[
                InkWell(
                  onTap: () {
                    BlocProvider.of<HomeBloc>(context)
                        .add(HomePageActiveEvent());
                  },
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(Img.get('login_logo.png')),
                  ),
                )
              ],
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              toolbarTextStyle: Theme.of(context).primaryTextTheme.bodyMedium,
              titleTextStyle: Theme.of(context).primaryTextTheme.titleLarge,
            ),
            drawer: menuDrawer,
            body: body,
          ),
        ],
      );
    } else {
      baseWidget = Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0), child: Container()),
        body: Stack(
          children: [
            body,
          ],
        ),
      );
    }

    return baseWidget;
  }
}
