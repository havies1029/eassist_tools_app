import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/regklaim/regklaim1crud_bloc.dart';
import 'package:eassist_tools_app/models/regklaim/regklaim1crud_model.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import 'package:string_validator/string_validator.dart';
import 'package:eassist_tools_app/widgets/checkbox_widget.dart';

class Regklaim1CrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const Regklaim1CrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	Regklaim1CrudFormPageFormState createState() => Regklaim1CrudFormPageFormState();
}

class Regklaim1CrudFormPageFormState extends State<Regklaim1CrudFormPage> {
	late Regklaim1CrudBloc regklaim1CrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldInsuredNamaController = TextEditingController();
	var fieldIsPolisJpsController = TextEditingController();
	var fieldPolisAkhirController = TextEditingController(text: DateTime.now().toIso8601String());
	var fieldPolisMulaiController = TextEditingController(text: DateTime.now().toIso8601String());
	var fieldPolisNoController = TextEditingController();
	var fieldRegTglController = TextEditingController(text: DateTime.now().toIso8601String());

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		regklaim1CrudBloc = BlocProvider.of<Regklaim1CrudBloc>(context);
		return BlocConsumer<Regklaim1CrudBloc, Regklaim1CrudState>(
			builder: (context, state) {
				return SingleChildScrollView(
					child: Padding(
						padding: const EdgeInsets.all(8.0),
						child: Form(
							key: _formKey,
							child: Column(
								children: [
									const SizedBox(height: 10),
									Text(
										"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Registrasi Klaim",
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
									buildFieldInsuredNama(),
									buildFieldIsPolisJps(),
									buildFieldMinsuranceId(),
									buildFieldMrekan1Id(),
									buildFieldPolisAkhir(),
									buildFieldPolisMulai(),
									buildFieldPolisNo(),
									buildFieldRegTgl(),
									buildFieldSppa1Id(),
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
				);
				},
				listener: (context, state) {
					if (state.isLoaded) {
						if (state.record != null){
							fieldInsuredNamaController.text = state.record!.insuredNama;
							fieldIsPolisJpsController.text = state.record!.isPolisJps.toString();
							fieldPolisAkhirController.text = state.record!.polisAkhir.toIso8601String();
							fieldPolisMulaiController.text = state.record!.polisMulai.toIso8601String();
							fieldPolisNoController.text = state.record!.polisNo;
							fieldRegTglController.text = state.record!.regTgl.toIso8601String();
						}
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		regklaim1CrudBloc.add(
			Regklaim1CrudLihatEvent(recordId: widget.recordId));
		}
	}

	Widget buildFieldInsuredNama(){
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldInsuredNamaController,
			decoration: const InputDecoration(
				labelText: "insuredNama",
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
		);
	}

	Widget buildFieldIsPolisJps(){
		return CheckboxWidget(
			leftLabel: "",
			rightLabel: "isPolisJps",
			initialValue: toBoolean(fieldIsPolisJpsController.text),
			callback: (value) {
				setState(() {
					fieldIsPolisJpsController.text = value.toString();
				});
			}
		);
	}

	Widget buildFieldMinsuranceId(){
		return TextFormField(
		);
	}

	Widget buildFieldMrekan1Id(){
		return TextFormField(
		);
	}

	Widget buildFieldPolisAkhir(){
		return DateTimeFormField(
			mode: DateTimeFieldPickerMode.date,
			dateFormat: DateFormat('dd/MM/yyyy'),
			initialValue: DateTime.tryParse(fieldPolisAkhirController.text),
			decoration: const InputDecoration(
				labelText: "polisAkhir",
				floatingLabelBehavior: FloatingLabelBehavior.always,
			),
			onChanged: (value) {
				if (value != null) {
				removeError(error: kStringNullError);
					fieldPolisAkhirController.text = value.toIso8601String();
				}
			},
			validator: (value) {
				if (value == null) {
					addError(error: kStringNullError);
					return "";
				}
				return null;
			},
		);
	}

	Widget buildFieldPolisMulai(){
		return DateTimeFormField(
			mode: DateTimeFieldPickerMode.date,
			dateFormat: DateFormat('dd/MM/yyyy'),
			initialValue: DateTime.tryParse(fieldPolisMulaiController.text),
			decoration: const InputDecoration(
				labelText: "polisMulai",
				floatingLabelBehavior: FloatingLabelBehavior.always,
			),
			onChanged: (value) {
				if (value != null) {
				removeError(error: kStringNullError);
					fieldPolisMulaiController.text = value.toIso8601String();
				}
			},
			validator: (value) {
				if (value == null) {
					addError(error: kStringNullError);
					return "";
				}
				return null;
			},
		);
	}

	Widget buildFieldPolisNo(){
		return TextFormField(
			controller: fieldPolisNoController,
			decoration: const InputDecoration(
				labelText: "polisNo",
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
		);
	}

	Widget buildFieldRegTgl(){
		return DateTimeFormField(
			mode: DateTimeFieldPickerMode.date,
			dateFormat: DateFormat('dd/MM/yyyy'),
			initialValue: DateTime.tryParse(fieldRegTglController.text),
			decoration: const InputDecoration(
				labelText: "regTgl",
				floatingLabelBehavior: FloatingLabelBehavior.always,
			),
			onChanged: (value) {
				if (value != null) {
				removeError(error: kStringNullError);
					fieldRegTglController.text = value.toIso8601String();
				}
			},
			validator: (value) {
				if (value == null) {
					addError(error: kStringNullError);
					return "";
				}
				return null;
			},
		);
	}

	Widget buildFieldSppa1Id(){
		return TextFormField(
		);
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			Regklaim1CrudModel record = Regklaim1CrudModel(
				insuredNama: fieldInsuredNamaController.text,
				isPolisJps: toBoolean(fieldIsPolisJpsController.text),
				polisAkhir: DateTime.parse(fieldPolisAkhirController.text),
				polisMulai: DateTime.parse(fieldPolisMulaiController.text),
				polisNo: fieldPolisNoController.text,
				regTgl: DateTime.parse(fieldRegTglController.text),
				regklaim1Id: '',
			);
			if (widget.viewMode == "tambah") {
				regklaim1CrudBloc.add(Regklaim1CrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.regklaim1Id = regklaim1CrudBloc.state.record!.regklaim1Id;
				regklaim1CrudBloc.add(Regklaim1CrudUbahEvent(record: record));
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
