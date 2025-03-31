import 'package:eassist_tools_app/widgets/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/simulwp/simulwpcrud_bloc.dart';
import 'package:eassist_tools_app/models/simulwp/simulwpcrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SimulwpCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const SimulwpCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	SimulwpCrudFormPageFormState createState() => SimulwpCrudFormPageFormState();
}

class SimulwpCrudFormPageFormState extends State<SimulwpCrudFormPage> {
	late SimulwpCrudBloc simulwpCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	final Map<String, bool> fieldErrors = {};

	var fieldCoverBulanController = TextEditingController();
	var fieldPlafondController = TextEditingController();
	var fieldPremiController = TextEditingController();
	var fieldRateController = TextEditingController();
	var fieldUsiaController = TextEditingController();
	ComboRMatauangModel? fieldComboRMatauang;

	@override
	Widget build(BuildContext context) {
		simulwpCrudBloc = BlocProvider.of<SimulwpCrudBloc>(context);
		return Dialog(
			backgroundColor: MyColors.white,
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
			child: SingleChildScrollView(
				padding: const EdgeInsets.all(16.0),
				child: Form(
					key: _formKey,
					child: Column(
						mainAxisSize: MainAxisSize.min,
						children: [
							const SizedBox(height: 20),
							_buildTextField(fieldCoverBulanController, "Cover Bulan"),
							_buildTextField(fieldPlafondController, "Plafond"),
							_buildTextField(fieldPremiController, "Premi"),
							_buildTextField(fieldRateController, "Rate"),
							_buildTextField(fieldUsiaController, "Usia"),
							const SizedBox(height: 25),
							FormError(errors: errors, key: null,),
							const SizedBox(height: 15),
							Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: [
									_buildButton("Reset", Colors.grey, _dismissDialog),
									_buildButton("Hitung", Colors.orange, onSaveForm),
								],
							),
						],
					),
				),
			),
		);
	}

	Widget _buildTextField(TextEditingController controller, String label) {
		return Padding(
			padding: const EdgeInsets.symmetric(vertical: 8.0),
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					TextFormField(
						controller: controller,
						keyboardType: TextInputType.number,
						inputFormatters: [ThousandsSeparatorInputFormatter()],
						decoration: InputDecoration(
							labelText: label,
							labelStyle: TextStyle(color: fieldErrors[label] == true ? Colors.red : Colors.black54),
							enabledBorder: UnderlineInputBorder(
								borderSide: BorderSide(color: fieldErrors[label] == true ? Colors.red : Colors.black38),
							),
							focusedBorder: UnderlineInputBorder(
								borderSide: BorderSide(color: fieldErrors[label] == true ? Colors.red : Colors.orange),
							),
							filled: true,
							fillColor: Colors.white,
						),
						validator: (value) {
							if (value == null || value.isEmpty) {
								setState(() => fieldErrors[label] = true);
								addError(error: "$label tidak boleh kosong");
								return "";
							}
							setState(() => fieldErrors[label] = false);
							return null;
						},
						textAlign: TextAlign.right,
					),
					if (fieldErrors[label] == true)
						Padding(
							padding: const EdgeInsets.only(top: 4.0),
							child: Text(
								"$label wajib diisi",
								style: const TextStyle(color: Colors.red, fontSize: 12),
							),
						),
				],
			),
		);
	}

	Widget _buildButton(String text, Color color, VoidCallback onPressed) {
		return ElevatedButton(
			onPressed: onPressed,
			style: ElevatedButton.styleFrom(
				backgroundColor: color,
				shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
				minimumSize: const Size(120, 45),
			),
			child: Text(
				text,
				style: const TextStyle(color: Colors.white, fontSize: 16),
			),
		);
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		setState(() => fieldErrors.clear());
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			SimulwpCrudModel record = SimulwpCrudModel(
				coverBulan: int.parse(fieldCoverBulanController.text),
				plafond: double.parse(fieldPlafondController.text.replaceAll(',', '')),
				premi: double.parse(fieldPremiController.text.replaceAll(',', '')),
				rate: double.parse(fieldRateController.text.replaceAll(',', '')),
				rmatauangKode: fieldComboRMatauang?.rmatauangKode,
				simulwp1Id: '',
				usia: int.parse(fieldUsiaController.text),
			);
			if (widget.viewMode == "tambah") {
				simulwpCrudBloc.add(SimulwpCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.simulwp1Id = simulwpCrudBloc.state.record!.simulwp1Id;
				simulwpCrudBloc.add(SimulwpCrudUbahEvent(record: record));
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
}
