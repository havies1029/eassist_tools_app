import 'package:eassist_tools_app/blocs/simultree/simultreecrud_bloc.dart';
import 'package:eassist_tools_app/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/simultree/simultreecrud_form.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class SimultreeCrudMain2Page extends StatefulWidget {
  final String viewMode;
  final String recordId;
  const SimultreeCrudMain2Page({super.key, required this.viewMode, required this.recordId});

  @override
  SimultreeCrudMain2PageState createState() => SimultreeCrudMain2PageState();
}

class SimultreeCrudMain2PageState extends State<SimultreeCrudMain2Page> {
  late SimultreeCrudBloc simultreeCrudBloc;

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
          content: SimultreeCrudFormPage(
            viewMode: widget.viewMode,
            recordId: widget.recordId,
          ),
        ),
      ],
    );
  }
}
