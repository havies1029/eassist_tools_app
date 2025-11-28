import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/gen_calmv/calmv3form_bloc.dart';
import 'package:eassist_tools_app/models/gen_calmv/calmv3form_model.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';


class Calmv3FormFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const Calmv3FormFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	Calmv3FormFormPageFormState createState() => Calmv3FormFormPageFormState();
}

class Calmv3FormFormPageFormState extends State<Calmv3FormFormPage> {
	late Calmv3FormBloc calmv3FormBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldDiskonPersenController = TextEditingController();
	var fieldPremiAddController = TextEditingController();
	var fieldPremiCascoController = TextEditingController();
	var fieldPremiDiskonController = TextEditingController();
	var fieldPremiNetController = TextEditingController();
	var fieldPremiSubtotalController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		calmv3FormBloc = BlocProvider.of<Calmv3FormBloc>(context);
		return BlocConsumer<Calmv3FormBloc, Calmv3FormState>(
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
										buildFieldCalmv1Id(),
										buildFieldDiskonPersen(),
										buildFieldPremiAdd(),
										buildFieldPremiCasco(),
										buildFieldPremiDiskon(),
										buildFieldPremiNet(),
										buildFieldPremiSubtotal(),
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
							fieldDiskonPersenController.text = NumberFormat("#,###").format(state.record!.diskonPersen);
							fieldPremiAddController.text = NumberFormat("#,###").format(state.record!.premiAdd);
							fieldPremiCascoController.text = NumberFormat("#,###").format(state.record!.premiCasco);
							fieldPremiDiskonController.text = NumberFormat("#,###").format(state.record!.premiDiskon);
							fieldPremiNetController.text = NumberFormat("#,###").format(state.record!.premiNet);
							fieldPremiSubtotalController.text = NumberFormat("#,###").format(state.record!.premiSubtotal);
						}
					}
				},
			);
		}
	void loadData() {
		
		calmv3FormBloc.add(
			Calmv3FormLihatEvent(calmv1Id: widget.recordId));
		
	}

	Widget buildFieldCalmv1Id(){
		return TextFormField(
		);
	}

	Widget buildFieldDiskonPersen(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldDiskonPersenController,
			decoration: const InputDecoration(
				labelText: "diskonPersen",
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

	Widget buildFieldPremiAdd(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldPremiAddController,
			decoration: const InputDecoration(
				labelText: "premiAdd",
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

	Widget buildFieldPremiCasco(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldPremiCascoController,
			decoration: const InputDecoration(
				labelText: "premiCasco",
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

	Widget buildFieldPremiDiskon(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldPremiDiskonController,
			decoration: const InputDecoration(
				labelText: "premiDiskon",
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

	Widget buildFieldPremiNet(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldPremiNetController,
			decoration: const InputDecoration(
				labelText: "premiNet",
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

	Widget buildFieldPremiSubtotal(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldPremiSubtotalController,
			decoration: const InputDecoration(
				labelText: "premiSubtotal",
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
			Calmv3FormModel record = Calmv3FormModel(
				calmv3Id: '',
				diskonPersen: double.parse(fieldDiskonPersenController.text.replaceAll(',', '')),
				premiAdd: double.parse(fieldPremiAddController.text.replaceAll(',', '')),
				premiCasco: double.parse(fieldPremiCascoController.text.replaceAll(',', '')),
				premiDiskon: double.parse(fieldPremiDiskonController.text.replaceAll(',', '')),
				premiNet: double.parse(fieldPremiNetController.text.replaceAll(',', '')),
				premiSubtotal: double.parse(fieldPremiSubtotalController.text.replaceAll(',', '')),
			);
			if (widget.viewMode == "tambah") {
				calmv3FormBloc.add(Calmv3FormTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.calmv3Id = calmv3FormBloc.state.record!.calmv3Id;
				calmv3FormBloc.add(Calmv3FormUbahEvent(record: record));
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
