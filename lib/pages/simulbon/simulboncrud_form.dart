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


class SimulbonCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const SimulbonCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	SimulbonCrudFormPageFormState createState() => SimulbonCrudFormPageFormState();
}

class SimulbonCrudFormPageFormState extends State<SimulbonCrudFormPage> {
	late SimulbonCrudBloc simulbonCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
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
	ComboRMatauangModel? fieldComboRMatauang;
	final comboRMatauangKey = GlobalKey<DropdownSearchState<ComboRMatauangModel>>();
	var fieldUangmukaNilaiController = TextEditingController();
	var fieldUangmukaPersenController = TextEditingController();

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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Premi Bonding",
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
											controller: fieldCarNilaiController,
											decoration: const InputDecoration(
												labelText: "carNilai",
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
											controller: fieldCarPersenController,
											decoration: const InputDecoration(
												labelText: "carPersen",
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
										CheckboxWidget(
											leftLabel: "",
											rightLabel: "isCar",
											initialValue: toBoolean(fieldIsCarController.text),
											callback: (value) {
												setState(() {
													fieldIsCarController.text = value.toString();
												});
											}
										),
										CheckboxWidget(
											leftLabel: "",
											rightLabel: "isPelaksanaan",
											initialValue: toBoolean(fieldIsPelaksanaanController.text),
											callback: (value) {
												setState(() {
													fieldIsPelaksanaanController.text = value.toString();
												});
											}
										),
										CheckboxWidget(
											leftLabel: "",
											rightLabel: "isPemeliharaan",
											initialValue: toBoolean(fieldIsPemeliharaanController.text),
											callback: (value) {
												setState(() {
													fieldIsPemeliharaanController.text = value.toString();
												});
											}
										),
										CheckboxWidget(
											leftLabel: "",
											rightLabel: "isPenawaran",
											initialValue: toBoolean(fieldIsPenawaranController.text),
											callback: (value) {
												setState(() {
													fieldIsPenawaranController.text = value.toString();
												});
											}
										),
										CheckboxWidget(
											leftLabel: "",
											rightLabel: "isUangmuka",
											initialValue: toBoolean(fieldIsUangmukaController.text),
											callback: (value) {
												setState(() {
													fieldIsUangmukaController.text = value.toString();
												});
											}
										),
										TextFormField(
											keyboardType: TextInputType.number,
											inputFormatters: [ThousandsSeparatorInputFormatter()],
											controller: fieldKontrakNilaiController,
											decoration: const InputDecoration(
												labelText: "kontrakNilai",
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
											controller: fieldPelaksanaanNilaiController,
											decoration: const InputDecoration(
												labelText: "pelaksanaanNilai",
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
											controller: fieldPelaksanaanPersenController,
											decoration: const InputDecoration(
												labelText: "pelaksanaanPersen",
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
											controller: fieldPemeliharaanNilaiController,
											decoration: const InputDecoration(
												labelText: "pemeliharaanNilai",
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
											controller: fieldPemeliharaanPersenController,
											decoration: const InputDecoration(
												labelText: "pemeliharaanPersen",
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
											controller: fieldPenawaranNilaiController,
											decoration: const InputDecoration(
												labelText: "penawaranNilai",
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
											controller: fieldPenawaranPersenController,
											decoration: const InputDecoration(
												labelText: "penawaranPersen",
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
											controller: fieldPremiCarController,
											decoration: const InputDecoration(
												labelText: "premiCar",
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
											controller: fieldPremiPelaksanaanController,
											decoration: const InputDecoration(
												labelText: "premiPelaksanaan",
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
											controller: fieldPremiPemeliharaanController,
											decoration: const InputDecoration(
												labelText: "premiPemeliharaan",
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
											controller: fieldPremiPenawaranController,
											decoration: const InputDecoration(
												labelText: "premiPenawaran",
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
											controller: fieldPremiUangmukaController,
											decoration: const InputDecoration(
												labelText: "premiUangmuka",
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
											controller: fieldRateBondController,
											decoration: const InputDecoration(
												labelText: "rateBond",
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
											controller: fieldRateCarController,
											decoration: const InputDecoration(
												labelText: "rateCar",
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
													simulbonCrudBloc.add(ComboRMatauangChangedEvent(comboRMatauang: value));
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
											controller: fieldUangmukaNilaiController,
											decoration: const InputDecoration(
												labelText: "uangmukaNilai",
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
											controller: fieldUangmukaPersenController,
											decoration: const InputDecoration(
												labelText: "uangmukaPersen",
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
							fieldCarNilaiController.text = NumberFormat("#,###").format(state.record!.carNilai);
							fieldCarPersenController.text = NumberFormat("#,###").format(state.record!.carPersen);
							fieldCoverBulanController.text = state.record!.coverBulan.toString();
							fieldIsCarController.text = state.record!.isCar.toString();
							fieldIsPelaksanaanController.text = state.record!.isPelaksanaan.toString();
							fieldIsPemeliharaanController.text = state.record!.isPemeliharaan.toString();
							fieldIsPenawaranController.text = state.record!.isPenawaran.toString();
							fieldIsUangmukaController.text = state.record!.isUangmuka.toString();
							fieldKontrakNilaiController.text = NumberFormat("#,###").format(state.record!.kontrakNilai);
							fieldPelaksanaanNilaiController.text = NumberFormat("#,###").format(state.record!.pelaksanaanNilai);
							fieldPelaksanaanPersenController.text = NumberFormat("#,###").format(state.record!.pelaksanaanPersen);
							fieldPemeliharaanNilaiController.text = NumberFormat("#,###").format(state.record!.pemeliharaanNilai);
							fieldPemeliharaanPersenController.text = NumberFormat("#,###").format(state.record!.pemeliharaanPersen);
							fieldPenawaranNilaiController.text = NumberFormat("#,###").format(state.record!.penawaranNilai);
							fieldPenawaranPersenController.text = NumberFormat("#,###").format(state.record!.penawaranPersen);
							fieldPremiCarController.text = NumberFormat("#,###").format(state.record!.premiCar);
							fieldPremiPelaksanaanController.text = NumberFormat("#,###").format(state.record!.premiPelaksanaan);
							fieldPremiPemeliharaanController.text = NumberFormat("#,###").format(state.record!.premiPemeliharaan);
							fieldPremiPenawaranController.text = NumberFormat("#,###").format(state.record!.premiPenawaran);
							fieldPremiUangmukaController.text = NumberFormat("#,###").format(state.record!.premiUangmuka);
							fieldRateBondController.text = NumberFormat("#,###").format(state.record!.rateBond);
							fieldRateCarController.text = NumberFormat("#,###").format(state.record!.rateCar);
							fieldUangmukaNilaiController.text = NumberFormat("#,###").format(state.record!.uangmukaNilai);
							fieldUangmukaPersenController.text = NumberFormat("#,###").format(state.record!.uangmukaPersen);
						}
						fieldComboRMatauang = state.comboRMatauang;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		simulbonCrudBloc.add(
			SimulbonCrudLihatEvent(recordId: widget.recordId));
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
