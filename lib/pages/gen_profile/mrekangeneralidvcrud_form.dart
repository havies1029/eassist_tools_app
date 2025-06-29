import 'package:eassist_tools_app/blocs/gen_profile/mrekan1crud_bloc.dart';
import 'package:eassist_tools_app/models/combobox/combomjnskel_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomjnskel_widget.dart';
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
  const MRekanGeneralIdvCrudFormPage({super.key});

  @override
  MRekanGeneralIdvCrudFormPageFormState createState() =>
      MRekanGeneralIdvCrudFormPageFormState();
}

class MRekanGeneralIdvCrudFormPageFormState
    extends State<MRekanGeneralIdvCrudFormPage> {
  late MRekanGeneralIdvCrudBloc mRekanGeneralIdvCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  ComboMPekerjaanModel? fieldComboMPekerjaan;
  ComboMJnskelModel? fieldComboMJnskel;
  final comboMPekerjaanKey =
      GlobalKey<DropdownSearchState<ComboMPekerjaanModel>>();
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
    mRekanGeneralIdvCrudBloc =
        BlocProvider.of<MRekanGeneralIdvCrudBloc>(context);
    return BlocConsumer<MRekanGeneralIdvCrudBloc, MRekanGeneralIdvCrudState>(
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
                      "General Individu",
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
                    buildFieldMJnsKel(),
                    buildFieldMpekerjaanId(),                      
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
            fieldRekanNamaController.text = state.record!.rekanNama;
          }
          fieldComboMPekerjaan = state.comboMPekerjaan;
          fieldComboMJnskel = state.comboMJnskel;
        }
        if (state.isSaved && !state.hasFailure){
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
    mRekanGeneralIdvCrudBloc.add(MRekanGeneralIdvCrudLihatEvent());
  }

  Widget buildFieldMpekerjaanId() {
    return buildFieldComboMPekerjaan(
      comboKey: comboMPekerjaanKey,
      labelText: 'mpekerjaanId',
      initItem: fieldComboMPekerjaan,
      onChangedCallback: (value) {
        if (value != null) {
          removeError(error: "Field ComboMPekerjaan tidak boleh kosong.");
          mRekanGeneralIdvCrudBloc
              .add(ComboMPekerjaanChangedEvent(comboMPekerjaan: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboMPekerjaan = value;
        }
      },
      validatorCallback: (value) {
        if (value == null) {
          addError(error: "Field ComboMPekerjaan tidak boleh kosong.");
        }
      },
    );
  }

  Widget buildFieldMJnsKel() {
    return buildFieldComboMJnskel(
      labelText: 'Jenis Kelamin',
      initItem: fieldComboMJnskel,
      onChangedCallback: (value) {
        if (value != null) {
          removeError(error: "Field fieldComboMJnskel tidak boleh kosong.");
          mRekanGeneralIdvCrudBloc
              .add(ComboMJnskelChangedEvent(comboMJnskel: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboMJnskel = value;
        }
      },
      validatorCallback: (value) {
        if (value == null) {
          addError(error: "Field fieldComboMJnskel tidak boleh kosong.");
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
      MRekanGeneralIdvCrudModel record = MRekanGeneralIdvCrudModel(
        mjnskelId: fieldComboMJnskel?.mjnskelId,
        mpekerjaanId: fieldComboMPekerjaan?.mpekerjaanId,
        mrekan1Id: '',
        rekanNama: fieldRekanNamaController.text,
      );
      record.mrekan1Id = mRekanGeneralIdvCrudBloc.state.record!.mrekan1Id;
      mRekanGeneralIdvCrudBloc
          .add(MRekanGeneralIdvCrudUbahEvent(record: record));
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
