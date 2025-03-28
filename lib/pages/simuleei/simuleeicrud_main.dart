import 'package:eassist_tools_app/blocs/simuleei/simuleeicrud_bloc.dart';
import 'package:eassist_tools_app/pages/simuleei/simuleeicrud_main2.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimuleeiCrudMainPage extends StatefulWidget {
	const SimuleeiCrudMainPage({super.key});

 	@override
  SimuleeiCrudMainPageState createState() => SimuleeiCrudMainPageState();
}

class SimuleeiCrudMainPageState extends State<SimuleeiCrudMainPage>{
  late SimuleeiCrudBloc simuleeiCrudBloc;

    @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
	Widget build(BuildContext context) {
    simuleeiCrudBloc = BlocProvider.of<SimuleeiCrudBloc>(context);
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('Calc. Premi EEI'),
				),
				body: SimuleeiCrudMain2Page(viewMode: "tambah", recordId: "")));
	}

  void loadData() {
    simuleeiCrudBloc.add(SimuleeiCrudInitValueEvent());
  }
}
