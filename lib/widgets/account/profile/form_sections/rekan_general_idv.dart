import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/widgets/combobox/combompekerjaan_widget.dart';
import 'package:eassist_tools_app/widgets/combobox/combomjnskel_widget.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralidvcrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekangeneralidvcrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combompekerjaan_model.dart';
import 'package:eassist_tools_app/models/combobox/combomjnskel_model.dart';

import '../../../../blocs/gen_profile/mrekan1crud_bloc.dart';

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
      bloc = context.read<MRekanGeneralIdvCrudBloc>();
      bloc.add(MRekanGeneralIdvCrudLihatEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<MRekanGeneralIdvCrudBloc>(context);

    return BlocConsumer<MRekanGeneralIdvCrudBloc, MRekanGeneralIdvCrudState>(
      listener: (context, state) {
        if (state.isLoaded && state.record != null) {
          fieldRekanNamaController.text = state.record?.rekanNama ?? '';
          fieldComboMPekerjaan = state.comboMPekerjaan;
          fieldComboMJnskel = state.comboMJnskel;
        }

        if (state.isSaved && !state.hasFailure) {
          bloc.add(MRekanGeneralIdvCrudLihatEvent());
          context.read<MRekan1CrudBloc>().add(MRekan1CrudReloadEvent());
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
                _buildLabelText("Nama Rekan", isRequired: true),
                const SizedBox(height: 6),
                _buildTextField(
                  controller: fieldRekanNamaController,
                  hintText: "Masukkan nama lengkap",
                ),
                const SizedBox(height: 12),
                _buildLabelText("Jenis Kelamin", isRequired: true),
                const SizedBox(height: 6),
                _buildStyledDropdown(
                  child: isEditingSection
                      ? _buildComboMJnskel()
                      : _buildDisabledDropdown(text: fieldComboMJnskel?.jenisDesc ?? "Belum diisi"),
                ),
                const SizedBox(height: 12),
                _buildLabelText("Pekerjaan", isRequired: true),
                const SizedBox(height: 6),
                _buildStyledDropdown(
                  child: isEditingSection
                      ? _buildComboMPekerjaan()
                      : _buildDisabledDropdown(text: fieldComboMPekerjaan?.kerjaNama ?? "Belum diisi"),
                ),
                const SizedBox(height: 12),
                FormError(errors: errors, key: null),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildLabelText(String text, {bool isRequired = false}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          if (isRequired)
            const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Text(
                '*',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int? minLines,
    int? maxLines,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: !isEditingSection,
      keyboardType: keyboardType,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 5, // Limit to maximum 5 lines
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 14,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue.shade400, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        filled: true,
        fillColor: isEditingSection ? Colors.white : Colors.grey.shade50,
        alignLabelWithHint: true,
        isDense: true, // Makes the field more compact
      ),
      style: const TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 14,
        height: 1.3, // Slightly reduced line height
      ),
      textAlignVertical: TextAlignVertical.top,
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError("Field nama rekan harus diisi.");
          return "Field nama rekan harus diisi.";
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
        color: Colors.white,
      ),
      child: child,
    );
  }

  Widget _buildDisabledDropdown({required String text}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 14,
          color: Colors.black87,
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
        if (value == null) {
          addError("Field pekerjaan tidak boleh kosong.");
          return "Field pekerjaan harus diisi";
        }
        return null;
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
        if (value == null) {
          addError("Field jenis kelamin tidak boleh kosong.");
          return "Field jenis kelamin harus diisi";
        }
        return null;
      },
      comboKey: comboMJnskelKey,
    );
  }


  void onSaveForm() {
    setState(() {
      errors.clear();
    });

    final isFormValid = _formKey.currentState!.validate();
    print("🔍 Form validasi result: $isFormValid");

    // Validasi manual untuk dropdown dan text
    if (fieldComboMJnskel == null) {
      addError("Field jenis kelamin tidak boleh kosong.");
      print("⚠️ Jenis kelamin belum dipilih");
    }
    if (fieldComboMPekerjaan == null) {
      addError("Field pekerjaan tidak boleh kosong.");
      print("⚠️ Pekerjaan belum dipilih");
    }
    if (fieldRekanNamaController.text.trim().isEmpty) {
      addError("Field nama rekan harus diisi.");
      print("⚠️ Nama rekan kosong");
    }

    // Jika ada error, hentikan proses
    if (!isFormValid || errors.isNotEmpty) {
      print("🛑 Gagal simpan, terdapat error: ${errors.join(', ')}");
      return;
    }

    // Ambil ID dari state bloc (pastikan record sudah dimuat)
    final currentId = bloc.state.record?.mrekan1Id;
    print("📦 Mengambil mrekan1Id dari bloc: $currentId");

    if (currentId == null || currentId.isEmpty) {
      addError("Data belum dimuat, tidak dapat menyimpan.");
      print("🛑 ID tidak tersedia, tidak bisa menyimpan.");
      return;
    }

    // Buat model baru
    final record = MRekanGeneralIdvCrudModel(
      mjnskelId: fieldComboMJnskel!.mjnskelId,
      mpekerjaanId: fieldComboMPekerjaan!.mpekerjaanId,
      rekanNama: fieldRekanNamaController.text.trim(),
      mrekan1Id: currentId,
    );

    print("📤 [MRekanGeneralIdvUbah] Mengirim data:");
    print("   - mjnskelId: ${record.mjnskelId}");
    print("   - mpekerjaanId: ${record.mpekerjaanId}");
    print("   - rekanNama: ${record.rekanNama}");
    print("   - mrekan1Id: ${record.mrekan1Id}");

    // Kirim ke Bloc untuk disimpan
    bloc.add(MRekanGeneralIdvCrudUbahEvent(record: record));

    // Matikan mode edit jika ada
    setState(() {
      isEditingSection = false;
    });
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