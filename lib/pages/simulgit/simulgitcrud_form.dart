import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/simulgit/simulgitcrud_bloc.dart';
import 'package:eassist_tools_app/models/simulgit/simulgitcrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combormatauang_widget.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:dropdown_search/dropdown_search.dart';


class SimulgitCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const SimulgitCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	SimulgitCrudFormPageFormState createState() => SimulgitCrudFormPageFormState();
}

class SimulgitCrudFormPageFormState extends State<SimulgitCrudFormPage> {
	late SimulgitCrudBloc simulgitCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldCoverBulanController = TextEditingController();
	var fieldPremiController = TextEditingController();
	var fieldRateController = TextEditingController();
	ComboRMatauangModel? fieldComboRMatauang;
	final comboRMatauangKey = GlobalKey<DropdownSearchState<ComboRMatauangModel>>();
	var fieldTsiController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		simulgitCrudBloc = BlocProvider.of<SimulgitCrudBloc>(context);
		return BlocConsumer<SimulgitCrudBloc, SimulgitCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Premi GIT",
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
										TextFormField(
											keyboardType: TextInputType.number,
											inputFormatters: [ThousandsSeparatorInputFormatter()],
											controller: fieldCoverBulanController,
											decoration: const InputDecoration(
												labelText: "coverBulan",
												floatingLabelBehavior: FloatingLabelBehavior.always,
											),
											onChanged: (value) {
												if (value.isNotEmpty) {
													removeError(error: kStringNullError);
												}
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "";
												}
												return null;
											},
											textAlign: TextAlign.right,
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
												if (value.isNotEmpty) {
													removeError(error: kStringNullError);
												}
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "";
												}
												return null;
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
												if (value.isNotEmpty) {
													removeError(error: kStringNullError);
												}
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "";
												}
												return null;
											},
											textAlign: TextAlign.right,
										),
										buildFieldComboRMatauang(
											comboKey: comboRMatauangKey,
											labelText: 'rmatauangKode',
											initItem: fieldComboRMatauang,
											onChangedCallback: (value) {
												if (value != null) {
													removeError(
														error: "Field ComboRMatauang tidak boleh kosong.");
													simulgitCrudBloc.add(ComboRMatauangChangedEvent(comboRMatauang: value));
												}
											},
											onSaveCallback: (value) {
												if (value != null) {
													fieldComboRMatauang = value;
												}
											},
											validatorCallback: (value) {
												if (value == null) {
													addError(
														error: "Field ComboRMatauang tidak boleh kosong.");
												}
											},
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
												if (value.isNotEmpty) {
													removeError(error: kStringNullError);
												}
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "";
												}
												return null;
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
																_dismissDialog();
															},
															child: const Text(
																'Close',
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
																onSaveForm();
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
							fieldCoverBulanController.text = state.record!.coverBulan.toString();
							fieldPremiController.text = NumberFormat("#,###").format(state.record!.premi);
							fieldRateController.text = NumberFormat("#,###").format(state.record!.rate);
							fieldTsiController.text = NumberFormat("#,###").format(state.record!.tsi);
						}
						fieldComboRMatauang = state.comboRMatauang;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		simulgitCrudBloc.add(
			SimulgitCrudLihatEvent(recordId: widget.recordId));
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			SimulgitCrudModel record = SimulgitCrudModel(
				coverBulan: int.parse(fieldCoverBulanController.text),
				premi: double.parse(fieldPremiController.text.replaceAll(',', '')),
				rate: double.parse(fieldRateController.text.replaceAll(',', '')),
				rmatauangKode: fieldComboRMatauang?.rmatauangKode,
				simulgitId: '',
				tsi: double.parse(fieldTsiController.text.replaceAll(',', '')),
			);
			if (widget.viewMode == "tambah") {
				simulgitCrudBloc.add(SimulgitCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.simulgitId = simulgitCrudBloc.state.record!.simulgitId;
				simulgitCrudBloc.add(SimulgitCrudUbahEvent(record: record));
			}
			_dismissDialog();
		}
	}

	void addError({required String error}) {
		if (!errors.contains(error)){
			setState(() {
				errors.add(error);
			});
		}
	}

	void removeError({required String error}) {
		if (errors.contains(error)){
			setState(() {
				errors.remove(error);
			});
		}
	}

}
