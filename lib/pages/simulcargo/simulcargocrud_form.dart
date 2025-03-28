import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/simulcargo/simulcargocrud_bloc.dart';
import 'package:eassist_tools_app/models/combobox/combommop_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combommop_widget.dart';
import 'package:eassist_tools_app/models/combobox/combomconveydetail_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomconveydetail_widget.dart';
import 'package:eassist_tools_app/models/combobox/combommop_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combommop_widget.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:dropdown_search/dropdown_search.dart';


class SimulcargoCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const SimulcargoCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	SimulcargoCrudFormPageFormState createState() => SimulcargoCrudFormPageFormState();
}

class SimulcargoCrudFormPageFormState extends State<SimulcargoCrudFormPage> {
	late SimulcargoCrudBloc simulcargoCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	ComboMMopModel? fieldComboMMop;
	final comboMMopKey = GlobalKey<DropdownSearchState<ComboMMopModel>>();
	ComboMConveyDetailModel? fieldComboMConveyDetail;
	final comboMConveyDetailKey = GlobalKey<DropdownSearchState<ComboMConveyDetailModel>>();
	var fieldPremiController = TextEditingController();
	var fieldRateController = TextEditingController();
	var fieldTsiController = TextEditingController();
	var fieldUpliftPersenController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		simulcargoCrudBloc = BlocProvider.of<SimulcargoCrudBloc>(context);
		return BlocConsumer<SimulcargoCrudBloc, SimulcargoCrudState>(
			builder: (context, state) {
				return Dialog(
					shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
					child: SingleChildScrollView(
						child: Padding(
							padding: const EdgeInsets.all(8.0),
							child: Form(
								key: _formKey,
								child: Column(
									children: [
										const SizedBox(height: 10),
										Text(
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Premi Cargo",
											style: const TextStyle(
												fontSize: 20.0,
												color: Color(0xffff6101),
												fontWeight: FontWeight.w600,
												fontFamily: 'Hind',
												fontStyle: FontStyle.italic,
												decoration: TextDecoration.underline,
											),
										),
										const SizedBox(height: 25),
										buildFieldComboMMop(
											comboKey: comboMMopKey,
											labelText: 'mconveybyId',
											initItem: fieldComboMMop,
											onChangedCallback: (value) {												
											},
											onSaveCallback: (value) {
											},											
										),
										buildFieldComboMConveyDetail(
											comboKey: comboMConveyDetailKey,
											labelText: 'mconveydetailId',
											initItem: fieldComboMConveyDetail,
											onChangedCallback: (value) {
												
											},
											onSaveCallback: (value) {
												if (value != null) {
													fieldComboMConveyDetail = value;
												}
											},
											
										),
										buildFieldComboMMop(
											comboKey: comboMMopKey,
											labelText: 'mmopId',
											initItem: fieldComboMMop,
											onChangedCallback: (value) {												
											},
											onSaveCallback: (value) {
												if (value != null) {
													fieldComboMMop = value;
												}
											},
											
										),
										TextFormField(
											keyboardType: TextInputType.number,
											inputFormatters: [ThousandsSeparatorInputFormatter()],
											controller: fieldPremiController,
											decoration: const InputDecoration(
												labelText: "premi",
												floatingLabelBehavior: FloatingLabelBehavior.always,
											),
											onChanged: (value) {
												
											},											
											textAlign: TextAlign.right,
										),
										TextFormField(
											keyboardType: TextInputType.number,
											inputFormatters: [ThousandsSeparatorInputFormatter()],
											controller: fieldRateController,
											decoration: const InputDecoration(
												labelText: "rate",
												floatingLabelBehavior: FloatingLabelBehavior.always,
											),
											onChanged: (value) {												
											},											
											textAlign: TextAlign.right,
										),
										TextFormField(
											keyboardType: TextInputType.number,
											inputFormatters: [ThousandsSeparatorInputFormatter()],
											controller: fieldTsiController,
											decoration: const InputDecoration(
												labelText: "tsi",
												floatingLabelBehavior: FloatingLabelBehavior.always,
											),
											onChanged: (value) {												
											},											
											textAlign: TextAlign.right,
										),
										TextFormField(
											keyboardType: TextInputType.number,
											inputFormatters: [ThousandsSeparatorInputFormatter()],
											controller: fieldUpliftPersenController,
											decoration: const InputDecoration(
												labelText: "upliftPersen",
												floatingLabelBehavior: FloatingLabelBehavior.always,
											),
											onChanged: (value) {												
											},											
											textAlign: TextAlign.right,
										),
										const SizedBox(height: 25),
										FormError(
											errors: errors,
											key: null,
										),
										Row(
											mainAxisAlignment: MainAxisAlignment.spaceAround,
											children: [
												SizedBox(
													width: MediaQuery.of(context).size.width * 0.3,
													height: 60,
													child: Padding(
														padding: const EdgeInsets.only(top: 30.0),
														child: ElevatedButton(
															onPressed: () {
																//proses reset ??
															},
															child: const Text(
																'Reset',
																style: TextStyle(fontSize: 13.0),
															),
														),
													),
												),
												SizedBox(
													width: MediaQuery.of(context).size.width * 0.3,
													height: 60,
													child: Padding(
														padding: const EdgeInsets.only(top: 30.0),
														child: ElevatedButton(
															onPressed: () {
																//hitung()??
															},
															child: const Text(
																'Save',
																style: TextStyle(fontSize: 13.0),
															),
														),
													),
												),
											],
										),
									],
								)),
						),
					));
				},
				listener: (context, state) {
					if (state.isLoaded) {
						if (state.record != null){
							fieldPremiController.text = NumberFormat("#,###").format(state.record!.premi);
							fieldRateController.text = NumberFormat("#,###").format(state.record!.rate);
							fieldTsiController.text = NumberFormat("#,###").format(state.record!.tsi);
							fieldUpliftPersenController.text = NumberFormat("#,###").format(state.record!.upliftPersen);
						}
						fieldComboMMop = state.comboMMop;
						fieldComboMConveyDetail = state.comboMConveyDetail;
						fieldComboMMop = state.comboMMop;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		simulcargoCrudBloc.add(
			SimulcargoCrudLihatEvent(recordId: widget.recordId));
		}
	}


}
