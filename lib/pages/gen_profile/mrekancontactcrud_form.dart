import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekancontactcrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekancontactcrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combomkota_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomkota_widget.dart';
import 'package:eassist_tools_app/models/combobox/combompropinsi_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combompropinsi_widget.dart';
import 'package:eassist_tools_app/models/combobox/comborkodepos_model.dart';
import 'package:eassist_tools_app/widgets/combobox/comborkodepos_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';

class MRekanContactCrudFormPage extends StatefulWidget {
  const MRekanContactCrudFormPage({super.key});

  @override
  MRekanContactCrudFormPageFormState createState() =>
      MRekanContactCrudFormPageFormState();
}

class MRekanContactCrudFormPageFormState
    extends State<MRekanContactCrudFormPage> {
  late MRekanContactCrudBloc mRekanContactCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  var fieldAlamat1Controller = TextEditingController();
  var fieldEmailController = TextEditingController();
  ComboMKotaModel? fieldComboMKota;
  final comboMKotaKey = GlobalKey<DropdownSearchState<ComboMKotaModel>>();
  ComboMPropinsiModel? fieldComboMPropinsi;
  final comboMPropinsiKey =
      GlobalKey<DropdownSearchState<ComboMPropinsiModel>>();
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
    mRekanContactCrudBloc = BlocProvider.of<MRekanContactCrudBloc>(context);
    return BlocConsumer<MRekanContactCrudBloc, MRekanContactCrudState>(
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
                      "Informasi Contact",
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
                    buildFieldEmail(),
                    buildFieldTelp(),
                    buildFieldAlamat1(),
                    buildFieldMpropinsiId(),
                    buildFieldMkotaId(),
                    buildFieldRkodeposId(),
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
            fieldAlamat1Controller.text = state.record!.alamat1;
            fieldEmailController.text = state.record!.email;
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
    mRekanContactCrudBloc.add(MRekanContactCrudLihatEvent());
  }

  Widget buildFieldAlamat1() {
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

  Widget buildFieldEmail() {
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

  Widget buildFieldMkotaId() {
    return buildFieldComboMKota(
      comboKey: comboMKotaKey,
      labelText: 'Kota',
      initItem: fieldComboMKota,
      propinsiId: fieldComboMPropinsi?.mpropinsiId ?? "",
      onChangedCallback: (value) {
        if (value != null) {
          removeError(error: "Field ComboMKota tidak boleh kosong.");
          mRekanContactCrudBloc.add(ComboMKotaChangedEvent(comboMKota: value));
          comboRKodeposKey.currentState?.clear();
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboMKota = value;
        }
      },
      validatorCallback: (value) {
        if (value == null) {
          addError(error: "Field ComboMKota tidak boleh kosong.");
        }
      },
    );
  }

  Widget buildFieldMpropinsiId() {
    return buildFieldComboMPropinsi(
      comboKey: comboMPropinsiKey,
      labelText: 'Propinsi',
      initItem: fieldComboMPropinsi,
      onChangedCallback: (value) {
        if (value != null) {
          removeError(error: "Field ComboMPropinsi tidak boleh kosong.");
          mRekanContactCrudBloc
              .add(ComboMPropinsiChangedEvent(comboMPropinsi: value));
          comboMKotaKey.currentState?.clear();
          comboRKodeposKey.currentState?.clear();
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboMPropinsi = value;
        }
      },
      validatorCallback: (value) {
        if (value == null) {
          addError(error: "Field ComboMPropinsi tidak boleh kosong.");
        }
      },
    );
  }

  Widget buildFieldRkodeposId() {
    return buildFieldComboRKodepos(
      comboKey: comboRKodeposKey,
      labelText: 'Kodepos',
      initItem: fieldComboRKodepos,
      kotaId: fieldComboMKota?.mkotaId ?? "",
      onChangedCallback: (value) {
        if (value != null) {
          removeError(error: "Field ComboRKodepos tidak boleh kosong.");
          mRekanContactCrudBloc
              .add(ComboRKodeposChangedEvent(comboRKodepos: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboRKodepos = value;
        }
      },
      validatorCallback: (value) {
        if (value == null) {
          addError(error: "Field ComboRKodepos tidak boleh kosong.");
        }
      },
    );
  }

  Widget buildFieldTelp() {
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

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      MRekanContactCrudModel record = MRekanContactCrudModel(
        alamat1: fieldAlamat1Controller.text,
        email: fieldEmailController.text,
        mkotaId: fieldComboMKota?.mkotaId,
        mpropinsiId: fieldComboMPropinsi?.mpropinsiId,
        mrekancontact1Id: '',
        rkodeposId: fieldComboRKodepos?.rkodeposId,
        telp: fieldTelpController.text,
      );

      record.mrekancontact1Id =
          mRekanContactCrudBloc.state.record!.mrekancontact1Id;
      mRekanContactCrudBloc.add(MRekanContactCrudUbahEvent(record: record));

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
