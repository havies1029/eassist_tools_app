import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/gen_calmv/calmv2form_bloc.dart';
import 'package:eassist_tools_app/models/gen_calmv/calmv2form_model.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:string_validator/string_validator.dart';
import 'package:eassist_tools_app/widgets/checkbox_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';


class Calmv2FormFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const Calmv2FormFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	Calmv2FormFormPageFormState createState() => Calmv2FormFormPageFormState();
}

class Calmv2FormFormPageFormState extends State<Calmv2FormFormPage> {
	late Calmv2FormBloc calmv2FormBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldAwController = TextEditingController();
	var fieldIsEqController = TextEditingController();
	var fieldIsFloodController = TextEditingController();
	var fieldIsSrccController = TextEditingController();
	var fieldIsTbodController = TextEditingController();
	var fieldIsTerrorismController = TextEditingController();
	var fieldPadController = TextEditingController();
	var fieldPapController = TextEditingController();
	var fieldPassangerCountController = TextEditingController();
	var fieldPllController = TextEditingController();
	var fieldTplController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		calmv2FormBloc = BlocProvider.of<Calmv2FormBloc>(context);
		return BlocConsumer<Calmv2FormBloc, Calmv2FormState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Perlindungan Tambahan",
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
										buildFieldAw(),
										buildFieldCalmv1Id(),
										buildFieldIsEq(),
										buildFieldIsFlood(),
										buildFieldIsSrcc(),
										buildFieldIsTbod(),
										buildFieldIsTerrorism(),
										buildFieldPad(),
										buildFieldPap(),
										buildFieldPassangerCount(),
										buildFieldPll(),
										buildFieldTpl(),
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
							fieldAwController.text = NumberFormat("#,###").format(state.record!.aw);
							fieldIsEqController.text = state.record!.isEq.toString();
							fieldIsFloodController.text = state.record!.isFlood.toString();
							fieldIsSrccController.text = state.record!.isSrcc.toString();
							fieldIsTbodController.text = state.record!.isTbod.toString();
							fieldIsTerrorismController.text = state.record!.isTerrorism.toString();
							fieldPadController.text = NumberFormat("#,###").format(state.record!.pad);
							fieldPapController.text = NumberFormat("#,###").format(state.record!.pap);
							fieldPassangerCountController.text = state.record!.passangerCount.toString();
							fieldPllController.text = NumberFormat("#,###").format(state.record!.pll);
							fieldTplController.text = NumberFormat("#,###").format(state.record!.tpl);
						}
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		calmv2FormBloc.add(
			Calmv2FormLihatEvent(recordId: widget.recordId));
		}
	}

	Widget buildFieldAw(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldAwController,
			decoration: const InputDecoration(
				labelText: "aw",
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
		);
	}

	Widget buildFieldCalmv1Id(){
		return TextFormField(
		);
	}

	Widget buildFieldIsEq(){
		return CheckboxWidget(
			leftLabel: "",
			rightLabel: "isEq",
			initialValue: toBoolean(fieldIsEqController.text),
			callback: (value) {
				setState(() {
					fieldIsEqController.text = value.toString();
				});
			}
		);
	}

	Widget buildFieldIsFlood(){
		return CheckboxWidget(
			leftLabel: "",
			rightLabel: "isFlood",
			initialValue: toBoolean(fieldIsFloodController.text),
			callback: (value) {
				setState(() {
					fieldIsFloodController.text = value.toString();
				});
			}
		);
	}

	Widget buildFieldIsSrcc(){
		return CheckboxWidget(
			leftLabel: "",
			rightLabel: "isSrcc",
			initialValue: toBoolean(fieldIsSrccController.text),
			callback: (value) {
				setState(() {
					fieldIsSrccController.text = value.toString();
				});
			}
		);
	}

	Widget buildFieldIsTbod(){
		return CheckboxWidget(
			leftLabel: "",
			rightLabel: "isTbod",
			initialValue: toBoolean(fieldIsTbodController.text),
			callback: (value) {
				setState(() {
					fieldIsTbodController.text = value.toString();
				});
			}
		);
	}

	Widget buildFieldIsTerrorism(){
		return CheckboxWidget(
			leftLabel: "",
			rightLabel: "isTerrorism",
			initialValue: toBoolean(fieldIsTerrorismController.text),
			callback: (value) {
				setState(() {
					fieldIsTerrorismController.text = value.toString();
				});
			}
		);
	}

	Widget buildFieldPad(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldPadController,
			decoration: const InputDecoration(
				labelText: "pad",
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
		);
	}

	Widget buildFieldPap(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldPapController,
			decoration: const InputDecoration(
				labelText: "pap",
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
		);
	}

	Widget buildFieldPassangerCount(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldPassangerCountController,
			decoration: const InputDecoration(
				labelText: "passangerCount",
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
		);
	}

	Widget buildFieldPll(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldPllController,
			decoration: const InputDecoration(
				labelText: "pll",
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
		);
	}

	Widget buildFieldTpl(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldTplController,
			decoration: const InputDecoration(
				labelText: "tpl",
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
		);
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			Calmv2FormModel record = Calmv2FormModel(
				aw: double.parse(fieldAwController.text.replaceAll(',', '')),
				calmv2Id: '',
				isEq: toBoolean(fieldIsEqController.text),
				isFlood: toBoolean(fieldIsFloodController.text),
				isSrcc: toBoolean(fieldIsSrccController.text),
				isTbod: toBoolean(fieldIsTbodController.text),
				isTerrorism: toBoolean(fieldIsTerrorismController.text),
				pad: double.parse(fieldPadController.text.replaceAll(',', '')),
				pap: double.parse(fieldPapController.text.replaceAll(',', '')),
				passangerCount: int.parse(fieldPassangerCountController.text),
				pll: double.parse(fieldPllController.text.replaceAll(',', '')),
				tpl: double.parse(fieldTplController.text.replaceAll(',', '')),
			);
			if (widget.viewMode == "tambah") {
				calmv2FormBloc.add(Calmv2FormTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.calmv2Id = calmv2FormBloc.state.record!.calmv2Id;
				calmv2FormBloc.add(Calmv2FormUbahEvent(record: record));
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
