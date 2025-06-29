import 'package:eassist_tools_app/blocs/gen_profile/mrekan1crud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralcmpcrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekangeneralcmpcrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combombentukcst_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombentukcst_widget.dart';
import 'package:eassist_tools_app/models/combobox/combombidang_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombidang_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';

class MRekanGeneralCmpCrudFormPage extends StatefulWidget {
  const MRekanGeneralCmpCrudFormPage({super.key});

  @override
  MRekanGeneralCmpCrudFormPageFormState createState() =>
      MRekanGeneralCmpCrudFormPageFormState();
}

class MRekanGeneralCmpCrudFormPageFormState
    extends State<MRekanGeneralCmpCrudFormPage> {
  late MRekanGeneralCmpCrudBloc mRekanGeneralCmpCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  ComboMBentukCstModel? fieldComboMBentukCst;
  final comboMBentukCstKey =
      GlobalKey<DropdownSearchState<ComboMBentukCstModel>>();
  ComboMBidangModel? fieldComboMBidang;
  final comboMBidangKey = GlobalKey<DropdownSearchState<ComboMBidangModel>>();
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
    mRekanGeneralCmpCrudBloc =
        BlocProvider.of<MRekanGeneralCmpCrudBloc>(context);
    return BlocConsumer<MRekanGeneralCmpCrudBloc, MRekanGeneralCmpCrudState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Informasi Umum Company",
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
                    buildFieldMbentukcstId(),
                    buildFieldMbidangId(),
                    const SizedBox(height: 25),
                    FormError(
                      errors: errors,
                      key: null,
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
                )),
          ),
        );
      },
      listener: (context, state) {
        if (state.isLoaded) {
          if (state.record != null) {
            fieldRekanNamaController.text = state.record?.rekanNama ?? "";
          }
          fieldComboMBentukCst = state.comboMBentukCst;
          fieldComboMBidang = state.comboMBidang;
        } 
        if (state.isSaved && !state.hasFailure) {
          context.read<MRekan1CrudBloc>().add(
            MRekan1CrudLihatEvent(),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Data berhasil disimpan."),
            ),
          );
        }
      },
    );
  }

  void loadData() {
    mRekanGeneralCmpCrudBloc.add(MRekanGeneralCmpCrudLihatEvent());
  }

  Widget buildFieldMbentukcstId() {
    return buildFieldComboMBentukCst(
      comboKey: comboMBentukCstKey,
      labelText: 'mbentukcstId',
      initItem: fieldComboMBentukCst,
      onChangedCallback: (value) {
        if (value != null) {
          removeError(error: "Field ComboMBentukCst tidak boleh kosong.");
          mRekanGeneralCmpCrudBloc
              .add(ComboMBentukCstChangedEvent(comboMBentukCst: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboMBentukCst = value;
        }
      },
      validatorCallback: (value) {
        if (value == null) {
          addError(error: "Field ComboMBentukCst tidak boleh kosong.");
        }
      },
    );
  }

  Widget buildFieldMbidangId() {
    return buildFieldComboMBidang(
      comboKey: comboMBidangKey,
      labelText: 'mbidangId',
      initItem: fieldComboMBidang,
      onChangedCallback: (value) {
        if (value != null) {
          removeError(error: "Field ComboMBidang tidak boleh kosong.");
          mRekanGeneralCmpCrudBloc
              .add(ComboMBidangChangedEvent(comboMBidang: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboMBidang = value;
        }
      },
      validatorCallback: (value) {
        if (value == null) {
          addError(error: "Field ComboMBidang tidak boleh kosong.");
        }
      },
    );
  }

  Widget buildFieldRekanNama() {
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
        fieldRekanNamaController.text = value;
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

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      MRekanGeneralCmpCrudModel record = MRekanGeneralCmpCrudModel(
        mbentukcstId: fieldComboMBentukCst?.mbentukcstId,
        mbidangId: fieldComboMBidang?.mbidangId,
        rekanNama: fieldRekanNamaController.text,
      );

      mRekanGeneralCmpCrudBloc
          .add(MRekanGeneralCmpCrudUbahEvent(record: record));
    }
  }

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }
}
