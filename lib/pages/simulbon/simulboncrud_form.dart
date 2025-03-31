import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/simulbon/simulboncrud_bloc.dart';
import 'package:eassist_tools_app/models/simulbon/simulboncrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combormatauang_widget.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:string_validator/string_validator.dart';
import 'package:eassist_tools_app/widgets/checkbox_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../widgets/my_colors.dart';

class SimulbonCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const SimulbonCrudFormPage({
		super.key,
		required this.viewMode,
		required this.recordId,
	});

	@override
	SimulbonCrudFormPageFormState createState() => SimulbonCrudFormPageFormState();
}

class SimulbonCrudFormPageFormState extends State<SimulbonCrudFormPage> {
	late SimulbonCrudBloc simulbonCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];

	// Controllers
	var fieldCarNilaiController = TextEditingController();
	var fieldCarPersenController = TextEditingController();
	var fieldCoverBulanController = TextEditingController();
	var fieldIsCarController = TextEditingController();
	var fieldIsPelaksanaanController = TextEditingController();
	var fieldIsPemeliharaanController = TextEditingController();
	var fieldIsPenawaranController = TextEditingController();
	var fieldIsUangmukaController = TextEditingController();
	var fieldKontrakNilaiController = TextEditingController();
	var fieldPelaksanaanNilaiController = TextEditingController();
	var fieldPelaksanaanPersenController = TextEditingController();
	var fieldPemeliharaanNilaiController = TextEditingController();
	var fieldPemeliharaanPersenController = TextEditingController();
	var fieldPenawaranNilaiController = TextEditingController();
	var fieldPenawaranPersenController = TextEditingController();
	var fieldPremiCarController = TextEditingController();
	var fieldPremiPelaksanaanController = TextEditingController();
	var fieldPremiPemeliharaanController = TextEditingController();
	var fieldPremiPenawaranController = TextEditingController();
	var fieldPremiUangmukaController = TextEditingController();
	var fieldRateBondController = TextEditingController();
	var fieldRateCarController = TextEditingController();
	var fieldUangmukaNilaiController = TextEditingController();
	var fieldUangmukaPersenController = TextEditingController();

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
		simulbonCrudBloc = BlocProvider.of<SimulbonCrudBloc>(context);
		return BlocConsumer<SimulbonCrudBloc, SimulbonCrudState>(
			builder: (context, state) {
				return Dialog(
					backgroundColor: Colors.white,
					child: SingleChildScrollView(
						child: Padding(
							padding: const EdgeInsets.all(8.0),
							child: Form(
								key: _formKey,
								child: Column(
									children: [
										// Field carNilai
										_buildTextFormField(
											controller: fieldCarNilaiController,
											labelText: "carNilai",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "carNilai tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field carPersen
										_buildTextFormField(
											controller: fieldCarPersenController,
											labelText: "carPersen",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "carPersen tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field coverBulan
										_buildTextFormField(
											controller: fieldCoverBulanController,
											labelText: "coverBulan",
											keyboardType: TextInputType.number,
											suffixText: " bulan",
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "coverBulan tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Checkbox isCar
										CheckboxWidget(
											leftLabel: "",
											rightLabel: "isCar",
											initialValue: toBoolean(fieldIsCarController.text),
											callback: (value) {
												setState(() {
													fieldIsCarController.text = value.toString();
												});
											},
										),
										// Checkbox isPelaksanaan
										CheckboxWidget(
											leftLabel: "",
											rightLabel: "isPelaksanaan",
											initialValue: toBoolean(fieldIsPelaksanaanController.text),
											callback: (value) {
												setState(() {
													fieldIsPelaksanaanController.text = value.toString();
												});
											},
										),
										// Checkbox isPemeliharaan
										CheckboxWidget(
											leftLabel: "",
											rightLabel: "isPemeliharaan",
											initialValue: toBoolean(fieldIsPemeliharaanController.text),
											callback: (value) {
												setState(() {
													fieldIsPemeliharaanController.text = value.toString();
												});
											},
										),
										// Checkbox isPenawaran
										CheckboxWidget(
											leftLabel: "",
											rightLabel: "isPenawaran",
											initialValue: toBoolean(fieldIsPenawaranController.text),
											callback: (value) {
												setState(() {
													fieldIsPenawaranController.text = value.toString();
												});
											},
										),
										// Checkbox isUangmuka
										CheckboxWidget(
											leftLabel: "",
											rightLabel: "isUangmuka",
											initialValue: toBoolean(fieldIsUangmukaController.text),
											callback: (value) {
												setState(() {
													fieldIsUangmukaController.text = value.toString();
												});
											},
										),
										const SizedBox(height: 10),
										// Field kontrakNilai
										_buildTextFormField(
											controller: fieldKontrakNilaiController,
											labelText: "kontrakNilai",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "kontrakNilai tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field pelaksanaanNilai
										_buildTextFormField(
											controller: fieldPelaksanaanNilaiController,
											labelText: "pelaksanaanNilai",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "pelaksanaanNilai tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field pelaksanaanPersen
										_buildTextFormField(
											controller: fieldPelaksanaanPersenController,
											labelText: "pelaksanaanPersen",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "pelaksanaanPersen tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field pemeliharaanNilai
										_buildTextFormField(
											controller: fieldPemeliharaanNilaiController,
											labelText: "pemeliharaanNilai",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "pemeliharaanNilai tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field pemeliharaanPersen
										_buildTextFormField(
											controller: fieldPemeliharaanPersenController,
											labelText: "pemeliharaanPersen",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "pemeliharaanPersen tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field penawaranNilai
										_buildTextFormField(
											controller: fieldPenawaranNilaiController,
											labelText: "penawaranNilai",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "penawaranNilai tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field penawaranPersen
										_buildTextFormField(
											controller: fieldPenawaranPersenController,
											labelText: "penawaranPersen",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "penawaranPersen tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field premiCar
										_buildTextFormField(
											controller: fieldPremiCarController,
											labelText: "premiCar",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "premiCar tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field premiPelaksanaan
										_buildTextFormField(
											controller: fieldPremiPelaksanaanController,
											labelText: "premiPelaksanaan",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "premiPelaksanaan tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field premiPemeliharaan
										_buildTextFormField(
											controller: fieldPremiPemeliharaanController,
											labelText: "premiPemeliharaan",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "premiPemeliharaan tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field premiPenawaran
										_buildTextFormField(
											controller: fieldPremiPenawaranController,
											labelText: "premiPenawaran",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "premiPenawaran tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field premiUangmuka
										_buildTextFormField(
											controller: fieldPremiUangmukaController,
											labelText: "premiUangmuka",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "premiUangmuka tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field rateBond
										_buildTextFormField(
											controller: fieldRateBondController,
											labelText: "rateBond",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "rateBond tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field rateCar
										_buildTextFormField(
											controller: fieldRateCarController,
											labelText: "rateCar",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "rateCar tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// ComboBox rmatauangKode
										buildFieldComboRMatauang(
											comboKey: comboRMatauangKey,
											labelText: 'rmatauangKode',
											initItem: fieldComboRMatauang,
											onChangedCallback: (value) {
												if (value != null) {
													removeError(error: "Field ComboRMatauang tidak boleh kosong.");
													simulbonCrudBloc.add(
														ComboRMatauangChangedEvent(comboRMatauang: value),
													);
												}
											},
											onSaveCallback: (value) {
												if (value != null) {
													fieldComboRMatauang = value;
												}
											},
											validatorCallback: (value) {
												if (value == null) {
													addError(error: "Field ComboRMatauang tidak boleh kosong.");
												}
											},
										),
										const SizedBox(height: 10),
										// Field uangmukaNilai
										_buildTextFormField(
											controller: fieldUangmukaNilaiController,
											labelText: "uangmukaNilai",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "uangmukaNilai tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 10),
										// Field uangmukaPersen
										_buildTextFormField(
											controller: fieldUangmukaPersenController,
											labelText: "uangmukaPersen",
											keyboardType: TextInputType.number,
											onChanged: (value) {
												if (value.isNotEmpty) removeError(error: kStringNullError);
											},
											validator: (value) {
												if (value == null || value.isEmpty) {
													addError(error: kStringNullError);
													return "uangmukaPersen tidak boleh kosong";
												}
												return null;
											},
										),
										const SizedBox(height: 25),
										// Error Global (dibungkus agar tidak overflow)
										SingleChildScrollView(
											scrollDirection: Axis.horizontal,
											child: FormError(
												errors: errors,
												key: null,
											),
										),
										const SizedBox(height: 10),
										// Tombol Aksi
										Row(
											mainAxisAlignment: MainAxisAlignment.spaceAround,
											children: [
												SizedBox(
													width: MediaQuery.of(context).size.width * 0.3,
													height: 60,
													child: Padding(
														padding: const EdgeInsets.only(top: 30.0),
														child: ElevatedButton(
															onPressed: _dismissDialog,
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
															onPressed: onSaveForm,
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
								),
							),
						),
					),
				);
			},
			listener: (context, state) {
				if (state.isLoaded) {
					if (state.record != null) {
						// Gunakan operator null-aware untuk menghindari nilai null
						fieldCarNilaiController.text =
								NumberFormat("#,###").format(state.record?.carNilai ?? 0);
						fieldCarPersenController.text =
								NumberFormat("#,###").format(state.record?.carPersen ?? 0);
						fieldCoverBulanController.text = (state.record?.coverBulan ?? 0).toString();
						fieldIsCarController.text = (state.record?.isCar ?? false).toString();
						fieldIsPelaksanaanController.text = (state.record?.isPelaksanaan ?? false).toString();
						fieldIsPemeliharaanController.text = (state.record?.isPemeliharaan ?? false).toString();
						fieldIsPenawaranController.text = (state.record?.isPenawaran ?? false).toString();
						fieldIsUangmukaController.text = (state.record?.isUangmuka ?? false).toString();
						fieldKontrakNilaiController.text =
								NumberFormat("#,###").format(state.record?.kontrakNilai ?? 0);
						fieldPelaksanaanNilaiController.text =
								NumberFormat("#,###").format(state.record?.pelaksanaanNilai ?? 0);
						fieldPelaksanaanPersenController.text =
								NumberFormat("#,###").format(state.record?.pelaksanaanPersen ?? 0);
						fieldPemeliharaanNilaiController.text =
								NumberFormat("#,###").format(state.record?.pemeliharaanNilai ?? 0);
						fieldPemeliharaanPersenController.text =
								NumberFormat("#,###").format(state.record?.pemeliharaanPersen ?? 0);
						fieldPenawaranNilaiController.text =
								NumberFormat("#,###").format(state.record?.penawaranNilai ?? 0);
						fieldPenawaranPersenController.text =
								NumberFormat("#,###").format(state.record?.penawaranPersen ?? 0);
						fieldPremiCarController.text =
								NumberFormat("#,###").format(state.record?.premiCar ?? 0);
						fieldPremiPelaksanaanController.text =
								NumberFormat("#,###").format(state.record?.premiPelaksanaan ?? 0);
						fieldPremiPemeliharaanController.text =
								NumberFormat("#,###").format(state.record?.premiPemeliharaan ?? 0);
						fieldPremiPenawaranController.text =
								NumberFormat("#,###").format(state.record?.premiPenawaran ?? 0);
						fieldPremiUangmukaController.text =
								NumberFormat("#,###").format(state.record?.premiUangmuka ?? 0);
						fieldRateBondController.text =
								NumberFormat("#,###").format(state.record?.rateBond ?? 0);
						fieldRateCarController.text =
								NumberFormat("#,###").format(state.record?.rateCar ?? 0);
						fieldUangmukaNilaiController.text =
								NumberFormat("#,###").format(state.record?.uangmukaNilai ?? 0);
						fieldUangmukaPersenController.text =
								NumberFormat("#,###").format(state.record?.uangmukaPersen ?? 0);
					}
					fieldComboRMatauang = state.comboRMatauang;
				}
			},
		);
	}

	// Widget pembantu untuk TextFormField dengan dekorasi validasi
	Widget _buildTextFormField({
		required TextEditingController controller,
		required String labelText,
		required TextInputType keyboardType,
		required Function(String) onChanged,
		required String? Function(String?) validator,
		String? suffixText,
	}) {
		return SizedBox(
			width: double.infinity,
			child: TextFormField(
				keyboardType: keyboardType,
				inputFormatters: [ThousandsSeparatorInputFormatter()],
				controller: controller,
				decoration: InputDecoration(
					filled: true,
					fillColor: Colors.white,
					labelText: labelText,
					floatingLabelBehavior: FloatingLabelBehavior.always,
					suffixText: suffixText,
					border: const UnderlineInputBorder(),
					enabledBorder: const UnderlineInputBorder(
						borderSide: BorderSide(color: Colors.grey),
					),
					focusedBorder: UnderlineInputBorder(
						borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
					),
					errorBorder: const UnderlineInputBorder(
						borderSide: BorderSide(color: Colors.red),
					),
					focusedErrorBorder: const UnderlineInputBorder(
						borderSide: BorderSide(color: Colors.red, width: 2),
					),
					errorStyle: const TextStyle(color: Colors.red),
				),
				onChanged: onChanged,
				validator: validator,
				textAlign: TextAlign.right,
			),
		);
	}

	void loadData() {
		if (widget.viewMode == "ubah") {
			simulbonCrudBloc.add(
				SimulbonCrudLihatEvent(recordId: widget.recordId),
			);
		}
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			SimulbonCrudModel record = SimulbonCrudModel(
				carNilai: double.parse(fieldCarNilaiController.text.replaceAll(',', '')),
				carPersen: double.parse(fieldCarPersenController.text.replaceAll(',', '')),
				coverBulan: int.parse(fieldCoverBulanController.text),
				isCar: toBoolean(fieldIsCarController.text),
				isPelaksanaan: toBoolean(fieldIsPelaksanaanController.text),
				isPemeliharaan: toBoolean(fieldIsPemeliharaanController.text),
				isPenawaran: toBoolean(fieldIsPenawaranController.text),
				isUangmuka: toBoolean(fieldIsUangmukaController.text),
				kontrakNilai: double.parse(fieldKontrakNilaiController.text.replaceAll(',', '')),
				pelaksanaanNilai: double.parse(fieldPelaksanaanNilaiController.text.replaceAll(',', '')),
				pelaksanaanPersen: double.parse(fieldPelaksanaanPersenController.text.replaceAll(',', '')),
				pemeliharaanNilai: double.parse(fieldPemeliharaanNilaiController.text.replaceAll(',', '')),
				pemeliharaanPersen: double.parse(fieldPemeliharaanPersenController.text.replaceAll(',', '')),
				penawaranNilai: double.parse(fieldPenawaranNilaiController.text.replaceAll(',', '')),
				penawaranPersen: double.parse(fieldPenawaranPersenController.text.replaceAll(',', '')),
				premiCar: double.parse(fieldPremiCarController.text.replaceAll(',', '')),
				premiPelaksanaan: double.parse(fieldPremiPelaksanaanController.text.replaceAll(',', '')),
				premiPemeliharaan: double.parse(fieldPremiPemeliharaanController.text.replaceAll(',', '')),
				premiPenawaran: double.parse(fieldPremiPenawaranController.text.replaceAll(',', '')),
				premiUangmuka: double.parse(fieldPremiUangmukaController.text.replaceAll(',', '')),
				rateBond: double.parse(fieldRateBondController.text.replaceAll(',', '')),
				rateCar: double.parse(fieldRateCarController.text.replaceAll(',', '')),
				rmatauangKode: fieldComboRMatauang?.rmatauangKode,
				simulbon1Id: '',
				uangmukaNilai: double.parse(fieldUangmukaNilaiController.text.replaceAll(',', '')),
				uangmukaPersen: double.parse(fieldUangmukaPersenController.text.replaceAll(',', '')),
			);
			if (widget.viewMode == "tambah") {
				simulbonCrudBloc.add(SimulbonCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.simulbon1Id = simulbonCrudBloc.state.record!.simulbon1Id;
				simulbonCrudBloc.add(SimulbonCrudUbahEvent(record: record));
			}
			_dismissDialog();
		}
	}

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
