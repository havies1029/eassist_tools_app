import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/profile/rekangeneral_bloc.dart';
import 'package:eassist_tools_app/models/profile/rekangeneral_model.dart';
import 'package:eassist_tools_app/models/combobox/combombentukcst_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombentukcst_widget.dart';
import 'package:eassist_tools_app/models/combobox/combombidang_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombidang_widget.dart';
import 'package:eassist_tools_app/models/combobox/combomtipecst_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomtipecst_widget.dart';
import 'package:eassist_tools_app/models/combobox/combomtitle_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomtitle_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';


class RekanGeneralFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const RekanGeneralFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	RekanGeneralFormPageFormState createState() => RekanGeneralFormPageFormState();
}

class RekanGeneralFormPageFormState extends State<RekanGeneralFormPage> {
	late RekanGeneralBloc rekanGeneralBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	ComboMBentukCstModel? fieldComboMBentukCst;
	final comboMBentukCstKey = GlobalKey<DropdownSearchState<ComboMBentukCstModel>>();
	ComboMBidangModel? fieldComboMBidang;
	final comboMBidangKey = GlobalKey<DropdownSearchState<ComboMBidangModel>>();
	ComboMTipeCstModel? fieldComboMTipeCst;
	final comboMTipeCstKey = GlobalKey<DropdownSearchState<ComboMTipeCstModel>>();
	ComboMTitleModel? fieldComboMTitle;
	final comboMTitleKey = GlobalKey<DropdownSearchState<ComboMTitleModel>>();
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
		rekanGeneralBloc = BlocProvider.of<RekanGeneralBloc>(context);
		return BlocConsumer<RekanGeneralBloc, RekanGeneralState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} General Information",
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
										buildFieldMbentukcstId(),
										buildFieldMbidangId(),
										buildFieldMtipecstId(),
										buildFieldMtitleId(),
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
							fieldRekanNamaController.text = state.record!.rekanNama;
						}
						fieldComboMBentukCst = state.comboMBentukCst;
						fieldComboMBidang = state.comboMBidang;
						fieldComboMTipeCst = state.comboMTipeCst;
						fieldComboMTitle = state.comboMTitle;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		rekanGeneralBloc.add(
			RekanGeneralLihatEvent(recordId: widget.recordId));
		}
	}

	Widget buildFieldMbentukcstId(){
		return buildFieldComboMBentukCst(
			comboKey: comboMBentukCstKey,
			labelText: 'mbentukcstId',
			initItem: fieldComboMBentukCst,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboMBentukCst tidak boleh kosong.");
					rekanGeneralBloc.add(ComboMBentukCstChangedEvent(comboMBentukCst: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMBentukCst = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboMBentukCst tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldMbidangId(){
		return buildFieldComboMBidang(
			comboKey: comboMBidangKey,
			labelText: 'mbidangId',
			initItem: fieldComboMBidang,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboMBidang tidak boleh kosong.");
					rekanGeneralBloc.add(ComboMBidangChangedEvent(comboMBidang: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMBidang = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboMBidang tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldMtipecstId(){
		return buildFieldComboMTipeCst(
			comboKey: comboMTipeCstKey,
			labelText: 'mtipecstId',
			initItem: fieldComboMTipeCst,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboMTipeCst tidak boleh kosong.");
					rekanGeneralBloc.add(ComboMTipeCstChangedEvent(comboMTipeCst: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMTipeCst = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboMTipeCst tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldMtitleId(){
		return buildFieldComboMTitle(
			comboKey: comboMTitleKey,
			labelText: 'mtitleId',
			initItem: fieldComboMTitle,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboMTitle tidak boleh kosong.");
					rekanGeneralBloc.add(ComboMTitleChangedEvent(comboMTitle: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMTitle = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboMTitle tidak boleh kosong.");
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
			RekanGeneralModel record = RekanGeneralModel(
				mbentukcstId: fieldComboMBentukCst?.mbentukcstId,
				mbidangId: fieldComboMBidang?.mbidangId,
				mrekan1Id: '',
				mtipecstId: fieldComboMTipeCst?.mtipecustId,
				mtitleId: fieldComboMTitle?.mtitleId,
				rekanNama: fieldRekanNamaController.text,
			);
			if (widget.viewMode == "tambah") {
				rekanGeneralBloc.add(RekanGeneralTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mrekan1Id = rekanGeneralBloc.state.record!.mrekan1Id;
				rekanGeneralBloc.add(RekanGeneralUbahEvent(record: record));
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
