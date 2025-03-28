import 'package:eassist_tools_app/blocs/simulpar/simulparcrud_bloc.dart';
import 'package:eassist_tools_app/pages/simulpar/simulparcurd_formv2.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/widgets/mobiledesign_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimulparCrudMainPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const SimulparCrudMainPage({super.key, required this.viewMode, required this.recordId});

	@override
  SimulparCrudMainPageState createState() =>
      SimulparCrudMainPageState();
}

class SimulparCrudMainPageState extends State<SimulparCrudMainPage>{
  late SimulparCrudBloc simulparCrudBloc;

    @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
	Widget build(BuildContext context) {
    simulparCrudBloc = BlocProvider.of<SimulparCrudBloc>(context);
		return MobileDesignWidget(
			child: Scaffold(
				appBar: AppBar(
					title: Text('${widget.viewMode == "tambah"?"Tambah":"Ubah"} Premi PAR'),
				),
				body: SimulparCrudFormV2Page(viewMode: widget.viewMode, recordId: widget.recordId)));
	}

  void loadData() {
    debugPrint("######### SimulparCrudMainPage -> loadData ############3");

    if (widget.viewMode == "ubah") {
      simulparCrudBloc.add(SimulparCrudLihatEvent(recordId: widget.recordId));
    } else if (widget.viewMode == "tambah") {
      simulparCrudBloc.add(SimulPARCrudInitValueEvent());
    }
  }
}

