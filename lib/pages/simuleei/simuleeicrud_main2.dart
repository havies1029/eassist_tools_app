import 'package:eassist_tools_app/blocs/simuleei/simuleeicrud_bloc.dart';
import 'package:eassist_tools_app/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:eassist_tools_app/pages/simuleei/simuleeicrud_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

class SimuleeiCrudMain2Page extends StatefulWidget {
	final String viewMode;
	final String recordId;
	const SimuleeiCrudMain2Page({super.key, required this.viewMode, required this.recordId});

 	@override
  SimuleeiCrudMain2PageState createState() => SimuleeiCrudMain2PageState();
}

class SimuleeiCrudMain2PageState extends State<SimuleeiCrudMain2Page>{
  late SimuleeiCrudBloc simuleeiCrudBloc;


  @override
	Widget build(BuildContext context) {
    return Accordion(
        headerBorderColor: Colors.blueGrey,
        headerBorderColorOpened: Colors.transparent,
        // headerBorderWidth: 1,
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
            leftIcon:
                const Icon(Icons.electric_bolt, color: Colors.white),
            header: Text('Perhitungan Premi', style: MyText.headerStyle()),
            content: SimuleeiCrudFormPage(viewMode: widget.viewMode, recordId: widget.recordId,)
          ),          
        ]);
	}


}
