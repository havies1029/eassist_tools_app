import 'package:eassist_tools_app/blocs/simulcargo/simulcargocrud_bloc.dart';
import 'package:eassist_tools_app/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/simulcargo/simulcargocrud_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class SimulcargoCrudMain2Page extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const SimulcargoCrudMain2Page({
    super.key,
    required this.viewMode,
    required this.recordId,
  });

  @override
  SimulcargoCrudMain2PageState createState() => SimulcargoCrudMain2PageState();
}

class SimulcargoCrudMain2PageState extends State<SimulcargoCrudMain2Page> {
  late SimulcargoCrudBloc simulcargoCrudBloc;

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
            'Perhitungan Premi Cargo',
            style: MyText.headerStyle(),
          ),
          content: SimulcargoCrudFormPage(
            viewMode: widget.viewMode,
            recordId: widget.recordId,
          ),
        ),
      ],
    );
  }
}
