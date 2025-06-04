import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/profile/rekanbank_bloc.dart';
import 'package:eassist_tools_app/models/profile/rekanbank_model.dart';
import 'package:eassist_tools_app/models/combobox/combombank_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombank_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';


class RekanBankFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const RekanBankFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	RekanBankFormPageFormState createState() => RekanBankFormPageFormState();
}

class RekanBankFormPageFormState extends State<RekanBankFormPage> {
	late RekanBankBloc rekanBankBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	ComboMBankModel? fieldComboMBank;
	final comboMBankKey = GlobalKey<DropdownSearchState<ComboMBankModel>>();
	var fieldMrekan1IdController = TextEditingController();
	var fieldRekNamaController = TextEditingController();
	var fieldRekNoController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		rekanBankBloc = BlocProvider.of<RekanBankBloc>(context);
		return BlocConsumer<RekanBankBloc, RekanBankState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Informasi Bank",
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
										buildFieldMbankId(),
										buildFieldMrekan1Id(),
										buildFieldRekNama(),
										buildFieldRekNo(),
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
							fieldMrekan1IdController.text = state.record!.mrekan1Id;
							fieldRekNamaController.text = state.record!.rekNama;
							fieldRekNoController.text = state.record!.rekNo;
						}
						fieldComboMBank = state.comboMBank;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		rekanBankBloc.add(
			RekanBankLihatEvent(recordId: widget.recordId));
		}
	}

	Widget buildFieldMbankId(){
		return buildFieldComboMBank(
			comboKey: comboMBankKey,
			labelText: 'mbankId',
			initItem: fieldComboMBank,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboMBank tidak boleh kosong.");
					rekanBankBloc.add(ComboMBankChangedEvent(comboMBank: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMBank = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboMBank tidak boleh kosong.");
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

	Widget buildFieldRekNama(){
		return TextFormField(
			keyboardType: TextInputType.multiline,
			minLines: 1,
			maxLines: 3,
			controller: fieldRekNamaController,
			decoration: const InputDecoration(
				labelText: "rekNama",
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

	Widget buildFieldRekNo(){
		return TextFormField(
			controller: fieldRekNoController,
			decoration: const InputDecoration(
				labelText: "rekNo",
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
			RekanBankModel record = RekanBankModel(
				mbankId: fieldComboMBank?.mbankId,
				mrekan1Id: fieldMrekan1IdController.text,
				mrekanbankId: '',
				rekNama: fieldRekNamaController.text,
				rekNo: fieldRekNoController.text,
			);
			if (widget.viewMode == "tambah") {
				rekanBankBloc.add(RekanBankTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.mrekanbankId = rekanBankBloc.state.record!.mrekanbankId;
				rekanBankBloc.add(RekanBankUbahEvent(record: record));
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
