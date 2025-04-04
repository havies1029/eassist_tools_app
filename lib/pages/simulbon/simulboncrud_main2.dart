import 'package:eassist_tools_app/blocs/simulbon/simulboncrud_bloc.dart';
import 'package:eassist_tools_app/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/simulbon/simulboncrud_form.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class SimulbonCrudMain2Page extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const SimulbonCrudMain2Page({
    super.key,
    required this.viewMode,
    required this.recordId,
  });

  @override
  SimulbonCrudMain2PageState createState() => SimulbonCrudMain2PageState();
}

class SimulbonCrudMain2PageState extends State<SimulbonCrudMain2Page> {
  late SimulbonCrudBloc simulbonCrudBloc;

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
          leftIcon: const Icon(Icons.electric_bolt, color: Colors.white),
          header: Text(
            'Perhitungan Premi Bon',
            style: MyText.headerStyle(),
          ),
          content: SimulbonCrudFormPage(
            viewMode: widget.viewMode,
            recordId: widget.recordId,
          ),
        ),
      ],
    );
  }
}
