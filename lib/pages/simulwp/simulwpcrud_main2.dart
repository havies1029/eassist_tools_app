import 'package:eassist_tools_app/blocs/simulwp/simulwpcrud_bloc.dart';
import 'package:eassist_tools_app/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/simulwp/simulwpcrud_form.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimulwpCrudMain2Page extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const SimulwpCrudMain2Page({super.key, required this.viewMode, required this.recordId});

  @override
  SimulwpCrudMain2PageState createState() => SimulwpCrudMain2PageState();
}

class SimulwpCrudMain2PageState extends State<SimulwpCrudMain2Page> {
  late SimulwpCrudBloc simulwpCrudBloc;

  @override
  Widget build(BuildContext context) {
    return Accordion(
      headerBorderColor: Colors.blueGrey,
      headerBorderColorOpened: Colors.transparent,
      headerBackgroundColorOpened: Colors.green,
      contentBackgroundColor: Colors.white,
      contentBorderColor: Colors.green,
      contentBorderWidth: 3,
      contentHorizontalPadding: 5,
      scaleWhenAnimating: true,
      openAndCloseAnimation: true,
      headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
      sectionClosingHapticFeedback: SectionHapticFeedback.light,
      children: [
        AccordionSection(
          isOpen: true,
          contentHorizontalPadding: 15,
          contentVerticalPadding: 15,
          leftIcon: const Icon(Icons.monetization_on, color: Colors.white),
          header: Text('Perhitungan Premi Wanprestasi', style: MyText.headerStyle()),
          content: SimulwpCrudFormPage(viewMode: widget.viewMode, recordId: widget.recordId),
        ),
      ],
    );
  }
}
