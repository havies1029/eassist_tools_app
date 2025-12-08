import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/listpage_filter_bar_ui.dart';
import 'package:eassist_tools_app/blocs/payment/dnrekapcobcari_bloc.dart';
import 'package:eassist_tools_app/pages/payment/dnrekapcobcari_list_widget.dart';

class DnrekapcobCariPage extends StatefulWidget {
  const DnrekapcobCariPage({super.key});

  @override
  DnrekapcobCariPageState createState() => DnrekapcobCariPageState();
}

class DnrekapcobCariPageState extends State<DnrekapcobCariPage> {
  late DnrekapcobCariBloc dnrekapcobCariBloc;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      refreshData();
    });
  }

  @override
  Widget build(BuildContext context) {
    dnrekapcobCariBloc = BlocProvider.of<DnrekapcobCariBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("DN Rekap COB"),
        elevation: 2,
      ),

      body: Column(
        children: [
          ListPageFilterBarUIWidget(
            searchController: _searchController,
            searchButton: buildSearchButton(),
          ),

          Expanded(child: buildList()),
        ],
      ),
    );
  }

  void refreshData() {
    dnrekapcobCariBloc.add(RefreshDnrekapcobCariEvent());
  }

  IconButton buildSearchButton() {
    return IconButton(
      icon: const Icon(Icons.autorenew_rounded, size: 35.0),
      onPressed: () {
        dnrekapcobCariBloc.add(RefreshDnrekapcobCariEvent());
      },
    );
  }

  Widget buildList() {
    return Column(
      children: [
        Expanded(
          child: DnrekapcobCariListWidget(
            searchText: _searchController.text,
          ),
        ),
      ],
    );
  }
}
