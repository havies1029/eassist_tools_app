import 'package:eassist_tools_app/blocs/simulmv/simulmvcrud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:quick_input_formatters/quick_input_formatters.dart';

class SimulgitCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const SimulgitCrudFormPage(
			{super.key, required this.viewMode, required this.recordId});

	@override
	SimulgitCrudFormPageFormState createState() =>
			SimulgitCrudFormPageFormState();
}

class SimulgitCrudFormPageFormState extends State<SimulgitCrudFormPage> {
	late SimulgitCrudBloc simulgitCrudBloc;
	final _formKey = GlobalKey<FormState>();
	var fieldCoverBulanController = TextEditingController();
	var fieldRateController = TextEditingController();
	ComboRMatauangModel? fieldComboRMatauang;
	final comboRMatauangKey =
	GlobalKey<DropdownSearchState<ComboRMatauangModel>>();
	var fieldTsiController = TextEditingController();
	var fieldPremiController = TextEditingController();
	String currDesc = "IDR";

	@override
	Widget build(BuildContext context) {
		simulgitCrudBloc = BlocProvider.of<SimulgitCrudBloc>(context);
		return BlocConsumer<SimulgitCrudBloc, SimulgitCrudState>(
			builder: (context, state) {
				return SingleChildScrollView(
					child: Padding(
						padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 8.0),
						child: Form(
								key: _formKey,
								child: Column(
									children: [
										Row(
											children: [
												Flexible(
													flex: 1,
													child: Padding(
															padding: const EdgeInsets.all(8.0),
															child: buildFieldCoverBulan()),
												),
												Flexible(
													flex: 1,
													child: Padding(
														padding: const EdgeInsets.all(8.0),
														child: Container(),
													),
												),
											],
										),
//buildFieldCoverBulan(),
										const SizedBox(height: 10),
										Row(
											children: [
												Flexible(
													flex: 1,
													child: Padding(
															padding: const EdgeInsets.all(8.0),
															child: buildFieldCurrency()),
												),
												Flexible(
													flex: 1,
													child: Padding(
														padding: const EdgeInsets.all(8.0),
														child: Container(),
													),
												),
											],
										),
										const SizedBox(height: 10),
										buildFieldTSI(),
										const SizedBox(height: 10),
										Row(
											children: [
												Flexible(
													flex: 1,
													child: Padding(
															padding: const EdgeInsets.all(8.0),
															child: buildFieldRate()),
												),
												Flexible(
													flex: 1,
													child: Padding(
														padding: const EdgeInsets.all(8.0),
														child: Container(),
													),
												),
											],
										),
										const SizedBox(height: 10),
										buildFieldPremi(),
										const SizedBox(height: 25),
										FormError(
											errors: state.errors ?? [],
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
																simulgitCrudBloc
																		.add(SimulGitCrudInitValueEvent());
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
																simulgitCrudBloc.add(HitungPremiGitEvent());
															},
															child: const Text(
																'Hitung',
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
				);
			},
			listener: (context, state) {
				if (state.isLoaded) {
					if (state.record != null) {
						fieldCoverBulanController.text =
								state.record!.coverBulan.toString();
						fieldRateController.text =
								NumberFormat("###.00").format(state.record!.rate);
						fieldTsiController.text =
								NumberFormat("#,###").format(state.record!.tsi);
						currDesc = state.record!.currDesc ?? "IDR";
						fieldPremiController.text =
								NumberFormat("#,###").format(state.record!.premi);
					}
					fieldComboRMatauang = state.comboRMatauang;
				}
			},
		);
	}

	Widget buildFieldCoverBulan() {
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldCoverBulanController,
			decoration: const InputDecoration(
				labelText: "Lama Cover",
				floatingLabelBehavior: FloatingLabelBehavior.always,
				suffixText: " bulan",
			),
			onChanged: (value) {
				simulgitCrudBloc
						.add(FieldBulanChangedEvent(bulan: int.tryParse(value) ?? 0));
			},
			textAlign: TextAlign.right,
		);
	}

	Widget buildFieldCurrency() {
		return buildFieldComboRMatauang(
			comboKey: comboRMatauangKey,
			labelText: 'Curr',
			initItem: fieldComboRMatauang,
			onChangedCallback: (value) {
				if (value != null) {
					simulgitCrudBloc
							.add(ComboRMatauangChangedEvent(comboRMatauang: value));
				}
			},
			onSaveCallback: (value) {},
		);
	}

	Widget buildFieldTSI() {
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldTsiController,
			decoration: InputDecoration(
					labelText: "TSI",
					floatingLabelBehavior: FloatingLabelBehavior.always,
					prefixText: currDesc),
			onChanged: (value) {
				value = value.replaceAll(",", "");
				debugPrint("buildFieldTSI : $value");
				simulgitCrudBloc
						.add(FieldTSIChangedEvent(tsi: double.tryParse(value) ?? 0));
			},
			textAlign: TextAlign.right,
		);
	}

	Widget buildFieldRate() {
		return TextFormField(
			readOnly: true,
			keyboardType: TextInputType.number,
			inputFormatters: [
				FilteringTextInputFormatter.digitsOnly,
				DecimalTextInputFormatter(2)
			],
			controller: fieldRateController,
			decoration: const InputDecoration(
				labelText: "Rate",
				floatingLabelBehavior: FloatingLabelBehavior.always,
				suffixText: " %",
			),
			onChanged: (value) {
				simulgitCrudBloc
						.add(FieldRateChangedEvent(rate: double.tryParse(value) ?? 0));
			},
			textAlign: TextAlign.right,
		);
	}

	Widget buildFieldPremi() {
		return TextFormField(
			readOnly: true,
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldPremiController,
			decoration: InputDecoration(
					labelText: "Premi",
					floatingLabelBehavior: FloatingLabelBehavior.always,
					prefixText: currDesc),
			onChanged: (value) {},
			textAlign: TextAlign.right,
		);
	}
}





// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:eassist_tools_app/common/constants.dart';
// import 'package:eassist_tools_app/widgets/form_error.dart';
// import 'package:eassist_tools_app/blocs/simulgit/simulgitcrud_bloc.dart';
// import 'package:eassist_tools_app/models/simulgit/simulgitcrud_model.dart';
// import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
// import 'package:eassist_tools_app/widgets/combobox/combormatauang_widget.dart';
// import 'package:intl/intl.dart';
// import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:quick_input_formatters/quick_input_formatters.dart';
//
// class SimulgitCrudFormPage extends StatefulWidget {
// 	final String viewMode;
// 	final String recordId;
//
// 	const SimulgitCrudFormPage({
// 		super.key,
// 		required this.viewMode,
// 		required this.recordId,
// 	});
//
// 	@override
// 	SimulgitCrudFormPageFormState createState() =>
// 			SimulgitCrudFormPageFormState();
// }
//
// class SimulgitCrudFormPageFormState extends State<SimulgitCrudFormPage> {
// 	late SimulgitCrudBloc simulgitCrudBloc;
// 	final _formKey = GlobalKey<FormState>();
//
// 	// Controllers
// 	final fieldCoverBulanController = TextEditingController();
// 	final fieldPremiController = TextEditingController();
// 	final fieldRateController = TextEditingController();
// 	final fieldTsiController = TextEditingController();
//
// 	// ComboBox
// 	ComboRMatauangModel? fieldComboRMatauang;
// 	final comboRMatauangKey =
// 	GlobalKey<DropdownSearchState<ComboRMatauangModel>>();
//
// 	// Variabel prefix mata uang, diupdate melalui Bloc (default "IDR")
// 	String currDesc = "IDR";
//
// 	@override
// 	void initState() {
// 		super.initState();
// 		// Load data dari API jika viewMode adalah "ubah"
// 		Future.delayed(const Duration(milliseconds: 500), () {
// 			loadData();
// 		});
// 	}
//
// 	@override
// 	Widget build(BuildContext context) {
// 		simulgitCrudBloc = BlocProvider.of<SimulgitCrudBloc>(context);
// 		return BlocConsumer<SimulgitCrudBloc, SimulgitCrudState>(
// 			listener: (context, state) {
// 				if (state.isLoaded) {
// 					if (state.record != null) {
// 						fieldCoverBulanController.text =
// 								state.record!.coverBulan.toString();
// 						fieldPremiController.text =
// 								NumberFormat("#,###").format(state.record!.premi);
// 						fieldRateController.text =
// 								NumberFormat("###.00").format(state.record!.rate);
// 						fieldTsiController.text =
// 								NumberFormat("#,###").format(state.record!.tsi);
// 						// Update currDesc dari record atau default "IDR"
// 						currDesc = state.record!.currDesc ?? "IDR";
// 					}
// 					fieldComboRMatauang = state.comboRMatauang;
// 				}
// 			},
// 			builder: (context, state) {
// 				return Dialog(
// 					child: Container(
// 						padding: const EdgeInsets.all(16),
// 						decoration: BoxDecoration(
// 							borderRadius: BorderRadius.circular(15),
// 							gradient: LinearGradient(
// 								colors: [Colors.white, Colors.grey.shade50],
// 								begin: Alignment.topCenter,
// 								end: Alignment.bottomCenter,
// 							),
// 						),
// 						child: SingleChildScrollView(
// 							child: Form(
// 								key: _formKey,
// 								child: Column(
// 									crossAxisAlignment: CrossAxisAlignment.stretch,
// 									children: [
// 										const SizedBox(height: 25),
// 										buildFieldCoverBulan(context),
// 										buildFieldCurrency(context),
// 										buildFieldTSI(context),
// 										buildFieldRate(context),
// 										buildFieldPremi(context),
// 										const SizedBox(height: 20),
// 										// Gunakan state.errors untuk menampilkan error validasi dari Bloc
// 										FormError(errors: state.errors ?? [], key: null),
// 										const SizedBox(height: 10),
// 										Row(
// 											mainAxisAlignment: MainAxisAlignment.spaceBetween,
// 											children: [
// 												_buildDialogButton(
// 													text: 'Reset',
// 													onPressed: () {
// 														// Kirim event reset ke Bloc agar field direset
// 														simulgitCrudBloc.add(SimulGitCrudInitValueEvent());
// 														_dismissDialog();
// 													},
// 													isPrimary: false,
// 												),
// 												_buildDialogButton(
// 													text: 'Hitung',
// 													onPressed: () {
// 														// Memastikan validasi form terpenuhi sebelum kirim event hitung
// 														if (_formKey.currentState!.validate()) {
// 															simulgitCrudBloc.add(HitungPremiGitEvent());
// 														}
// 													},
// 													isPrimary: true,
// 												),
// 											],
// 										),
// 									],
// 								),
// 							),
// 						),
// 					),
// 				);
// 			},
// 		);
// 	}
//
// 	/// Field untuk lama Cover (setengah lebar)
// 	Widget buildFieldCoverBulan(BuildContext context) {
// 		return Padding(
// 			padding: const EdgeInsets.all(8.0),
// 			child: Center(
// 				child: SizedBox(
// 					width: MediaQuery.of(context).size.width * 0.5,
// 					child: TextFormField(
// 						controller: fieldCoverBulanController,
// 						keyboardType: TextInputType.number,
// 						inputFormatters: [ThousandsSeparatorInputFormatter()],
// 						autovalidateMode: AutovalidateMode.onUserInteraction,
// 						decoration: const InputDecoration(
// 							labelText: "Lama Cover",
// 							floatingLabelBehavior: FloatingLabelBehavior.always,
// 							suffixText: " bulan",
// 							border: UnderlineInputBorder(),
// 						),
// 						onChanged: (value) {
// 							simulgitCrudBloc.add(FieldBulanChangedEvent(
// 									bulan: int.tryParse(value) ?? 0));
// 						},
// 						validator: (value) {
// 							if (value == null || value.isEmpty) {
// 								return "Lama cover tidak boleh kosong";
// 							}
// 							return null;
// 						},
// 						textAlign: TextAlign.right,
// 					),
// 				),
// 			),
// 		);
// 	}
//
// 	/// Field untuk Currency (ComboBox) - setengah lebar
// 	Widget buildFieldCurrency(BuildContext context) {
// 		return Padding(
// 			padding: const EdgeInsets.all(8.0),
// 			child: Center(
// 				child: SizedBox(
// 					width: MediaQuery.of(context).size.width * 0.5,
// 					child: FormField<ComboRMatauangModel>(
// 						validator: (value) {
// 							if (value == null) {
// 								return "Field Mata Uang tidak boleh kosong";
// 							}
// 							return null;
// 						},
// 						builder: (FormFieldState<ComboRMatauangModel> state) {
// 							return Column(
// 								crossAxisAlignment: CrossAxisAlignment.start,
// 								children: [
// 									buildFieldComboRMatauang(
// 										comboKey: comboRMatauangKey,
// 										labelText: 'Curr',
// 										initItem: fieldComboRMatauang,
// 										onChangedCallback: (value) {
// 											state.didChange(value);
// 											if (value != null) {
// 												simulgitCrudBloc.add(
// 														ComboRMatauangChangedEvent(comboRMatauang: value));
// 											}
// 										},
// 										onSaveCallback: (value) {
// 											if (value != null) {
// 												fieldComboRMatauang = value;
// 											}
// 										},
// 										validatorCallback: (value) {},
// 									),
// 									if (state.hasError)
// 										Padding(
// 											padding: const EdgeInsets.only(left: 12.0, top: 5),
// 											child: Text(
// 												state.errorText ?? '',
// 												style:
// 												const TextStyle(color: Colors.red, fontSize: 12),
// 											),
// 										),
// 								],
// 							);
// 						},
// 					),
// 				),
// 			),
// 		);
// 	}
//
// 	/// Field untuk TSI (full width) dengan prefix mata uang
// 	Widget buildFieldTSI(BuildContext context) {
// 		return Padding(
// 			padding: const EdgeInsets.all(8.0),
// 			child: TextFormField(
// 				controller: fieldTsiController,
// 				keyboardType: TextInputType.number,
// 				inputFormatters: [ThousandsSeparatorInputFormatter()],
// 				autovalidateMode: AutovalidateMode.onUserInteraction,
// 				decoration: InputDecoration(
// 					labelText: "TSI",
// 					floatingLabelBehavior: FloatingLabelBehavior.always,
// 					prefixText: "$currDesc ",
// 					border: const UnderlineInputBorder(),
// 				),
// 				onChanged: (value) {
// 					String raw = value.replaceAll(",", "");
// 					simulgitCrudBloc.add(
// 							FieldTSIChangedEvent(tsi: double.tryParse(raw) ?? 0));
// 				},
// 				validator: (value) {
// 					if (value == null || value.isEmpty) {
// 						return "TSI tidak boleh kosong";
// 					}
// 					return null;
// 				},
// 				textAlign: TextAlign.right,
// 			),
// 		);
// 	}
//
// 	/// Field untuk Rate (setengah lebar, readOnly, format dua desimal)
// 	Widget buildFieldRate(BuildContext context) {
// 		return Padding(
// 			padding: const EdgeInsets.all(8.0),
// 			child: Center(
// 				child: SizedBox(
// 					width: MediaQuery.of(context).size.width * 0.5,
// 					child: TextFormField(
// 						controller: fieldRateController,
// 						readOnly: true,
// 						keyboardType: TextInputType.number,
// 						inputFormatters: [
// 							FilteringTextInputFormatter.digitsOnly,
// 							DecimalTextInputFormatter(2)
// 						],
// 						autovalidateMode: AutovalidateMode.onUserInteraction,
// 						decoration: const InputDecoration(
// 							labelText: "Rate",
// 							floatingLabelBehavior: FloatingLabelBehavior.always,
// 							suffixText: " %",
// 							border: UnderlineInputBorder(),
// 						),
// 						onChanged: (value) {
// 							simulgitCrudBloc.add(
// 									FieldRateChangedEvent(rate: double.tryParse(value) ?? 0));
// 						},
// 						validator: (value) {
// 							if (value == null || value.isEmpty) {
// 								return "Rate tidak boleh kosong";
// 							}
// 							return null;
// 						},
// 						textAlign: TextAlign.right,
// 					),
// 				),
// 			),
// 		);
// 	}
//
// 	/// Field untuk Premi (full width) dengan prefix mata uang
// 	Widget buildFieldPremi(BuildContext context) {
// 		return Padding(
// 			padding: const EdgeInsets.all(8.0),
// 			child: TextFormField(
// 				controller: fieldPremiController,
// 				readOnly: true,
// 				keyboardType: TextInputType.number,
// 				inputFormatters: [ThousandsSeparatorInputFormatter()],
// 				autovalidateMode: AutovalidateMode.onUserInteraction,
// 				decoration: InputDecoration(
// 					labelText: "Premi",
// 					floatingLabelBehavior: FloatingLabelBehavior.always,
// 					prefixText: "$currDesc ",
// 					border: const UnderlineInputBorder(),
// 				),
// 				validator: (value) {
// 					if (value == null || value.isEmpty) {
// 						return "Premi tidak boleh kosong";
// 					}
// 					return null;
// 				},
// 				textAlign: TextAlign.right,
// 			),
// 		);
// 	}
//
// 	/// Tombol Dialog (Reset, Hitung)
// 	Widget _buildDialogButton({
// 		required String text,
// 		required VoidCallback onPressed,
// 		bool isPrimary = false,
// 	}) {
// 		return ElevatedButton(
// 			onPressed: onPressed,
// 			style: ElevatedButton.styleFrom(
// 				backgroundColor: isPrimary
// 						? Theme.of(context).primaryColor
// 						: Colors.grey.shade400,
// 				shape: RoundedRectangleBorder(
// 					borderRadius: BorderRadius.circular(10),
// 				),
// 				padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
// 				elevation: 3,
// 			),
// 			child: Text(
// 				text,
// 				style: TextStyle(
// 					fontSize: 14.0,
// 					color: isPrimary ? Colors.white : Colors.black54,
// 					fontWeight: FontWeight.w600,
// 				),
// 			),
// 		);
// 	}
//
// 	/// Load data dari API (jika viewMode = "ubah")
// 	void loadData() {
// 		if (widget.viewMode == "ubah") {
// 			simulgitCrudBloc.add(SimulgitCrudLihatEvent(recordId: widget.recordId));
// 		}
// 	}
//
// 	/// Tutup dialog
// 	void _dismissDialog() {
// 		Navigator.pop(context);
// 	}
// }
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:eassist_tools_app/common/constants.dart';
// // import 'package:eassist_tools_app/widgets/form_error.dart';
// // import 'package:eassist_tools_app/blocs/simulgit/simulgitcrud_bloc.dart';
// // import 'package:eassist_tools_app/models/simulgit/simulgitcrud_model.dart';
// // import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
// // import 'package:eassist_tools_app/widgets/combobox/combormatauang_widget.dart';
// // import 'package:intl/intl.dart';
// // import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
// // import 'package:dropdown_search/dropdown_search.dart';
// // import 'package:quick_input_formatters/quick_input_formatters.dart';
// //
// // class SimulgitCrudFormPage extends StatefulWidget {
// // 	final String viewMode;
// // 	final String recordId;
// //
// // 	const SimulgitCrudFormPage({
// // 		super.key,
// // 		required this.viewMode,
// // 		required this.recordId,
// // 	});
// //
// // 	@override
// // 	SimulgitCrudFormPageFormState createState() =>
// // 			SimulgitCrudFormPageFormState();
// // }
// //
// // class SimulgitCrudFormPageFormState extends State<SimulgitCrudFormPage> {
// // 	late SimulgitCrudBloc simulgitCrudBloc;
// // 	final _formKey = GlobalKey<FormState>();
// // 	final List<String> errors = [];
// //
// // 	// Controllers
// // 	final fieldCoverBulanController = TextEditingController();
// // 	final fieldPremiController = TextEditingController();
// // 	final fieldRateController = TextEditingController();
// // 	final fieldTsiController = TextEditingController();
// //
// // 	// ComboBox
// // 	ComboRMatauangModel? fieldComboRMatauang;
// // 	final comboRMatauangKey = GlobalKey<DropdownSearchState<ComboRMatauangModel>>();
// //
// // 	// Variabel prefix mata uang, diupdate melalui Bloc (default "IDR")
// // 	String currDesc = "IDR";
// //
// // 	@override
// // 	void initState() {
// // 		super.initState();
// // 		// Load data dari API jika viewMode adalah "ubah"
// // 		Future.delayed(const Duration(milliseconds: 500), () {
// // 			loadData();
// // 		});
// // 	}
// //
// // 	@override
// // 	Widget build(BuildContext context) {
// // 		simulgitCrudBloc = BlocProvider.of<SimulgitCrudBloc>(context);
// // 		return BlocConsumer<SimulgitCrudBloc, SimulgitCrudState>(
// // 			listener: (context, state) {
// // 				if (state.isLoaded) {
// // 					if (state.record != null) {
// // 						fieldCoverBulanController.text = state.record!.coverBulan.toString();
// // 						fieldPremiController.text =
// // 								NumberFormat("#,###").format(state.record!.premi);
// // 						fieldRateController.text =
// // 								NumberFormat("###.00").format(state.record!.rate);
// // 						fieldTsiController.text =
// // 								NumberFormat("#,###").format(state.record!.tsi);
// // 						// Update currDesc dari record atau default "IDR"
// // 						currDesc = state.record!.currDesc ?? "IDR";
// // 					}
// // 					// if ((state.record?.coverBulan ?? 0) <= 0) {
// // 					// 	WidgetsBinding.instance.addPostFrameCallback((_) {
// // 					// 		setState(() {
// // 					// 			fieldCoverBulanController.text = '12';
// // 					// 		});
// // 					// 	});
// // 					// }
// // 					fieldComboRMatauang = state.comboRMatauang;
// // 				}
// // 			},
// // 			builder: (context, state) {
// // 				return Dialog(
// // 					child: Container(
// // 						padding: const EdgeInsets.all(16),
// // 						decoration: BoxDecoration(
// // 							borderRadius: BorderRadius.circular(15),
// // 							gradient: LinearGradient(
// // 								colors: [Colors.white, Colors.grey.shade50],
// // 								begin: Alignment.topCenter,
// // 								end: Alignment.bottomCenter,
// // 							),
// // 						),
// // 						child: SingleChildScrollView(
// // 							child: Form(
// // 								key: _formKey,
// // 								child: Column(
// // 									crossAxisAlignment: CrossAxisAlignment.stretch,
// // 									children: [
// // 										const SizedBox(height: 25),
// // 										buildFieldCoverBulan(context),
// // 										buildFieldCurrency(context),
// // 										buildFieldTSI(context),
// // 										buildFieldRate(context),
// // 										buildFieldPremi(context),
// // 										const SizedBox(height: 20),
// // 										FormError(errors: errors, key: null),
// // 										const SizedBox(height: 10),
// // 										Row(
// // 											mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // 											children: [
// // 												_buildDialogButton(
// // 													text: 'Reset',
// // 													onPressed: _dismissDialog,
// // 													isPrimary: false,
// // 												),
// // 												_buildDialogButton(
// // 													text: 'Hitung',
// // 													onPressed: onSaveForm,
// // 													isPrimary: true,
// // 												),
// // 											],
// // 										),
// // 									],
// // 								),
// // 							),
// // 						),
// // 					),
// // 				);
// // 			},
// // 		);
// // 	}
// //
// // 	/// Field untuk lama Cover (setengah lebar)
// // 	Widget buildFieldCoverBulan(BuildContext context) {
// // 		return Padding(
// // 			padding: const EdgeInsets.all(8.0),
// // 			child: Center(
// // 				child: SizedBox(
// // 					width: MediaQuery.of(context).size.width * 0.5,
// // 					child: TextFormField(
// // 						controller: fieldCoverBulanController,
// // 						keyboardType: TextInputType.number,
// // 						inputFormatters: [ThousandsSeparatorInputFormatter()],
// // 						autovalidateMode: AutovalidateMode.onUserInteraction,
// // 						decoration: const InputDecoration(
// // 							labelText: "lama Cover",
// // 							floatingLabelBehavior: FloatingLabelBehavior.always,
// // 							suffixText: " bulan",
// // 							border: UnderlineInputBorder(),
// // 						),
// // 						onChanged: (value) {
// // 							simulgitCrudBloc.add(FieldBulanChangedEvent(
// // 									bulan: int.tryParse(value) ?? 0));
// // 							if (value.isNotEmpty) removeError(error: kStringNullError);
// // 						},
// // 						validator: (value) {
// // 							if (value == null || value.isEmpty) {
// // 								addError(error: kStringNullError);
// // 								return "Lama cover tidak boleh kosong";
// // 							}
// // 							return null;
// // 						},
// // 						textAlign: TextAlign.right,
// // 					),
// // 				),
// // 			),
// // 		);
// // 	}
// //
// // 	/// Field untuk Currency (ComboBox) - setengah lebar
// // 	Widget buildFieldCurrency(BuildContext context) {
// // 		return Padding(
// // 			padding: const EdgeInsets.all(8.0),
// // 			child: Center(
// // 				child: SizedBox(
// // 					width: MediaQuery.of(context).size.width * 0.5,
// // 					child: FormField<ComboRMatauangModel>(
// // 						validator: (value) {
// // 							if (value == null) {
// // 								return "Field Mata Uang tidak boleh kosong";
// // 							}
// // 							return null;
// // 						},
// // 						builder: (FormFieldState<ComboRMatauangModel> state) {
// // 							return Column(
// // 								crossAxisAlignment: CrossAxisAlignment.start,
// // 								children: [
// // 									buildFieldComboRMatauang(
// // 										comboKey: comboRMatauangKey,
// // 										labelText: 'Curr',
// // 										initItem: fieldComboRMatauang,
// // 										onChangedCallback: (value) {
// // 											state.didChange(value);
// // 											if (value != null) {
// // 												simulgitCrudBloc.add(
// // 													ComboRMatauangChangedEvent(comboRMatauang: value),
// // 												);
// // 											}
// // 										},
// // 										onSaveCallback: (value) {
// // 											if (value != null) {
// // 												fieldComboRMatauang = value;
// // 											}
// // 										},
// // 										validatorCallback: (value) {},
// // 									),
// // 									if (state.hasError)
// // 										Padding(
// // 											padding: const EdgeInsets.only(left: 12.0, top: 5),
// // 											child: Text(
// // 												state.errorText ?? '',
// // 												style: const TextStyle(color: Colors.red, fontSize: 12),
// // 											),
// // 										),
// // 								],
// // 							);
// // 						},
// // 					),
// // 				),
// // 			),
// // 		);
// // 	}
// //
// // 	/// Field untuk TSI (full width) dengan prefix mata uang
// // 	Widget buildFieldTSI(BuildContext context) {
// // 		return Padding(
// // 			padding: const EdgeInsets.all(8.0),
// // 			child: TextFormField(
// // 				controller: fieldTsiController,
// // 				keyboardType: TextInputType.number,
// // 				inputFormatters: [ThousandsSeparatorInputFormatter()],
// // 				autovalidateMode: AutovalidateMode.onUserInteraction,
// // 				decoration: InputDecoration(
// // 					labelText: "TSI",
// // 					floatingLabelBehavior: FloatingLabelBehavior.always,
// // 					prefixText: "$currDesc ",
// // 					border: const UnderlineInputBorder(),
// // 				),
// // 				onChanged: (value) {
// // 					String raw = value.replaceAll(",", "");
// // 					simulgitCrudBloc.add(FieldTSIChangedEvent(tsi: double.tryParse(raw) ?? 0));
// // 					if (value.isNotEmpty) removeError(error: kStringNullError);
// // 				},
// // 				validator: (value) {
// // 					if (value == null || value.isEmpty) {
// // 						addError(error: kStringNullError);
// // 						return "TSI tidak boleh kosong";
// // 					}
// // 					return null;
// // 				},
// // 				textAlign: TextAlign.right,
// // 			),
// // 		);
// // 	}
// //
// // 	/// Field untuk Rate (setengah lebar, readOnly, format dua desimal)
// // 	Widget buildFieldRate(BuildContext context) {
// // 		return Padding(
// // 			padding: const EdgeInsets.all(8.0),
// // 			child: Center(
// // 				child: SizedBox(
// // 					width: MediaQuery.of(context).size.width * 0.5,
// // 					child: TextFormField(
// // 						controller: fieldRateController,
// // 						readOnly: true,
// // 						keyboardType: TextInputType.number,
// // 						inputFormatters: [
// // 							FilteringTextInputFormatter.digitsOnly,
// // 							DecimalTextInputFormatter(2)
// // 						],
// // 						autovalidateMode: AutovalidateMode.onUserInteraction,
// // 						decoration: const InputDecoration(
// // 							labelText: "Rate",
// // 							floatingLabelBehavior: FloatingLabelBehavior.always,
// // 							suffixText: " %",
// // 							border: UnderlineInputBorder(),
// // 						),
// // 						onChanged: (value) {
// // 							simulgitCrudBloc.add(FieldRateChangedEvent(rate: double.tryParse(value) ?? 0));
// // 							if (value.isNotEmpty) removeError(error: kStringNullError);
// // 						},
// // 						validator: (value) {
// // 							if (value == null || value.isEmpty) {
// // 								addError(error: kStringNullError);
// // 								return "Rate tidak boleh kosong";
// // 							}
// // 							return null;
// // 						},
// // 						textAlign: TextAlign.right,
// // 					),
// // 				),
// // 			),
// // 		);
// // 	}
// //
// // 	/// Field untuk Premi (full width) dengan prefix mata uang
// // 	Widget buildFieldPremi(BuildContext context) {
// // 		return Padding(
// // 			padding: const EdgeInsets.all(8.0),
// // 			child: TextFormField(
// // 				controller: fieldPremiController,
// // 				readOnly: true,
// // 				keyboardType: TextInputType.number,
// // 				inputFormatters: [ThousandsSeparatorInputFormatter()],
// // 				autovalidateMode: AutovalidateMode.onUserInteraction,
// // 				decoration: InputDecoration(
// // 					labelText: "Premi",
// // 					floatingLabelBehavior: FloatingLabelBehavior.always,
// // 					prefixText: "$currDesc ",
// // 					border: const UnderlineInputBorder(),
// // 				),
// // 				onChanged: (value) {
// // 					// Premi diupdate oleh Bloc, tidak perlu perubahan manual
// // 				},
// // 				validator: (value) {
// // 					if (value == null || value.isEmpty) {
// // 						addError(error: kStringNullError);
// // 						return "Premi tidak boleh kosong";
// // 					}
// // 					return null;
// // 				},
// // 				textAlign: TextAlign.right,
// // 			),
// // 		);
// // 	}
// //
// // 	/// Tombol Dialog (Reset, Hitung)
// // 	Widget _buildDialogButton({
// // 		required String text,
// // 		required VoidCallback onPressed,
// // 		bool isPrimary = false,
// // 	}) {
// // 		return ElevatedButton(
// // 			onPressed: onPressed,
// // 			style: ElevatedButton.styleFrom(
// // 				backgroundColor:
// // 				isPrimary ? Theme.of(context).primaryColor : Colors.grey.shade400,
// // 				shape: RoundedRectangleBorder(
// // 					borderRadius: BorderRadius.circular(10),
// // 				),
// // 				padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
// // 				elevation: 3,
// // 			),
// // 			child: Text(
// // 				text,
// // 				style: TextStyle(
// // 					fontSize: 14.0,
// // 					color: isPrimary ? Colors.white : Colors.black54,
// // 					fontWeight: FontWeight.w600,
// // 				),
// // 			),
// // 		);
// // 	}
// //
// // 	/// Load data dari API (jika viewMode = "ubah")
// // 	void loadData() {
// // 		if (widget.viewMode == "ubah") {
// // 			simulgitCrudBloc.add(SimulgitCrudLihatEvent(recordId: widget.recordId));
// // 		}
// // 	}
// //
// // 	/// Tutup dialog
// // 	void _dismissDialog() {
// // 		Navigator.pop(context);
// // 	}
// //
// // 	/// Simpan form dan kirim data ke Bloc
// // 	void onSaveForm() {
// // 		if (_formKey.currentState!.validate()) {
// // 			_formKey.currentState!.save();
// // 			SimulgitCrudModel record = SimulgitCrudModel(
// // 				coverBulan: int.parse(fieldCoverBulanController.text),
// // 				premi: double.parse(fieldPremiController.text.replaceAll(',', '')),
// // 				rate: double.parse(fieldRateController.text.replaceAll(',', '')),
// // 				rmatauangKode: fieldComboRMatauang?.rmatauangKode,
// // 				simulgitId: '',
// // 				tsi: double.parse(fieldTsiController.text.replaceAll(',', '')),
// // 			);
// // 			if (widget.viewMode == "tambah") {
// // 				simulgitCrudBloc.add(SimulgitCrudTambahEvent(record: record));
// // 			} else if (widget.viewMode == "ubah") {
// // 				record.simulgitId = simulgitCrudBloc.state.record!.simulgitId;
// // 				simulgitCrudBloc.add(SimulgitCrudUbahEvent(record: record));
// // 			}
// // 			_dismissDialog();
// // 		}
// // 	}
// //
// // 	/// Fungsi Error Handling
// // 	void addError({required String error}) {
// // 		if (!errors.contains(error)) {
// // 			setState(() {
// // 				errors.add(error);
// // 			});
// // 		}
// // 	}
// //
// // 	void removeError({required String error}) {
// // 		if (errors.contains(error)) {
// // 			setState(() {
// // 				errors.remove(error);
// // 			});
// // 		}
// // 	}
// // }
