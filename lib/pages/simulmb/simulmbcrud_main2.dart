import 'package:eassist_tools_app/blocs/simulmb/simulmbcrud_bloc.dart';
import 'package:eassist_tools_app/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/simulmb/simulmbcrud_form.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class SimulmbCrudMain2Page extends StatefulWidget {
  final String viewMode;
  final String recordId;
  const SimulmbCrudMain2Page({super.key, required this.viewMode, required this.recordId});

  @override
  SimulmbCrudMain2PageState createState() => SimulmbCrudMain2PageState();
}

class SimulmbCrudMain2PageState extends State<SimulmbCrudMain2Page> {
  late SimulmbCrudBloc simulmbCrudBloc;

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
          header: Text('Perhitungan Premi', style: MyText.headerStyle()),
          content: SimulmbCrudFormPage(
            viewMode: widget.viewMode,
            recordId: widget.recordId,
          ),
        ),
      ],
    );
  }
}
