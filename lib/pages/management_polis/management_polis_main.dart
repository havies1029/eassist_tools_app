import 'package:flutter/material.dart';

import '../../common/constants.dart';
import 'management_polis_page.dart';


class PolisManagementMain extends StatelessWidget {
  const PolisManagementMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JPS Insurance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kBrandPrimaryColor,
        scaffoldBackgroundColor: kBrandLightColor,
        fontFamily: 'Satoshi-Regular',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 16.0,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Satoshi-Regular',
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: kBrandPrimaryColor,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const PolisManagementPage(),
    );
  }
}