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
						child: Container(
							padding: const EdgeInsets.all(16),
							decoration: BoxDecoration(
									borderRadius: BorderRadius.circular(15),
									gradient: LinearGradient(
											colors: [Colors.white, Colors.grey.shade50],
											begin: Alignment.topCenter,
											end: Alignment.bottomCenter
									)
							),
							child: SingleChildScrollView(
								child: Form(
										key: _formKey,
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.stretch,
											children: [
												_buildTextFormField(
													controller: fieldCoverBulanController,
													labelText: "",
													keyboardType: TextInputType.number,
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
												),
												const SizedBox(height: 10),
												_buildTextFormField(
													controller: fieldPremiController,
													labelText: "Premi",
													keyboardType: TextInputType.number,
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
												),
												const SizedBox(height: 10),
												_buildTextFormField(
													controller: fieldRateController,
													labelText: "Rate",
													keyboardType: TextInputType.number,
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
												),
												const SizedBox(height: 10),
												buildFieldComboRMatauang(
													comboKey: comboRMatauangKey,
													labelText: 'Mata Uang',
													initItem: fieldComboRMatauang,
													onChangedCallback: (value) {
														if (value != null) {
															removeError(
																	error: "Field Mata Uang tidak boleh kosong.");
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
																	error: "Field Mata Uang tidak boleh kosong.");
														}
													},
												),
												const SizedBox(height: 30),
												_buildTextFormField(
													controller: fieldTsiController,
													labelText: "TSI",
													keyboardType: TextInputType.number,
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
												),
												const SizedBox(height: 20),
												FormError(
													errors: errors,
													key: null,
												),
												Row(
													mainAxisAlignment: MainAxisAlignment.spaceBetween,
													children: [
														_buildDialogButton(
																text: 'Close',
																onPressed: _dismissDialog,
																isPrimary: false
														),
														_buildDialogButton(
																text: 'Save',
																onPressed: onSaveForm,
																isPrimary: true
														),
													],
												),
											],
										)
								),
							),
						)
				);
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

	Widget _buildTextFormField({
		required TextEditingController controller,
		required String labelText,
		required TextInputType keyboardType,
		required Function(String) onChanged,
		required String? Function(String?) validator,
	}) {
		return TextFormField(
			controller: controller,
			keyboardType: keyboardType,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			decoration: InputDecoration(
				labelText: labelText,
				floatingLabelBehavior: FloatingLabelBehavior.always,
				border: OutlineInputBorder(
						borderRadius: BorderRadius.circular(10),
						borderSide: BorderSide(color: Colors.grey.shade400)
				),
				enabledBorder: OutlineInputBorder(
						borderRadius: BorderRadius.circular(10),
						borderSide: BorderSide(color: Colors.grey.shade300)
				),
				focusedBorder: OutlineInputBorder(
						borderRadius: BorderRadius.circular(10),
						borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2)
				),
			),
			onChanged: onChanged,
			validator: validator,
			textAlign: TextAlign.right,
		);
	}

	Widget _buildDialogButton({
		required String text,
		required VoidCallback onPressed,
		bool isPrimary = false,
	}) {
		return ElevatedButton(
			onPressed: onPressed,
			style: ElevatedButton.styleFrom(
					backgroundColor: isPrimary
							? Theme.of(context).primaryColor
							: Colors.grey.shade400,
					shape: RoundedRectangleBorder(
							borderRadius: BorderRadius.circular(10)
					),
					padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
					elevation: 3
			),
			child: Text(
				text,
				style: TextStyle(
						fontSize: 14.0,
						color: isPrimary ? Colors.white : Colors.black54,
						fontWeight: FontWeight.w600
				),
			),
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