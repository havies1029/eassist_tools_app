import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralidvcrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekangeneralidvcrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combompekerjaan_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combompekerjaan_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';


class MRekanGeneralIdvCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const MRekanGeneralIdvCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	MRekanGeneralIdvCrudFormPageFormState createState() => MRekanGeneralIdvCrudFormPageFormState();
}

class MRekanGeneralIdvCrudFormPageFormState extends State<MRekanGeneralIdvCrudFormPage> {
	late MRekanGeneralIdvCrudBloc mRekanGeneralIdvCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldMjnsclientIdController = TextEditingController();
	var fieldMjnskelIdController = TextEditingController();
	ComboMPekerjaanModel? fieldComboMPekerjaan;
	final comboMPekerjaanKey = GlobalKey<DropdownSearchState<ComboMPekerjaanModel>>();
	var fieldRekanNamaController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		mRekanGeneralIdvCrudBloc = BlocProvider.of<MRekanGeneralIdvCrudBloc>(context);
		return BlocConsumer<MRekanGeneralIdvCrudBloc, MRekanGeneralIdvCrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Informasi General",
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
										buildFieldMjnsclientId(),
										buildFieldMjnskelId(),
										buildFieldMpekerjaanId(),
										buildFieldRekanNama(),
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
							fieldMjnsclientIdController.text = state.record!.mjnsclientId;
							fieldMjnskelIdController.text = state.record!.mjnskelId;
							fieldRekanNamaController.text = state.record!.rekanNama;
						}
						fieldComboMPekerjaan = state.comboMPekerjaan;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		mRekanGeneralIdvCrudBloc.add(
			MRekanGeneralIdvCrudLihatEvent(recordId: widget.recordId));
		}
	}

	Widget buildFieldMjnsclientId(){
		return TextFormField(
			controller: fieldMjnsclientIdController,
			decoration: const InputDecoration(
				labelText: "mjnsclientId",
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

	Widget buildFieldMjnskelId(){
		return TextFormField(
			controller: fieldMjnskelIdController,
			decoration: const InputDecoration(
				labelText: "mjnskelId",
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

	Widget buildFieldMpekerjaanId(){
		return buildFieldComboMPekerjaan(
			comboKey: comboMPekerjaanKey,
			labelText: 'mpekerjaanId',
			initItem: fieldComboMPekerjaan,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboMPekerjaan tidak boleh kosong.");
					mRekanGeneralIdvCrudBloc.add(ComboMPekerjaanChangedEvent(comboMPekerjaan: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMPekerjaan = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboMPekerjaan tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldRekanNama(){
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldRekanNamaController,
			decoration: const InputDecoration(
				labelText: "rekanNama",
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
			MRekanGeneralIdvCrudModel record = MRekanGeneralIdvCrudModel(
				mjnsclientId: fieldMjnsclientIdController.text,
				mjnskelId: fieldMjnskelIdController.text,
				mpekerjaanId: fieldComboMPekerjaan?.mpekerjaanId,
				mrekan1Id: '',
				rekanNama: fieldRekanNamaController.text,
			);
			if (widget.viewMode == "tambah") {
				mRekanGeneralIdvCrudBloc.add(MRekanGeneralIdvCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mrekan1Id = mRekanGeneralIdvCrudBloc.state.record!.mrekan1Id;
				mRekanGeneralIdvCrudBloc.add(MRekanGeneralIdvCrudUbahEvent(record: record));
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
