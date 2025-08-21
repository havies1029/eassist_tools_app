import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../widgets/components/mobile_navbar/bottom_nav.dart';
import '../../widgets/components/mobile_navbar/top_nav.dart';
import '../../widgets/components/navbar/navbar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/home/home_bloc.dart';
import '../../pages/base/base_page.dart';
import '../qontak/floating_chat_wrapper.dart';

class SafeLayoutFrame extends StatelessWidget {
  final Widget child;
  const SafeLayoutFrame({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    final PageType currentPage = context.watch<HomeBloc>().currentPage;
    if (kIsWeb) {
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: child,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              elevation: 20,
              child: NavbarWidget(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Scaffold(
        extendBody: true,
        body: Column(
          children: [
            MobileTopNavigationBar(),
            Expanded(
              child: Stack(
                children: [
                  child,
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingChatWrapper(
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: MobileBottomNavigationBar(currentPage: currentPage),
      );
    }
  }
}
