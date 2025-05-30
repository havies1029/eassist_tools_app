import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/profile/rekancontact_bloc.dart';
import 'package:eassist_tools_app/models/profile/rekancontact_model.dart';
import 'package:eassist_tools_app/models/combobox/combomkota_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomkota_widget.dart';
import 'package:eassist_tools_app/models/combobox/combompropinsi_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combompropinsi_widget.dart';
import 'package:eassist_tools_app/models/combobox/comborkodepos_model.dart';
import 'package:eassist_tools_app/widgets/combobox/comborkodepos_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';


class RekanContactFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const RekanContactFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	RekanContactFormPageFormState createState() => RekanContactFormPageFormState();
}

class RekanContactFormPageFormState extends State<RekanContactFormPage> {
	late RekanContactBloc rekanContactBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldAlamat1Controller = TextEditingController();
	var fieldEmailController = TextEditingController();
	ComboMKotaModel? fieldComboMKota;
	final comboMKotaKey = GlobalKey<DropdownSearchState<ComboMKotaModel>>();
	ComboMPropinsiModel? fieldComboMPropinsi;
	final comboMPropinsiKey = GlobalKey<DropdownSearchState<ComboMPropinsiModel>>();
	var fieldMrekan1IdController = TextEditingController();
	ComboRKodeposModel? fieldComboRKodepos;
	final comboRKodeposKey = GlobalKey<DropdownSearchState<ComboRKodeposModel>>();
	var fieldTelpController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		rekanContactBloc = BlocProvider.of<RekanContactBloc>(context);
		return BlocConsumer<RekanContactBloc, RekanContactState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Kontak Perusahaan",
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
										buildFieldAlamat1(),
										buildFieldEmail(),
										buildFieldMkotaId(),
										buildFieldMpropinsiId(),
										buildFieldMrekan1Id(),
										buildFieldRkodeposId(),
										buildFieldTelp(),
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
							fieldAlamat1Controller.text = state.record!.alamat1;
							fieldEmailController.text = state.record!.email;
							fieldMrekan1IdController.text = state.record!.mrekan1Id;
							fieldTelpController.text = state.record!.telp;
						}
						fieldComboMKota = state.comboMKota;
						fieldComboMPropinsi = state.comboMPropinsi;
						fieldComboRKodepos = state.comboRKodepos;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		rekanContactBloc.add(
			RekanContactLihatEvent(recordId: widget.recordId));
		}
	}

	Widget buildFieldAlamat1(){
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldAlamat1Controller,
			decoration: const InputDecoration(
				labelText: "alamat1",
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

	Widget buildFieldMkotaId(){
		return buildFieldComboMKota(
			comboKey: comboMKotaKey,
			labelText: 'mkotaId',
			initItem: fieldComboMKota,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboMKota tidak boleh kosong.");
					rekanContactBloc.add(ComboMKotaChangedEvent(comboMKota: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMKota = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboMKota tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldMpropinsiId(){
		return buildFieldComboMPropinsi(
			comboKey: comboMPropinsiKey,
			labelText: 'mpropinsiId',
			initItem: fieldComboMPropinsi,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboMPropinsi tidak boleh kosong.");
					rekanContactBloc.add(ComboMPropinsiChangedEvent(comboMPropinsi: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMPropinsi = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboMPropinsi tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldMrekan1Id(){
		return TextFormField(
			controller: fieldMrekan1IdController,
			decoration: const InputDecoration(
				labelText: "mrekan1Id",
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

	Widget buildFieldRkodeposId(){
		return buildFieldComboRKodepos(
			comboKey: comboRKodeposKey,
			labelText: 'rkodeposId',
			initItem: fieldComboRKodepos,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboRKodepos tidak boleh kosong.");
					rekanContactBloc.add(ComboRKodeposChangedEvent(comboRKodepos: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboRKodepos = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboRKodepos tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldTelp(){
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldTelpController,
			decoration: const InputDecoration(
				labelText: "telp",
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
			RekanContactModel record = RekanContactModel(
				alamat1: fieldAlamat1Controller.text,
				email: fieldEmailController.text,
				mkotaId: fieldComboMKota?.mkotaId,
				mpropinsiId: fieldComboMPropinsi?.mpropinsiId,
				mrekan1Id: fieldMrekan1IdController.text,
				mrekancontact1Id: '',
				rkodeposId: fieldComboRKodepos?.rkodeposId,
				telp: fieldTelpController.text,
			);
			if (widget.viewMode == "tambah") {
				rekanContactBloc.add(RekanContactTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mrekancontact1Id = rekanContactBloc.state.record!.mrekancontact1Id;
				rekanContactBloc.add(RekanContactUbahEvent(record: record));
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
