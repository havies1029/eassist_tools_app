import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/perbaruiklaimpar/klaim5parcrud_bloc.dart';
import 'package:eassist_tools_app/models/perbaruiklaimpar/klaim5parcrud_model.dart';


class Klaim5parCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const Klaim5parCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	Klaim5parCrudFormPageFormState createState() => Klaim5parCrudFormPageFormState();
}

class Klaim5parCrudFormPageFormState extends State<Klaim5parCrudFormPage> {
	late Klaim5parCrudBloc klaim5parCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldCaptionController = TextEditingController();
	var fieldFileStreamIdController = TextEditingController();
	var fieldJenisDocLainController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		klaim5parCrudBloc = BlocProvider.of<Klaim5parCrudBloc>(context);
		return BlocConsumer<Klaim5parCrudBloc, Klaim5parCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Dokumen Klaim",
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
										buildFieldCaption(),
										buildFieldJenisDocLain(),
										buildFieldKlaim1Id(),
										buildFieldMjenisdocId(),
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
							fieldCaptionController.text = state.record!.caption;
							fieldJenisDocLainController.text = state.record!.jenisDocLain;
						}
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		klaim5parCrudBloc.add(
			Klaim5parCrudLihatEvent(recordId: widget.recordId));
		}
	}

	Widget buildFieldCaption(){
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldCaptionController,
			decoration: const InputDecoration(
				labelText: "caption",
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

	Widget buildFieldFileStreamId(){
		return TextFormField(
			controller: fieldFileStreamIdController,
			decoration: const InputDecoration(
				labelText: "fileStreamId",
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

	Widget buildFieldJenisDocLain(){
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldJenisDocLainController,
			decoration: const InputDecoration(
				labelText: "jenisDocLain",
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

	Widget buildFieldKlaim1Id(){
		return TextFormField(
		);
	}

	Widget buildFieldMjenisdocId(){
		return TextFormField(
		);
	}

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			Klaim5parCrudModel record = Klaim5parCrudModel(
				caption: fieldCaptionController.text,
				jenisDocLain: fieldJenisDocLainController.text,
				klaim5Id: '',
			);
			if (widget.viewMode == "tambah") {
				klaim5parCrudBloc.add(Klaim5parCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.klaim5Id = klaim5parCrudBloc.state.record!.klaim5Id;
				klaim5parCrudBloc.add(Klaim5parCrudUbahEvent(record: record));
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
