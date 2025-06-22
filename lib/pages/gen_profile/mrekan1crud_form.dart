import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekan1crud_bloc.dart';
import 'package:eassist_tools_app/models/combobox/combombentukcst_model.dart';
import 'package:eassist_tools_app/models/combobox/combombidang_model.dart';
import 'package:eassist_tools_app/models/combobox/combomjnsclient_model.dart';
import 'package:eassist_tools_app/models/combobox/combomjnskel_model.dart';
import 'package:eassist_tools_app/models/combobox/combompekerjaan_model.dart';
import 'package:eassist_tools_app/models/combobox/combomtitle_model.dart';
import 'package:dropdown_search/dropdown_search.dart';


class MRekan1CrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const MRekan1CrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	MRekan1CrudFormPageFormState createState() => MRekan1CrudFormPageFormState();
}

class MRekan1CrudFormPageFormState extends State<MRekan1CrudFormPage> {
	late MRekan1CrudBloc mRekan1CrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	ComboMBentukCstModel? fieldComboMBentukCst;
	final comboMBentukCstKey = GlobalKey<DropdownSearchState<ComboMBentukCstModel>>();
	ComboMBidangModel? fieldComboMBidang;
	final comboMBidangKey = GlobalKey<DropdownSearchState<ComboMBidangModel>>();
	ComboMJnsclientModel? fieldComboMJnsclient;
	final comboMJnsclientKey = GlobalKey<DropdownSearchState<ComboMJnsclientModel>>();
	ComboMJnskelModel? fieldComboMJnskel;
	final comboMJnskelKey = GlobalKey<DropdownSearchState<ComboMJnskelModel>>();
	ComboMPekerjaanModel? fieldComboMPekerjaan;
	final comboMPekerjaanKey = GlobalKey<DropdownSearchState<ComboMPekerjaanModel>>();
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
		mRekan1CrudBloc = BlocProvider.of<MRekan1CrudBloc>(context);
		return BlocConsumer<MRekan1CrudBloc, MRekan1CrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} Informasi Umum Company",
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
																//onSaveForm();
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
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		  //mRekan1CrudBloc.add(MRekan1CrudLihatEvent(recordId: widget.recordId));
		}
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
