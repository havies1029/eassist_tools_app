import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpajakcrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekanpajakcrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combomkota_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomkota_widget.dart';
import 'package:eassist_tools_app/models/combobox/combompropinsi_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combompropinsi_widget.dart';
import 'package:eassist_tools_app/models/combobox/comborkodepos_model.dart';
import 'package:eassist_tools_app/widgets/combobox/comborkodepos_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';


class MRekanPajakCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const MRekanPajakCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	MRekanPajakCrudFormPageFormState createState() => MRekanPajakCrudFormPageFormState();
}

class MRekanPajakCrudFormPageFormState extends State<MRekanPajakCrudFormPage> {
	late MRekanPajakCrudBloc mRekanPajakCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldAlamat1Controller = TextEditingController();
	ComboMKotaModel? fieldComboMKota;
	final comboMKotaKey = GlobalKey<DropdownSearchState<ComboMKotaModel>>();
	ComboMPropinsiModel? fieldComboMPropinsi;
	final comboMPropinsiKey = GlobalKey<DropdownSearchState<ComboMPropinsiModel>>();
	var fieldNpwpNoController = TextEditingController();
	ComboRKodeposModel? fieldComboRKodepos;
	final comboRKodeposKey = GlobalKey<DropdownSearchState<ComboRKodeposModel>>();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		mRekanPajakCrudBloc = BlocProvider.of<MRekanPajakCrudBloc>(context);
		return BlocConsumer<MRekanPajakCrudBloc, MRekanPajakCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Informasi Pajak",
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
										buildFieldMkotaId(),
										buildFieldMpropinsiId(),
										buildFieldMrekan1Id(),
										buildFieldNpwpNo(),
										buildFieldRkodeposId(),
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
							fieldNpwpNoController.text = state.record!.npwpNo;
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
		mRekanPajakCrudBloc.add(
			MRekanPajakCrudLihatEvent(recordId: widget.recordId));
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

	Widget buildFieldMkotaId(){
		return buildFieldComboMKota(
			comboKey: comboMKotaKey,
			labelText: 'mkotaId',
			initItem: fieldComboMKota,
      propinsiId: "",
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboMKota tidak boleh kosong.");
					mRekanPajakCrudBloc.add(ComboMKotaChangedEvent(comboMKota: value));
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
					mRekanPajakCrudBloc.add(ComboMPropinsiChangedEvent(comboMPropinsi: value));
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
		);
	}

	Widget buildFieldNpwpNo(){
		return TextFormField(
			controller: fieldNpwpNoController,
			decoration: const InputDecoration(
				labelText: "npwpNo",
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
      kotaId: "",
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboRKodepos tidak boleh kosong.");
					mRekanPajakCrudBloc.add(ComboRKodeposChangedEvent(comboRKodepos: value));
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

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			MRekanPajakCrudModel record = MRekanPajakCrudModel(
				alamat1: fieldAlamat1Controller.text,
				mkotaId: fieldComboMKota?.mkotaId,
				mpropinsiId: fieldComboMPropinsi?.mpropinsiId,
				mrekanpajakId: '',
				npwpNo: fieldNpwpNoController.text,
				rkodeposId: fieldComboRKodepos?.rkodeposId,
			);
			if (widget.viewMode == "tambah") {
				mRekanPajakCrudBloc.add(MRekanPajakCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mrekanpajakId = mRekanPajakCrudBloc.state.record!.mrekanpajakId;
				mRekanPajakCrudBloc.add(MRekanPajakCrudUbahEvent(record: record));
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
