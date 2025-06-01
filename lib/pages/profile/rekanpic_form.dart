import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/profile/rekanpic_bloc.dart';
import 'package:eassist_tools_app/models/profile/rekanpic_model.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:dropdown_search/dropdown_search.dart';


class RekanPicFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const RekanPicFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	RekanPicFormPageFormState createState() => RekanPicFormPageFormState();
}

class RekanPicFormPageFormState extends State<RekanPicFormPage> {
	late RekanPicBloc rekanPicBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldIsDefaultController = TextEditingController();
	var fieldPicEmailController = TextEditingController();
	var fieldPicHpController = TextEditingController();
	var fieldPicNamaController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		rekanPicBloc = BlocProvider.of<RekanPicBloc>(context);
		return BlocConsumer<RekanPicBloc, RekanPicState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Informasi PIC",
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
										buildFieldIsDefault(),
										buildFieldMjabatanId(),
										buildFieldMrekan1Id(),
										buildFieldPicEmail(),
										buildFieldPicHp(),
										buildFieldPicNama(),
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
							fieldIsDefaultController.text = state.record!.isDefault.toString();
							fieldPicEmailController.text = state.record!.picEmail;
							fieldPicHpController.text = state.record!.picHp;
							fieldPicNamaController.text = state.record!.picNama;
						}
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		rekanPicBloc.add(
			RekanPicLihatEvent(recordId: widget.recordId));
		}
	}

	Widget buildFieldIsDefault(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldIsDefaultController,
			decoration: const InputDecoration(
				labelText: "isDefault",
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

	Widget buildFieldMjabatanId(){
		return TextFormField(
		);
	}

	Widget buildFieldMrekan1Id(){
		return TextFormField(
		);
	}

	Widget buildFieldPicEmail(){
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldPicEmailController,
			decoration: const InputDecoration(
				labelText: "picEmail",
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

	Widget buildFieldPicHp(){
		return TextFormField(
			controller: fieldPicHpController,
			decoration: const InputDecoration(
				labelText: "picHp",
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

	Widget buildFieldPicNama(){
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldPicNamaController,
			decoration: const InputDecoration(
				labelText: "picNama",
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

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			RekanPicModel record = RekanPicModel(
				isDefault: int.parse(fieldIsDefaultController.text),
				mrekanpicId: '',
				picEmail: fieldPicEmailController.text,
				picHp: fieldPicHpController.text,
				picNama: fieldPicNamaController.text,
			);
			if (widget.viewMode == "tambah") {
				rekanPicBloc.add(RekanPicTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mrekanpicId = rekanPicBloc.state.record!.mrekanpicId;
				rekanPicBloc.add(RekanPicUbahEvent(record: record));
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
