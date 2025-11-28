import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/gen_calmv/calmv1crud_bloc.dart';
import 'package:eassist_tools_app/models/gen_calmv/calmv1crud_model.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combormatauang_widget.dart';
import 'package:eassist_tools_app/models/combobox/combommvgrupojk_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combommvgrupojk_widget.dart';
import 'package:eassist_tools_app/models/combobox/combommvjnscover_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combommvjnscover_widget.dart';
import 'package:eassist_tools_app/models/combobox/combommvpakai_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combommvpakai_widget.dart';
import 'package:eassist_tools_app/models/combobox/combomwilayah_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomwilayah_widget.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:dropdown_search/dropdown_search.dart';


class Calmv1CrudFormPage extends StatefulWidget {
	final String viewMode;
	final String recordId;

	const Calmv1CrudFormPage({super.key, required this.viewMode, required this.recordId});

	@override
	Calmv1CrudFormPageFormState createState() => Calmv1CrudFormPageFormState();
}

class Calmv1CrudFormPageFormState extends State<Calmv1CrudFormPage> {
	late Calmv1CrudBloc calmv1CrudBloc;
	final _formKey = GlobalKey<FormState>();
	final List<String> errors = [];
	var fieldCoverBulanController = TextEditingController();
	ComboRMatauangModel? fieldComboRMatauang;
	final comboRMatauangKey = GlobalKey<DropdownSearchState<ComboRMatauangModel>>();
	var fieldHargaController = TextEditingController();
	ComboMMvgrupOjkModel? fieldComboMMvgrupOjk;
	final comboMMvgrupOjkKey = GlobalKey<DropdownSearchState<ComboMMvgrupOjkModel>>();
	ComboMMvjnscoverModel? fieldComboMMvjnscover;
	final comboMMvjnscoverKey = GlobalKey<DropdownSearchState<ComboMMvjnscoverModel>>();
	ComboMMvpakaiModel? fieldComboMMvpakai;
	final comboMMvpakaiKey = GlobalKey<DropdownSearchState<ComboMMvpakaiModel>>();
	ComboMWilayahModel? fieldComboMWilayah;
	final comboMWilayahKey = GlobalKey<DropdownSearchState<ComboMWilayahModel>>();
	var fieldThnBuatController = TextEditingController();

	@override
	void initState() {
		super.initState();
		Future.delayed(const Duration(milliseconds: 500), () {
			loadData();
		});
	}

	@override
	Widget build(BuildContext context) {
		calmv1CrudBloc = BlocProvider.of<Calmv1CrudBloc>(context);
		return BlocConsumer<Calmv1CrudBloc, Calmv1CrudState>(
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
											"${widget.viewMode == "tambah" ? "Tambah" : "Ubah"} CalMV #1",
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
										buildFieldCoverBulan(),
										buildFieldCurrId(),
										buildFieldHarga(),
										buildFieldMmvgrupojkId(),
										buildFieldMmvjnscoverId(),
										buildFieldMmvpakaiId(),
										buildFieldMwilayahId(),
										buildFieldThnBuat(),
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
							fieldCoverBulanController.text = state.record!.coverBulan.toString();
							fieldHargaController.text = NumberFormat("#,###").format(state.record!.harga);
							fieldThnBuatController.text = state.record!.thnBuat.toString();
						}
						fieldComboRMatauang = state.comboRMatauang;
						fieldComboMMvgrupOjk = state.comboMMvgrupOjk;
						fieldComboMMvjnscover = state.comboMMvjnscover;
						fieldComboMMvpakai = state.comboMMvpakai;
						fieldComboMWilayah = state.comboMWilayah;
					}
				},
			);
		}
	void loadData() {
		if (widget.viewMode == "ubah") {
		calmv1CrudBloc.add(
			Calmv1CrudLihatEvent(recordId: widget.recordId));
		}
	}

	Widget buildFieldCoverBulan(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldCoverBulanController,
			decoration: const InputDecoration(
				labelText: "coverBulan",
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

	Widget buildFieldCurrId(){
		return buildFieldComboRMatauang(
			comboKey: comboRMatauangKey,
			labelText: 'currId',
			initItem: fieldComboRMatauang,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboRMatauang tidak boleh kosong.");
					calmv1CrudBloc.add(ComboRMatauangChangedEvent(comboRMatauang: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboRMatauang = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboRMatauang tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldHarga(){
		return TextFormField(
			keyboardType: TextInputType.number,
			inputFormatters: [ThousandsSeparatorInputFormatter()],
			controller: fieldHargaController,
			decoration: const InputDecoration(
				labelText: "harga",
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

	Widget buildFieldMmvgrupojkId(){
		return buildFieldComboMMvgrupOjk(
			comboKey: comboMMvgrupOjkKey,
			labelText: 'mmvgrupojkId',
			initItem: fieldComboMMvgrupOjk,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboMMvgrupOjk tidak boleh kosong.");
					calmv1CrudBloc.add(ComboMMvgrupOjkChangedEvent(comboMMvgrupOjk: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMMvgrupOjk = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboMMvgrupOjk tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldMmvjnscoverId(){
		return buildFieldComboMMvjnscover(
			comboKey: comboMMvjnscoverKey,
			labelText: 'mmvjnscoverId',
			initItem: fieldComboMMvjnscover,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboMMvjnscover tidak boleh kosong.");
					calmv1CrudBloc.add(ComboMMvjnscoverChangedEvent(comboMMvjnscover: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMMvjnscover = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboMMvjnscover tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldMmvpakaiId(){
		return buildFieldComboMMvpakai(
			comboKey: comboMMvpakaiKey,
			labelText: 'mmvpakaiId',
			initItem: fieldComboMMvpakai,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboMMvpakai tidak boleh kosong.");
					calmv1CrudBloc.add(ComboMMvpakaiChangedEvent(comboMMvpakai: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMMvpakai = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboMMvpakai tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldMwilayahId(){
		return buildFieldComboMWilayah(
			comboKey: comboMWilayahKey,
			labelText: 'mwilayahId',
			initItem: fieldComboMWilayah,
			onChangedCallback: (value) {
				if (value != null) {
					removeError(
						error: "Field ComboMWilayah tidak boleh kosong.");
					calmv1CrudBloc.add(ComboMWilayahChangedEvent(comboMWilayah: value));
				}
			},
			onSaveCallback: (value) {
				if (value != null) {
					fieldComboMWilayah = value;
				}
			},
			validatorCallback: (value) {
				if (value == null) {
					addError(
						error: "Field ComboMWilayah tidak boleh kosong.");
				}
			},
		);
	}

	Widget buildFieldThnBuat(){
		return TextFormField(
			keyboardType: TextInputType.number,
			controller: fieldThnBuatController,
			decoration: const InputDecoration(
				labelText: "thnBuat",
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

	void _dismissDialog() {
		Navigator.pop(context);
	}

	void onSaveForm() {
		if (_formKey.currentState!.validate()) {
			_formKey.currentState!.save();
			Calmv1CrudModel record = Calmv1CrudModel(
				calmv1Id: '',
				coverBulan: int.parse(fieldCoverBulanController.text),
				currId: fieldComboRMatauang?.rmatauangKode,
				harga: double.parse(fieldHargaController.text.replaceAll(',', '')),
				mmvgrupojkId: fieldComboMMvgrupOjk?.mmvgrupojkId,
				mmvjnscoverId: fieldComboMMvjnscover?.mmvjnscoverId,
				mmvpakaiId: fieldComboMMvpakai?.mmvpakaiId,
				mwilayahId: fieldComboMWilayah?.mwilayahId,
				thnBuat: int.parse(fieldThnBuatController.text),
			);
			if (widget.viewMode == "tambah") {
				calmv1CrudBloc.add(Calmv1CrudTambahEvent(record: record));
			} else if (widget.viewMode == "ubah") {
				record.calmv1Id = calmv1CrudBloc.state.record!.calmv1Id;
				calmv1CrudBloc.add(Calmv1CrudUbahEvent(record: record));
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
