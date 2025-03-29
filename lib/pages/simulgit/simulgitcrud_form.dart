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

	const SimulgitCrudFormPage({
		super.key,
		required this.viewMode,
		required this.recordId,
	});

	@override
	SimulgitCrudFormPageFormState createState() =>
			SimulgitCrudFormPageFormState();
}

class SimulgitCrudFormPageFormState extends State<SimulgitCrudFormPage> {
	late SimulgitCrudBloc simulgitCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];

	// Controllers
	final fieldCoverBulanController = TextEditingController();
	final fieldPremiController = TextEditingController();
	final fieldRateController = TextEditingController();
	final fieldTsiController = TextEditingController();

	// ComboBox
	ComboRMatauangModel? fieldComboRMatauang;
	final comboRMatauangKey = GlobalKey<DropdownSearchState<ComboRMatauangModel>>();

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
			listener: (context, state) {
				if (state.isLoaded) {
					if (state.record != null) {
						fieldCoverBulanController.text =
								state.record!.coverBulan.toString();
						fieldPremiController.text =
								NumberFormat("#,###").format(state.record!.premi);
						fieldRateController.text =
								NumberFormat("#,###").format(state.record!.rate);
						fieldTsiController.text =
								NumberFormat("#,###").format(state.record!.tsi);
					}
					fieldComboRMatauang = state.comboRMatauang;
				}
			},
			builder: (context, state) {
				return Dialog(
					child: Container(
						padding: const EdgeInsets.all(16),
						decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(15),
							gradient: LinearGradient(
								colors: [Colors.white, Colors.grey.shade50],
								begin: Alignment.topCenter,
								end: Alignment.bottomCenter,
							),
						),
						child: SingleChildScrollView(
							child: Form(
								key: _formKey,
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.stretch,
									children: [
										// Judul Halaman (misal dapat diaktifkan kembali)
										// Text(
										//   "${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Premi GIS",
										//   style: const TextStyle(
										//     fontSize: 20.0,
										//     color: Color(0xffff6101),
										//     fontWeight: FontWeight.w600,
										//   ),
										//   textAlign: TextAlign.center,
										// ),
										const SizedBox(height: 25),

										// Row 1: coverBulan & Premi
										Row(
											children: [
												Flexible(
													flex: 1,
													child: Padding(
														padding: const EdgeInsets.all(8.0),
														child: _buildTextFormField(
															controller: fieldCoverBulanController,
															labelText: "coverBulan",
															keyboardType: TextInputType.number,
															onChanged: (value) {
																// Dapat ditambahkan logika jika diperlukan
															},
															validator: (value) {
																if (value == null || value.isEmpty) {
																	return "coverBulan tidak boleh kosong";
																}
																return null;
															},
															// Misal untuk cover bulan bisa tambahkan suffix " bulan"
															suffixText: " bulan",
														),
													),
												),
												Flexible(
													flex: 1,
													child: Padding(
														padding: const EdgeInsets.all(8.0),
														child: _buildTextFormField(
															controller: fieldPremiController,
															labelText: "Premi",
															keyboardType: TextInputType.number,
															onChanged: (value) {},
															validator: (value) {
																if (value == null || value.isEmpty) {
																	return "Premi tidak boleh kosong";
																}
																return null;
															},
														),
													),
												),
											],
										),
										const SizedBox(height: 10),

										// Row 2: Rate (Kolom kedua kosong)
										Row(
											children: [
												Flexible(
													flex: 1,
													child: Padding(
														padding: const EdgeInsets.all(8.0),
														child: _buildTextFormField(
															controller: fieldRateController,
															labelText: "Rate",
															keyboardType: TextInputType.number,
															onChanged: (value) {},
															validator: (value) {
																if (value == null || value.isEmpty) {
																	return "Rate tidak boleh kosong";
																}
																return null;
															},
															suffixText: " %",
														),
													),
												),
												const Flexible(
													flex: 1,
													child: SizedBox(),
												),
											],
										),
										const SizedBox(height: 10),

										// Combobox Mata Uang (Full Width) menggunakan FormField untuk validasi
										Padding(
											padding: const EdgeInsets.all(8.0),
											child: FormField<ComboRMatauangModel>(
												validator: (value) {
													if (value == null) {
														return "Field Mata Uang tidak boleh kosong";
													}
													return null;
												},
												builder: (FormFieldState<ComboRMatauangModel> state) {
													return Column(
														crossAxisAlignment: CrossAxisAlignment.start,
														children: [
															buildFieldComboRMatauang(
																comboKey: comboRMatauangKey,
																labelText: 'Mata Uang',
																initItem: fieldComboRMatauang,
																onChangedCallback: (value) {
																	state.didChange(value);
																	if (value != null) {
																		// jika diperlukan, bisa mengupdate state global
																		simulgitCrudBloc.add(ComboRMatauangChangedEvent(
																				comboRMatauang: value));
																	}
																},
																onSaveCallback: (value) {
																	if (value != null) {
																		fieldComboRMatauang = value;
																	}
																},
																validatorCallback: (value) {
																	// Tidak diperlukan karena sudah divalidasi di FormField
																},
															),
															if (state.hasError)
																Padding(
																	padding:
																	const EdgeInsets.only(left: 12.0, top: 5),
																	child: Text(
																		state.errorText ?? '',
																		style: const TextStyle(
																			color: Colors.red,
																			fontSize: 12,
																		),
																	),
																),
														],
													);
												},
											),
										),
										const SizedBox(height: 30),

										// TSI (Full Width)
										Padding(
											padding: const EdgeInsets.all(8.0),
											child: _buildTextFormField(
												controller: fieldTsiController,
												labelText: "TSI",
												keyboardType: TextInputType.number,
												onChanged: (value) {},
												validator: (value) {
													if (value == null || value.isEmpty) {
														return "TSI tidak boleh kosong";
													}
													return null;
												},
											),
										),
										const SizedBox(height: 20),

										// Tampilkan Error Global (jika diperlukan)
										FormError(
											errors: errors,
											key: null,
										),
										const SizedBox(height: 10),

										// Tombol Aksi (Close & Save)
										Row(
											mainAxisAlignment: MainAxisAlignment.spaceBetween,
											children: [
												_buildDialogButton(
													text: 'Close',
													onPressed: _dismissDialog,
													isPrimary: false,
												),
												_buildDialogButton(
													text: 'Save',
													onPressed: onSaveForm,
													isPrimary: true,
												),
											],
										),
									],
								),
							),
						),
					),
				);
			},
		);
	}

	// ---------------------------------------------------
	// Widget Pembantu untuk TextFormField dengan Underline
	// ---------------------------------------------------
	Widget _buildTextFormField({
		required TextEditingController controller,
		required String labelText,
		required TextInputType keyboardType,
		required Function(String) onChanged,
		required String? Function(String?) validator,
		String? prefixText,
		String? suffixText,
	}) {
		return TextFormField(
			controller: controller,
			keyboardType: keyboardType,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			autovalidateMode: AutovalidateMode.onUserInteraction,
			decoration: InputDecoration(
				labelText: labelText,
				floatingLabelBehavior: FloatingLabelBehavior.always,
				prefixText: prefixText,
				suffixText: suffixText,
				border: const UnderlineInputBorder(),
				enabledBorder: const UnderlineInputBorder(
					borderSide: BorderSide(color: Colors.grey),
				),
				focusedBorder: UnderlineInputBorder(
					borderSide:
					BorderSide(color: Theme.of(context).primaryColor, width: 2),
				),
				errorBorder: const UnderlineInputBorder(
					borderSide: BorderSide(color: Colors.red),
				),
				focusedErrorBorder: const UnderlineInputBorder(
					borderSide: BorderSide(color: Colors.red, width: 2),
				),
			),
			onChanged: onChanged,
			validator: validator,
			textAlign: TextAlign.right,
		);
	}

	// ---------------------------------------------------
	// Widget Pembantu Tombol Dialog (Close, Save)
	// ---------------------------------------------------
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
					borderRadius: BorderRadius.circular(10),
				),
				padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
				elevation: 3,
			),
			child: Text(
				text,
				style: TextStyle(
					fontSize: 14.0,
					color: isPrimary ? Colors.white : Colors.black54,
					fontWeight: FontWeight.w600,
				),
			),
		);
	}

	// ---------------------------------------------------
	// Load Data
	// ---------------------------------------------------
	void loadData() {
		if (widget.viewMode == "ubah") {
			simulgitCrudBloc.add(
				SimulgitCrudLihatEvent(recordId: widget.recordId),
			);
		}
	}

	// ---------------------------------------------------
	// Dismiss Dialog
	// ---------------------------------------------------
	void _dismissDialog() {
		Navigator.pop(context);
	}

	// ---------------------------------------------------
	// onSaveForm
	// ---------------------------------------------------
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

	// ---------------------------------------------------
	// Error Handling (digunakan untuk error global, jika diperlukan)
	// ---------------------------------------------------
	void addError({required String error}) {
		if (!errors.contains(error)) {
			setState(() {
				errors.add(error);
			});
		}
	}

	void removeError({required String error}) {
		if (errors.contains(error)) {
			setState(() {
				errors.remove(error);
			});
		}
	}
}
