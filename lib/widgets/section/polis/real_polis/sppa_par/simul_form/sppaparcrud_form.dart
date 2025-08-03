import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/gen_sppapar/sppaparcrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_sppapar/sppaparcrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combomkabzonagempa_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomkabzonagempa_widget.dart';
import 'package:eassist_tools_app/models/combobox/combombiindemnityojk_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombiindemnityojk_widget.dart';
import 'package:eassist_tools_app/models/combobox/combomtarifojkbanjirpar_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomtarifojkbanjirpar_widget.dart';
import 'package:eassist_tools_app/models/combobox/combomwilayah_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomwilayah_widget.dart';
import 'package:eassist_tools_app/models/combobox/comborkodepos_model.dart';
import 'package:eassist_tools_app/widgets/combobox/comborkodepos_widget.dart';
import 'package:eassist_tools_app/models/combobox/comborkonstruksiojk_model.dart';
import 'package:eassist_tools_app/widgets/combobox/comborkonstruksiojk_widget.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combormatauang_widget.dart';
import 'package:eassist_tools_app/models/combobox/comborokupasi_model.dart';
import 'package:eassist_tools_app/widgets/combobox/comborokupasi_widget.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SppaparFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const SppaparFormPage({
		super.key,
		required this.viewMode,
		required this.recordId
	});

	@override
	SppaparFormPageState createState() => SppaparFormPageState();
}

class SppaparFormPageState extends State<SppaparFormPage> {
	late SppaparCrudBloc sppaparCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];

	// Text Controllers - Basic Info
	var fieldInsuredNamaController = TextEditingController();
	var fieldInsuredAlamat1Controller = TextEditingController();
	var fieldInsuredAlamat2Controller = TextEditingController();
	var fieldLokasi1Controller = TextEditingController();
	var fieldLokasi2Controller = TextEditingController();

	// Date Controllers
	var fieldSppaTglController = TextEditingController(text: DateTime.now().toIso8601String());
	var fieldPeriodeMulaiController = TextEditingController(text: DateTime.now().toIso8601String());
	var fieldPeriodeAkhirController = TextEditingController(text: DateTime.now().toIso8601String());

	// Coverage Controllers
	var fieldBuildingDescController = TextEditingController();
	var fieldContentDescController = TextEditingController();
	var fieldMachineryDescController = TextEditingController();
	var fieldStockDescController = TextEditingController();
	var fieldOtherDescController = TextEditingController();

	// Sum Insured Controllers
	var fieldSiBuildingController = TextEditingController();
	var fieldSiContentController = TextEditingController();
	var fieldSiMachineryController = TextEditingController();
	var fieldSiStockController = TextEditingController();
	var fieldSiOtherController = TextEditingController();
	var fieldTsiController = TextEditingController();
	var fieldStockAdjustableController = TextEditingController();

	// Rate Controllers
	var fieldRateParController = TextEditingController();
	var fieldRateEqvetController = TextEditingController();
	var fieldRateRsmdccController = TextEditingController();
	var fieldRateTsfwdController = TextEditingController();
	var fieldRateOtherController = TextEditingController();
	var fieldRateTotalController = TextEditingController();

	// Premium Controllers
	var fieldPremiParController = TextEditingController();
	var fieldPremiEqvetController = TextEditingController();
	var fieldPremiRsmdccController = TextEditingController();
	var fieldPremiTsfwdController = TextEditingController();
	var fieldPremiOtherController = TextEditingController();
	var fieldPremiTotalController = TextEditingController();

	// Combo Fields
	ComboMWilayahModel? fieldComboMWilayah;
	final comboMWilayahKey = GlobalKey<DropdownSearchState<ComboMWilayahModel>>();

	ComboRKodeposModel? fieldComboRKodepos;
	final comboRKodeposKey = GlobalKey<DropdownSearchState<ComboRKodeposModel>>();

	ComboMKabZonaGempaModel? fieldComboMKabZonaGempa;
	final comboMKabZonaGempaKey = GlobalKey<DropdownSearchState<ComboMKabZonaGempaModel>>();

	ComboRKonstruksiojkModel? fieldComboRKonstruksiojk;
	final comboRKonstruksiojkKey = GlobalKey<DropdownSearchState<ComboRKonstruksiojkModel>>();

	ComboROkupasiModel? fieldComboROkupasi;
	final comboROkupasiKey = GlobalKey<DropdownSearchState<ComboROkupasiModel>>();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	void dispose() {
		// Dispose all text controllers
		fieldInsuredNamaController.dispose();
		fieldInsuredAlamat1Controller.dispose();
		fieldInsuredAlamat2Controller.dispose();
		fieldLokasi1Controller.dispose();
		fieldLokasi2Controller.dispose();
		fieldSppaTglController.dispose();
		fieldPeriodeMulaiController.dispose();
		fieldPeriodeAkhirController.dispose();
		fieldBuildingDescController.dispose();
		fieldContentDescController.dispose();
		fieldMachineryDescController.dispose();
		fieldStockDescController.dispose();
		fieldOtherDescController.dispose();
		fieldSiBuildingController.dispose();
		fieldSiContentController.dispose();
		fieldSiMachineryController.dispose();
		fieldSiStockController.dispose();
		fieldSiOtherController.dispose();
		fieldTsiController.dispose();
		fieldStockAdjustableController.dispose();
		fieldRateParController.dispose();
		fieldRateEqvetController.dispose();
		fieldRateRsmdccController.dispose();
		fieldRateTsfwdController.dispose();
		fieldRateOtherController.dispose();
		fieldRateTotalController.dispose();
		fieldPremiParController.dispose();
		fieldPremiEqvetController.dispose();
		fieldPremiRsmdccController.dispose();
		fieldPremiTsfwdController.dispose();
		fieldPremiOtherController.dispose();
		fieldPremiTotalController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		sppaparCrudBloc = BlocProvider.of<SppaparCrudBloc>(context);

		return BlocConsumer<SppaparCrudBloc, SppaparCrudState>(
			builder: (context, state) {
				return SingleChildScrollView(
					child: Padding(
						padding: const EdgeInsets.all(8.0),
						child: Form(
							key: _formKey,
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									const SizedBox(height: 10),

									// Basic Information Section
									_buildSectionTitle("Informasi Dasar"),
									const SizedBox(height: 10),

									Row(
										children: [
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldSppaTgl(),
												),
											),
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldInsuredNama(),
												),
											),
										],
									),

									const SizedBox(height: 10),
									buildFieldInsuredAlamat1(),
									const SizedBox(height: 10),
									buildFieldInsuredAlamat2(),

									const SizedBox(height: 10),
									Row(
										children: [
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldLokasi1(),
												),
											),
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldLokasi2(),
												),
											),
										],
									),

									const SizedBox(height: 20),

									// Location & Construction Section
									_buildSectionTitle("Lokasi & Konstruksi"),
									const SizedBox(height: 10),

									buildFieldWilayah(),
									const SizedBox(height: 10),
									buildFieldKodepos(),
									const SizedBox(height: 10),
									buildFieldZonaGempa(),
									const SizedBox(height: 10),
									buildFieldKonstruksi(),
									const SizedBox(height: 10),
									buildFieldOkupasi(),

									const SizedBox(height: 20),

									// Period Section
									_buildSectionTitle("Periode Pertanggungan"),
									const SizedBox(height: 10),

									Row(
										children: [
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldPeriodeMulai(),
												),
											),
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldPeriodeAkhir(),
												),
											),
										],
									),

									const SizedBox(height: 20),

									// Coverage Description Section
									_buildSectionTitle("Deskripsi Pertanggungan"),
									const SizedBox(height: 10),

									buildFieldBuildingDesc(),
									const SizedBox(height: 10),
									buildFieldContentDesc(),
									const SizedBox(height: 10),
									buildFieldMachineryDesc(),
									const SizedBox(height: 10),
									buildFieldStockDesc(),
									const SizedBox(height: 10),
									buildFieldOtherDesc(),

									const SizedBox(height: 20),

									// Sum Insured Section
									_buildSectionTitle("Nilai Pertanggungan"),
									const SizedBox(height: 10),

									Row(
										children: [
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldSiBuilding(),
												),
											),
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldSiContent(),
												),
											),
										],
									),

									const SizedBox(height: 10),
									Row(
										children: [
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldSiMachinery(),
												),
											),
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldSiStock(),
												),
											),
										],
									),

									const SizedBox(height: 10),
									Row(
										children: [
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldSiOther(),
												),
											),
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldStockAdjustable(),
												),
											),
										],
									),

									const SizedBox(height: 10),
									Row(
										children: [
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldTsi(),
												),
											),
											Flexible(
												flex: 3,
												child: Container(),
											),
										],
									),

									const SizedBox(height: 20),

									// Rate Section
									_buildSectionTitle("Tarif Premi (%)"),
									const SizedBox(height: 10),

									Row(
										children: [
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldRatePar(),
												),
											),
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldRateEqvet(),
												),
											),
										],
									),

									const SizedBox(height: 10),
									Row(
										children: [
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldRateRsmdcc(),
												),
											),
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldRateTsfwd(),
												),
											),
										],
									),

									const SizedBox(height: 10),
									Row(
										children: [
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldRateOther(),
												),
											),
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldRateTotal(),
												),
											),
										],
									),

									const SizedBox(height: 20),

									// Premium Section
									_buildSectionTitle("Premi"),
									const SizedBox(height: 10),

									Row(
										children: [
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldPremiPar(),
												),
											),
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldPremiEqvet(),
												),
											),
										],
									),

									const SizedBox(height: 10),
									Row(
										children: [
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldPremiRsmdcc(),
												),
											),
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldPremiTsfwd(),
												),
											),
										],
									),

									const SizedBox(height: 10),
									Row(
										children: [
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldPremiOther(),
												),
											),
											Flexible(
												flex: 1,
												child: Padding(
													padding: const EdgeInsets.all(8.0),
													child: buildFieldPremiTotal(),
												),
											),
										],
									),

									LayoutBuilder(
										builder: (context, constraints) {
											final isMobile = constraints.maxWidth < 600;
											final buttonWidth = isMobile ? double.infinity : constraints.maxWidth * 0.4;

											return isMobile
													? Column(
												children: [
													SizedBox(
														width: buttonWidth,
														height: 50,
														child: ElevatedButton(
															onPressed: () => Navigator.pop(context),
															style: ElevatedButton.styleFrom(
																backgroundColor: Colors.grey[600],
																foregroundColor: Colors.white,
															),
															child: const Text('Batal'),
														),
													),
													const SizedBox(height: 12),
													SizedBox(
														width: buttonWidth,
														height: 50,
														child: ElevatedButton(
															onPressed: onSaveForm,
															style: ElevatedButton.styleFrom(
																backgroundColor: const Color(0xffff6101),
																foregroundColor: Colors.white,
															),
															child: const Text('Simpan'),
														),
													),
												],
											)
													: Row(
												mainAxisAlignment: MainAxisAlignment.spaceEvenly,
												children: [
													SizedBox(
														width: buttonWidth,
														height: 50,
														child: ElevatedButton(
															onPressed: () => Navigator.pop(context),
															style: ElevatedButton.styleFrom(
																backgroundColor: Colors.grey[600],
																foregroundColor: Colors.white,
															),
															child: const Text('Batal'),
														),
													),
													SizedBox(
														width: buttonWidth,
														height: 50,
														child: ElevatedButton(
															onPressed: onSaveForm,
															style: ElevatedButton.styleFrom(
																backgroundColor: const Color(0xffff6101),
																foregroundColor: Colors.white,
															),
															child: const Text('Simpan'),
														),
													),
												],
											);
										},
									),
									const SizedBox(height: 20),

									const SizedBox(height: 25),
									FormError(errors: errors, key: null,),
									const SizedBox(height: 10),
								],
							),
						),
					),
				);
			},
			listener: (context, state) {
				if (state.isLoaded) {
					if (state.record != null) {
						_populateFields(state.record!);
					}
					_populateComboFields(state);
				}
			},
		);
	}

	Widget _buildSectionTitle(String title, {IconData? icon}) {
		return Container(
			width: double.infinity,
			padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
			decoration: BoxDecoration(
				color: const Color(0xff91C050).withOpacity(0.1),
				borderRadius: BorderRadius.circular(8.0),
				border: Border.all(color: const Color(0xff91C050).withOpacity(0.3)),
			),
			child: Row(
				children: [
					if (icon != null) ...[
						Icon(
							icon,
							color: const Color(0xff91C050),
							size: 20.0,
						),
						const SizedBox(width: 8.0),
					],
					Text(
						title,
						style: const TextStyle(
							fontSize: 16.0,
							fontWeight: FontWeight.w600,
							color: Color(0xff91C050),
						),
					),
				],
			),
		);
	}

	void loadData() {
		if (widget.viewMode == "ubah") {
			sppaparCrudBloc.add(SppaparCrudLihatEvent(recordId: widget.recordId));
		} else if (widget.viewMode == "tambah") {
			// Add init event if needed
		}
	}

	void _populateFields(SppaparCrudModel record) {
		fieldInsuredNamaController.text = record.insuredNama;
		fieldInsuredAlamat1Controller.text = record.insuredAlamat1;
		fieldInsuredAlamat2Controller.text = record.insuredAlamat2;
		fieldLokasi1Controller.text = record.lokasi1;
		fieldLokasi2Controller.text = record.lokasi2;
		fieldSppaTglController.text = record.sppaTgl.toIso8601String();
		fieldPeriodeMulaiController.text = record.periodeMulai.toIso8601String();
		fieldPeriodeAkhirController.text = record.periodeAkhir.toIso8601String();

		fieldBuildingDescController.text = record.buildingDesc;
		fieldContentDescController.text = record.contentDesc;
		fieldMachineryDescController.text = record.machineryDesc;
		fieldStockDescController.text = record.stockDesc;
		fieldOtherDescController.text = record.otherDesc;

		fieldSiBuildingController.text = NumberFormat("#,###").format(record.siBuilding);
		fieldSiContentController.text = NumberFormat("#,###").format(record.siContent);
		fieldSiMachineryController.text = NumberFormat("#,###").format(record.siMachinery);
		fieldSiStockController.text = NumberFormat("#,###").format(record.siStock);
		fieldSiOtherController.text = NumberFormat("#,###").format(record.siOther);
		fieldTsiController.text = NumberFormat("#,###").format(record.tsi);
		fieldStockAdjustableController.text = NumberFormat("#,###").format(record.stockAdjustable);

		fieldRateParController.text = NumberFormat("#,###.##").format(record.ratePar);
		fieldRateEqvetController.text = NumberFormat("#,###.##").format(record.rateEqvet);
		fieldRateRsmdccController.text = NumberFormat("#,###.##").format(record.rateRsmdcc);
		fieldRateTsfwdController.text = NumberFormat("#,###.##").format(record.rateTsfwd);
		fieldRateOtherController.text = NumberFormat("#,###.##").format(record.rateOther);
		fieldRateTotalController.text = NumberFormat("#,###.##").format(record.rateTotal);

		fieldPremiParController.text = NumberFormat("#,###").format(record.premiPar);
		fieldPremiEqvetController.text = NumberFormat("#,###").format(record.premiEqvet);
		fieldPremiRsmdccController.text = NumberFormat("#,###").format(record.premiRsmdcc);
		fieldPremiTsfwdController.text = NumberFormat("#,###").format(record.premiTsfwd);
		fieldPremiOtherController.text = NumberFormat("#,###").format(record.premiOther);
		fieldPremiTotalController.text = NumberFormat("#,###").format(record.premiTotal);
	}

	void _populateComboFields(SppaparCrudState state) {
		fieldComboMWilayah = state.comboMWilayah;
		fieldComboRKodepos = state.comboRKodepos;
		fieldComboMKabZonaGempa = state.comboMKabZonaGempa;
		fieldComboRKonstruksiojk = state.comboRKonstruksiojk;
		fieldComboROkupasi = state.comboROkupasi;
	}

	// Basic Info Fields
	Widget buildFieldSppaTgl() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				// 🔹 Header
				const Text(
					"Tanggal SPPA",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				// 🔹 Field
				DateTimeFormField(
					mode: DateTimeFieldPickerMode.date,
					dateFormat: DateFormat('dd/MM/yyyy'),
					initialValue: DateTime.tryParse(fieldSppaTglController.text),
					decoration: InputDecoration(
						hintText: "dd/MM/yyyy",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(
							vertical: 14,
							horizontal: 12,
						),
						suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF91C050), size: 20),
					),
					onChanged: (value) {
						if (value != null) {
							removeError(error: kStringNullError);
							fieldSppaTglController.text = value.toIso8601String();
						}
					},
					validator: (value) {
						if (value == null) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldInsuredNama() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Nama Tertanggung",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),
				TextFormField(
					controller: fieldInsuredNamaController,
					decoration: InputDecoration(
						hintText: "Masukkan nama tertanggung",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldInsuredAlamat1() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Alamat Tertanggung 1",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),
				TextFormField(
					keyboardType: TextInputType.multiline,
					minLines: 1,
					maxLines: 3,
					controller: fieldInsuredAlamat1Controller,
					decoration: InputDecoration(
						hintText: "Masukkan alamat tertanggung 1",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldInsuredAlamat2() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Alamat Tertanggung 2",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),
				TextFormField(
					keyboardType: TextInputType.multiline,
					minLines: 1,
					maxLines: 3,
					controller: fieldInsuredAlamat2Controller,
					decoration: InputDecoration(
						hintText: "Masukkan alamat tertanggung 2 (opsional)",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
				),
			],
		);
	}

	Widget buildFieldLokasi1() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Lokasi 1",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),
				TextFormField(
					controller: fieldLokasi1Controller,
					decoration: InputDecoration(
						hintText: "Masukkan lokasi 1",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
				),
			],
		);
	}

	Widget buildFieldLokasi2() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Lokasi 2",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),
				TextFormField(
					controller: fieldLokasi2Controller,
					decoration: InputDecoration(
						hintText: "Masukkan lokasi 2 (opsional)",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
				),
			],
		);
	}

	// Location & Construction Fields
	Widget buildFieldWilayah() {
		return buildFieldComboMWilayah(
			comboKey: comboMWilayahKey,
			labelText: 'Wilayah',
			initItem: fieldComboMWilayah,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(error: "Field Wilayah tidak boleh kosong.");
					sppaparCrudBloc.add(ComboMWilayahChangedEvent(comboMWilayah: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMWilayah = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(error: "Field Wilayah tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldKodepos() {
		return buildFieldComboRKodepos(
			comboKey: comboRKodeposKey,
			labelText: 'Kode Pos',
			kotaId: "",
			initItem: fieldComboRKodepos,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(error: "Field Kode Pos tidak boleh kosong.");
					sppaparCrudBloc.add(ComboRKodeposChangedEvent(comboRKodepos: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboRKodepos = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(error: "Field Kode Pos tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldZonaGempa() {
		return buildFieldComboMKabZonaGempa(
			comboKey: comboMKabZonaGempaKey,
			labelText: 'Zona Gempa',
			initItem: fieldComboMKabZonaGempa,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(error: "Field Zona Gempa tidak boleh kosong.");
					sppaparCrudBloc.add(ComboMKabZonaGempaChangedEvent(comboMKabZonaGempa: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMKabZonaGempa = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(error: "Field Zona Gempa tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldKonstruksi() {
		return buildFieldComboRKonstruksiojk(
			comboKey: comboRKonstruksiojkKey,
			labelText: 'Konstruksi',
			initItem: fieldComboRKonstruksiojk,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(error: "Field Konstruksi tidak boleh kosong.");
					sppaparCrudBloc.add(ComboRKonstruksiojkChangedEvent(comboRKonstruksiojk: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboRKonstruksiojk = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(error: "Field Konstruksi tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldOkupasi() {
		return buildFieldComboROkupasi(
			comboKey: comboROkupasiKey,
			labelText: 'Okupasi',
			initItem: fieldComboROkupasi,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(error: "Field Okupasi tidak boleh kosong.");
					sppaparCrudBloc.add(ComboROkupasiChangedEvent(comboROkupasi: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboROkupasi = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(error: "Field Okupasi tidak boleh kosong.");
				}
			},
		);
	}

	// Period Fields
	Widget buildFieldPeriodeMulai() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Periode Mulai",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				DateTimeFormField(
					mode: DateTimeFieldPickerMode.date,
					dateFormat: DateFormat('dd/MM/yyyy'),
					initialValue: DateTime.tryParse(fieldPeriodeMulaiController.text),
					decoration: InputDecoration(
						hintText: "dd/MM/yyyy",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
						suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF91C050), size: 20),
					),
					onChanged: (value) {
						if (value != null) {
							removeError(error: kStringNullError);
							fieldPeriodeMulaiController.text = value.toIso8601String();
						}
					},
					validator: (value) {
						if (value == null) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldPeriodeAkhir() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Periode Akhir",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				DateTimeFormField(
					mode: DateTimeFieldPickerMode.date,
					dateFormat: DateFormat('dd/MM/yyyy'),
					initialValue: DateTime.tryParse(fieldPeriodeAkhirController.text),
					decoration: InputDecoration(
						hintText: "dd/MM/yyyy",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
						suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF91C050), size: 20),
					),
					onChanged: (value) {
						if (value != null) {
							removeError(error: kStringNullError);
							fieldPeriodeAkhirController.text = value.toIso8601String();
						}
					},
					validator: (value) {
						if (value == null) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	// Coverage Description Fields
	Widget buildFieldBuildingDesc() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Deskripsi Bangunan",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.multiline,
					minLines: 1,
					maxLines: 3,
					controller: fieldBuildingDescController,
					decoration: InputDecoration(
						hintText: "Masukkan deskripsi bangunan",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}


	Widget buildFieldContentDesc() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Deskripsi Isi",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.multiline,
					minLines: 1,
					maxLines: 3,
					controller: fieldContentDescController,
					decoration: InputDecoration(
						hintText: "Masukkan deskripsi isi",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldMachineryDesc() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Deskripsi Mesin",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.multiline,
					minLines: 1,
					maxLines: 3,
					controller: fieldMachineryDescController,
					decoration: InputDecoration(
						hintText: "Masukkan deskripsi mesin",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldStockDesc() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Deskripsi Stock",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.multiline,
					minLines: 1,
					maxLines: 3,
					controller: fieldStockDescController,
					decoration: InputDecoration(
						hintText: "Masukkan deskripsi stock",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldOtherDesc() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Deskripsi Lainnya",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.multiline,
					minLines: 1,
					maxLines: 3,
					controller: fieldOtherDescController,
					decoration: InputDecoration(
						hintText: "Masukkan deskripsi lainnya",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	// Sum Insured Fields
	Widget buildFieldSiBuilding() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"SI Bangunan",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldSiBuildingController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan nilai SI bangunan",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						prefixText: "IDR ",
						prefixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldSiContent() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"SI Isi",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldSiContentController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan nilai SI isi",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						prefixText: "IDR ",
						prefixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldSiMachinery() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"SI Mesin",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldSiMachineryController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan nilai SI mesin",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						prefixText: "IDR ",
						prefixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldSiStock() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"SI Stock",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldSiStockController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan nilai SI stock",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						prefixText: "IDR ",
						prefixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldSiOther() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"SI Lainnya",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldSiOtherController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan nilai SI lainnya",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						prefixText: "IDR ",
						prefixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldStockAdjustable() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Stock Adjustable",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldStockAdjustableController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan nilai stock adjustable",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						prefixText: "IDR ",
						prefixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldTsi() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Total Sum Insured (TSI)",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldTsiController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan total sum insured",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						prefixText: "IDR ",
						prefixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	// Rate Fields
	Widget buildFieldRatePar() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Rate PAR",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldRateParController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan rate PAR",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						suffixText: "%",
						suffixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldRateEqvet() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Rate EQVET",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldRateEqvetController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan rate EQVET",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						suffixText: "%",
						suffixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldRateRsmdcc() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Rate RSMDCC",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldRateRsmdccController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan rate RSMDCC",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						suffixText: "%",
						suffixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldRateTsfwd() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Rate TSFWD",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldRateTsfwdController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan rate TSFWD",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						suffixText: "%",
						suffixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldRateOther() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Rate Other",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldRateOtherController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan rate lainnya",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						suffixText: "%",
						suffixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldRateTotal() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Rate Total",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldRateTotalController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan rate total",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						suffixText: "%",
						suffixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	// Premium Fields
	Widget buildFieldPremiPar() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Premi PAR",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldPremiParController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan premi PAR",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						prefixText: "IDR ",
						prefixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldPremiEqvet() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Premi EQVET",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldPremiEqvetController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan premi EQVET",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						prefixText: "IDR ",
						prefixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldPremiRsmdcc() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Premi RSMDCC",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldPremiRsmdccController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan premi RSMDCC",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						prefixText: "IDR ",
						prefixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldPremiTsfwd() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Premi TSFWD",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldPremiTsfwdController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan premi TSFWD",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						prefixText: "IDR ",
						prefixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldPremiOther() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Premi Other",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldPremiOtherController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan premi lainnya",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						prefixText: "IDR ",
						prefixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	Widget buildFieldPremiTotal() {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const Text(
					"Premi Total",
					style: TextStyle(
						fontFamily: 'Satoshi-Regular',
						fontSize: 16,
						fontWeight: FontWeight.w500,
						color: Color(0xFF1C1C1C),
					),
				),
				const SizedBox(height: 8),

				TextFormField(
					keyboardType: TextInputType.number,
					inputFormatters: [ThousandsSeparatorInputFormatter()],
					controller: fieldPremiTotalController,
					textAlign: TextAlign.left,
					decoration: InputDecoration(
						hintText: "Masukkan premi total",
						hintStyle: TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							color: const Color(0xFF1C1C1C).withOpacity(0.4),
						),
						prefixText: "IDR ",
						prefixStyle: const TextStyle(
							fontFamily: 'Satoshi-Regular',
							fontSize: 15,
							fontWeight: FontWeight.w500,
							color: Color(0xFF1C1C1C),
						),
						enabledBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 1.2),
						),
						focusedBorder: OutlineInputBorder(
							borderRadius: BorderRadius.circular(8),
							borderSide: const BorderSide(color: Color(0xFF91C050), width: 2),
						),
						contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
					),
					onChanged: (value) {
						if (value.isNotEmpty) removeError(error: kStringNullError);
					},
					validator: (value) {
						if (value == null || value.isEmpty) {
							addError(error: kStringNullError);
							return "";
						}
						return null;
					},
				),
			],
		);
	}

	// Utility Methods
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

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			SppaparCrudModel record = SppaparCrudModel(
				buildingDesc: fieldBuildingDescController.text,
				contentDesc: fieldContentDescController.text,
				insuredAlamat1: fieldInsuredAlamat1Controller.text,
				insuredAlamat2: fieldInsuredAlamat2Controller.text,
				insuredNama: fieldInsuredNamaController.text,
				kab2zonagempaId: fieldComboMKabZonaGempa?.mkabzonagempaId,
				lokasi1: fieldLokasi1Controller.text,
				lokasi2: fieldLokasi2Controller.text,
				machineryDesc: fieldMachineryDescController.text,
				mwilayahId: fieldComboMWilayah?.mwilayahId,
				otherDesc: fieldOtherDescController.text,
				periodeAkhir: DateTime.parse(fieldPeriodeAkhirController.text),
				periodeMulai: DateTime.parse(fieldPeriodeMulaiController.text),
				premiEqvet: double.parse(fieldPremiEqvetController.text.replaceAll(',', '')),
				premiOther: double.parse(fieldPremiOtherController.text.replaceAll(',', '')),
				premiPar: double.parse(fieldPremiParController.text.replaceAll(',', '')),
				premiRsmdcc: double.parse(fieldPremiRsmdccController.text.replaceAll(',', '')),
				premiTotal: double.parse(fieldPremiTotalController.text.replaceAll(',', '')),
				premiTsfwd: double.parse(fieldPremiTsfwdController.text.replaceAll(',', '')),
				rateEqvet: double.parse(fieldRateEqvetController.text.replaceAll(',', '')),
				rateOther: double.parse(fieldRateOtherController.text.replaceAll(',', '')),
				ratePar: double.parse(fieldRateParController.text.replaceAll(',', '')),
				rateRsmdcc: double.parse(fieldRateRsmdccController.text.replaceAll(',', '')),
				rateTotal: double.parse(fieldRateTotalController.text.replaceAll(',', '')),
				rateTsfwd: double.parse(fieldRateTsfwdController.text.replaceAll(',', '')),
				rkodeposId: fieldComboRKodepos?.rkodeposId,
				rkonstruksiojkId: fieldComboRKonstruksiojk?.rkonstruksiojkId,
				rokupasiId: fieldComboROkupasi?.rokupasiId,
				siBuilding: double.parse(fieldSiBuildingController.text.replaceAll(',', '')),
				siContent: double.parse(fieldSiContentController.text.replaceAll(',', '')),
				siMachinery: double.parse(fieldSiMachineryController.text.replaceAll(',', '')),
				siOther: double.parse(fieldSiOtherController.text.replaceAll(',', '')),
				siStock: double.parse(fieldSiStockController.text.replaceAll(',', '')),
				sppaTgl: DateTime.parse(fieldSppaTglController.text),
				sppa1Id: '',
				stockAdjustable: double.parse(fieldStockAdjustableController.text.replaceAll(',', '')),
				stockDesc: fieldStockDescController.text,
				tsi: double.parse(fieldTsiController.text.replaceAll(',', '')),
			);

			if (widget.viewMode == "tambah") {
				sppaparCrudBloc.add(SppaparCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.sppa1Id = sppaparCrudBloc.state.record!.sppa1Id;
				sppaparCrudBloc.add(SppaparCrudUbahEvent(record: record));
			}
		}
	}
}