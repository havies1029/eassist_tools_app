import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/widgets/combobox/combompekerjaan_widget.dart';
import 'package:eassist_tools_app/widgets/combobox/combomjnskel_widget.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralidvcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/profile_upload_ktp_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekangeneralidvcrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combompekerjaan_model.dart';
import 'package:eassist_tools_app/models/combobox/combomjnskel_model.dart';
import 'package:eassist_tools_app/pages/gen_profile/upload_ktp_dialog.dart';

class RekanGeneralIdv extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const RekanGeneralIdv({
    Key? key,
    required this.viewMode,
    required this.recordId,
  }) : super(key: key);

  @override
  State<RekanGeneralIdv> createState() => _RekanGeneralIdvState();
}

class _RekanGeneralIdvState extends State<RekanGeneralIdv> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  late MRekanGeneralIdvCrudBloc bloc;

  final TextEditingController fieldRekanNamaController = TextEditingController();
  ComboMPekerjaanModel? fieldComboMPekerjaan;
  ComboMJnskelModel? fieldComboMJnskel;

  final comboMPekerjaanKey = GlobalKey<DropdownSearchState<ComboMPekerjaanModel>>();
  final comboMJnskelKey = GlobalKey<DropdownSearchState<ComboMJnskelModel>>();

  bool isEditingSection = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (widget.viewMode == "ubah") {
        context.read<MRekanGeneralIdvCrudBloc>().add(MRekanGeneralIdvCrudLihatEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<MRekanGeneralIdvCrudBloc>(context);

    return BlocListener<ProfileUploadKtpBloc, ProfileUploadKtpState>(
      listener: (context, state) {
        if (state is UploadKtpSuccess) {
          bloc.add(UpdateIsKtpUploaded(isUploaded: true));
        }
      },
      child: BlocConsumer<MRekanGeneralIdvCrudBloc, MRekanGeneralIdvCrudState>(
        listener: (context, state) {
          if (state.isLoaded && state.record != null) {
            fieldRekanNamaController.text = state.record?.rekanNama ?? '';
            fieldComboMPekerjaan = state.comboMPekerjaan;
            fieldComboMJnskel = state.comboMJnskel;
          }
        },
        builder: (context, state) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Informasi Umum:",
                          style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: Icon(isEditingSection ? Icons.check : Icons.edit),
                        tooltip: isEditingSection ? "Simpan" : "Ubah",
                        onPressed: () {
                          if (isEditingSection) {
                            onSaveForm();
                          } else {
                            setState(() => isEditingSection = true);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  _buildLabelText("Jenis Kelamin"),
                  const SizedBox(height: 6),
                  _buildStyledDropdown(
                    child: isEditingSection
                        ? _buildComboMJnskel()
                        : _buildDisabledDropdown(text: fieldComboMJnskel?.jenisDesc ?? "Belum diisi"),
                  ),
                  const SizedBox(height: 12),

                  _buildLabelText("Pekerjaan"),
                  const SizedBox(height: 6),
                  _buildStyledDropdown(
                    child: isEditingSection
                        ? _buildComboMPekerjaan()
                        : _buildDisabledDropdown(text: fieldComboMPekerjaan?.kerjaNama ?? "Belum diisi"),
                  ),
                  const SizedBox(height: 12),

                  _buildLabelText("Nama Rekan"),
                  const SizedBox(height: 6),
                  _buildTextField(
                    controller: fieldRekanNamaController,
                    hintText: "Masukkan nama lengkap",
                  ),
                  const SizedBox(height: 12),

                  state.isKtpUploaded
                      ? const Text("✅ KTP sudah diupload.")
                      : isEditingSection
                      ? ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<ProfileUploadKtpBloc>(),
                          child: const UploadKtpDialog(),
                        ),
                      );
                    },
                    child: const Text("Upload KTP"),
                  )
                      : const SizedBox.shrink(),

                  const SizedBox(height: 12),
                  FormError(errors: errors, key: null),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabelText(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w200)),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 2,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: !isEditingSection,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 14,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(kStringNullError);
          return "";
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(kStringNullError);
        }
      },
    );
  }

  Widget _buildStyledDropdown({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  Widget _buildDisabledDropdown({required String text}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildComboMPekerjaan() {
    return buildFieldComboMPekerjaan(
      labelText: 'Pilih',
      initItem: fieldComboMPekerjaan,
      onChangedCallback: (value) {
        if (value != null) {
          fieldComboMPekerjaan = value;
          bloc.add(ComboMPekerjaanChangedEvent(comboMPekerjaan: value));
          removeError("Field pekerjaan tidak boleh kosong.");
        }
      },
      onSaveCallback: (value) {
        if (value != null) fieldComboMPekerjaan = value;
      },
      validatorCallback: (value) {
        if (value == null) addError("Field pekerjaan tidak boleh kosong.");
      },
      comboKey: comboMPekerjaanKey,
    );
  }

  Widget _buildComboMJnskel() {
    return buildFieldComboMJnskel(
      labelText: 'Pilih',
      initItem: fieldComboMJnskel,
      onChangedCallback: (value) {
        if (value != null) {
          fieldComboMJnskel = value;
          bloc.add(ComboMJnskelChangedEvent(comboMJnskel: value));
          removeError("Field jenis kelamin tidak boleh kosong.");
        }
      },
      onSaveCallback: (value) {
        if (value != null) fieldComboMJnskel = value;
      },
      validatorCallback: (value) {
        if (value == null) addError("Field jenis kelamin tidak boleh kosong.");
      },
      comboKey: comboMJnskelKey,
    );
  }

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final record = MRekanGeneralIdvCrudModel(
        mjnskelId: fieldComboMJnskel?.mjnskelId,
        mpekerjaanId: fieldComboMPekerjaan?.mpekerjaanId,
        rekanNama: fieldRekanNamaController.text,
        mrekan1Id: bloc.state.record?.mrekan1Id ?? '',
      );

      if (widget.viewMode == "tambah") {
        bloc.add(MRekanGeneralIdvCrudTambahEvent(record: record));
      } else {
        bloc.add(MRekanGeneralIdvCrudUbahEvent(record: record));
      }

      setState(() => isEditingSection = false);
    }
  }

  void addError(String error) {
    if (!errors.contains(error)) {
      setState(() => errors.add(error));
    }
  }

  void removeError(String error) {
    if (errors.contains(error)) {
      setState(() => errors.remove(error));
    }
  }
}
