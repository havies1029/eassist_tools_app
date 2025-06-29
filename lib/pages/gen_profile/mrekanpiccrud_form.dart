import 'package:eassist_tools_app/widgets/checkbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_validator/string_validator.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpiccrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekanpiccrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combomjabatan_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomjabatan_widget.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:dropdown_search/dropdown_search.dart';


class MRekanPicCrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const MRekanPicCrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	MRekanPicCrudFormPageFormState createState() => MRekanPicCrudFormPageFormState();
}

class MRekanPicCrudFormPageFormState extends State<MRekanPicCrudFormPage> {
	late MRekanPicCrudBloc mRekanPicCrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldIsDefaultController = TextEditingController();
	ComboMJabatanModel? fieldComboMJabatan;
	final comboMJabatanKey = GlobalKey<DropdownSearchState<ComboMJabatanModel>>();
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
		mRekanPicCrudBloc = BlocProvider.of<MRekanPicCrudBloc>(context);
		return BlocConsumer<MRekanPicCrudBloc, MRekanPicCrudState>(
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
										buildFieldPicNama(),     
										buildFieldMjabatanId(),                  
										buildFieldPicHp(),
										buildFieldPicEmail(),
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
							fieldIsDefaultController.text = (state.record?.isDefault??false).toString();
							fieldPicEmailController.text = state.record?.picEmail??"";
							fieldPicHpController.text = state.record?.picHp??"";
							fieldPicNamaController.text = state.record?.picNama??"";
						}
						fieldComboMJabatan = state.comboMJabatan;
					}
				},
		buildWhen: (previous, current) {
		  if (previous.isFieldIsDefaultChanged != current.isFieldIsDefaultChanged){
        fieldIsDefaultController.text = current.record!.isDefault.toString();
        return true;
		  }
		  return current.isLoaded;
		},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		mRekanPicCrudBloc.add(
			MRekanPicCrudLihatEvent(recordId: widget.recordId));
		}
	}

  Widget buildFieldIsDefault(){
    return CheckboxWidget(
        leftLabel: "",
        rightLabel: "Default",
        initialValue: toBoolean(fieldIsDefaultController.text),
        callback: (value) {
          mRekanPicCrudBloc
            .add(CheckboxIsDefaultChangedEvent(isChecked: value));
                  
        });
  }

	Widget buildFieldMjabatanId(){
		return buildFieldComboMJabatan(
			comboKey: comboMJabatanKey,
			labelText: 'mjabatanId',
			initItem: fieldComboMJabatan,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboMJabatan tidak boleh kosong.");
					mRekanPicCrudBloc.add(ComboMJabatanChangedEvent(comboMJabatan: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMJabatan = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboMJabatan tidak boleh kosong.");
				}
			},
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
			MRekanPicCrudModel record = MRekanPicCrudModel(
				isDefault: toBoolean(fieldIsDefaultController.text),
				mjabatanId: fieldComboMJabatan?.mjabatanId,
				mrekanpicId: '',
				picEmail: fieldPicEmailController.text,
				picHp: fieldPicHpController.text,
				picNama: fieldPicNamaController.text,
			);
			if (widget.viewMode == "tambah") {
				mRekanPicCrudBloc.add(MRekanPicCrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mrekanpicId = mRekanPicCrudBloc.state.record!.mrekanpicId;
				mRekanPicCrudBloc.add(MRekanPicCrudUbahEvent(record: record));
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
