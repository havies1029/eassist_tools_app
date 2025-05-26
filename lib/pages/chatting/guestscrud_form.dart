import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/chatting/guestscrud_bloc.dart';
import 'package:eassist_tools_app/models/chatting/guestscrud_model.dart';


class GuestsCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const GuestsCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	GuestsCrudFormPageFormState createState() => GuestsCrudFormPageFormState();
}

class GuestsCrudFormPageFormState extends State<GuestsCrudFormPage> {
	late GuestsCrudBloc guestsCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldEmailController = TextEditingController();
	var fieldNameController = TextEditingController();
	var fieldPhoneController = TextEditingController();
	var fieldSessionTokenController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		guestsCrudBloc = BlocProvider.of<GuestsCrudBloc>(context);
		return BlocConsumer<GuestsCrudBloc, GuestsCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Start Chat",
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
										buildFieldEmail(),
										buildFieldName(),
										buildFieldPhone(),
										buildFieldSessionToken(),
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
							fieldEmailController.text = state.record!.email;
							fieldNameController.text = state.record!.name;
							fieldPhoneController.text = state.record!.phone;
							fieldSessionTokenController.text = state.record!.sessionToken;
						}
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		guestsCrudBloc.add(
			GuestsCrudLihatEvent(recordId: widget.recordId));
		}
	}

	Widget buildFieldEmail(){
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldEmailController,
			decoration: const InputDecoration(
				labelText: "email",
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

	Widget buildFieldName(){
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldNameController,
			decoration: const InputDecoration(
				labelText: "name",
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

	Widget buildFieldPhone(){
		return TextFormField(
			controller: fieldPhoneController,
			decoration: const InputDecoration(
				labelText: "phone",
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

	Widget buildFieldSessionToken(){
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldSessionTokenController,
			decoration: const InputDecoration(
				labelText: "sessionToken",
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
			GuestsCrudModel record = GuestsCrudModel(
				email: fieldEmailController.text,
				guestsId: '',
				name: fieldNameController.text,
				phone: fieldPhoneController.text,
				sessionToken: fieldSessionTokenController.text,
			);
			if (widget.viewMode == "tambah") {
				guestsCrudBloc.add(GuestsCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.guestsId = guestsCrudBloc.state.record!.guestsId;
				guestsCrudBloc.add(GuestsCrudUbahEvent(record: record));
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
