import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekancontactcrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekancontactcrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combomkota_model.dart';
import 'package:eassist_tools_app/models/combobox/combompropinsi_model.dart';
import 'package:eassist_tools_app/models/combobox/comborkodepos_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomkota_widget.dart';
import 'package:eassist_tools_app/widgets/combobox/combompropinsi_widget.dart';
import 'package:eassist_tools_app/widgets/combobox/comborkodepos_widget.dart';

class RekanContact extends StatefulWidget {
  const RekanContact({super.key});

  @override
  State<RekanContact> createState() => _RekanContactState();
}

// Bagian import tetap, tidak perlu diubah

class _RekanContactState extends State<RekanContact> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  final comboMPropinsiKey = GlobalKey<DropdownSearchState<ComboMPropinsiModel>>();

  final TextEditingController fieldAlamat1Controller = TextEditingController();
  final TextEditingController fieldEmailController = TextEditingController();
  final TextEditingController fieldTelpController = TextEditingController();

  ComboMKotaModel? fieldComboMKota;
  ComboMPropinsiModel? fieldComboMPropinsi;
  ComboRKodeposModel? fieldComboRKodepos;

  bool isEditingSection = false;
  late MRekanContactCrudBloc bloc;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      bloc = BlocProvider.of<MRekanContactCrudBloc>(context);
      bloc.add(MRekanContactCrudLihatEvent());
    });
  }

  @override
  void dispose() {
    fieldAlamat1Controller.dispose();
    fieldEmailController.dispose();
    fieldTelpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<MRekanContactCrudBloc>(context);

    return BlocListener<MRekanContactCrudBloc, MRekanContactCrudState>(
      listener: (context, state) {
        if (state.isLoaded && state.record != null) {
          fieldAlamat1Controller.text = state.record!.alamat1;
          fieldEmailController.text = state.record!.email;
          fieldTelpController.text = state.record!.telp;
          fieldComboMKota = state.comboMKota;
          fieldComboMPropinsi = state.comboMPropinsi;
          fieldComboRKodepos = state.comboRKodepos;
        }
      },
      child: Container(
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
                    child: Text("Kontak Klien :", style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold)),
                  ),
                  IconButton(
                    icon: Icon(isEditingSection ? Icons.check : Icons.edit),
                    onPressed: () => isEditingSection ? onSaveForm() : setState(() => isEditingSection = true),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _buildLabel("Alamat"),
              _buildTextField(
                controller: fieldAlamat1Controller,
                hintText: "Masukkan alamat lengkap",
                maxLines: 2,
                errorKey: "Alamat tidak boleh kosong.",
              ),

              _buildLabel("Email"),
              _buildTextField(
                controller: fieldEmailController,
                hintText: "contoh@mail.com",
                keyboardType: TextInputType.emailAddress,
                errorKey: "Email tidak boleh kosong.",
              ),

              _buildLabel("Provinsi"),
              _buildStyledDropdown(
                child: isEditingSection ? buildFieldComboMPropinsi(
                  comboKey: comboMPropinsiKey,
                  labelText: "Pilih",
                  initItem: fieldComboMPropinsi,
                  onChangedCallback: (value) {
                    if (value != null) {
                      setState(() {
                        fieldComboMPropinsi = value;
                        fieldComboMKota = null;
                        fieldComboRKodepos = null;
                      });
                      bloc.add(ComboMPropinsiChangedEvent(comboMPropinsi: value));
                      removeError("Provinsi tidak boleh kosong.");
                    }
                  },
                  onSaveCallback: (value) => fieldComboMPropinsi = value,
                  validatorCallback: (value) {
                    if (value == null) addError("Provinsi tidak boleh kosong.");
                  },
                ) : _buildDisabledDropdown(fieldComboMPropinsi?.propinsiNama ?? 'Belum diisi'),
              ),

              _buildLabel("Kota"),
              _buildStyledDropdown(
                child: isEditingSection ? buildFieldComboMKota(
                  initItem: fieldComboMKota,
                  propinsiId: fieldComboMPropinsi?.mpropinsiId ?? "",
                  onChangedCallback: (value) {
                    if (value != null) {
                      setState(() {
                        fieldComboMKota = value;
                        fieldComboRKodepos = null;
                      });
                      bloc.add(ComboMKotaChangedEvent(comboMKota: value));
                      removeError("Kota tidak boleh kosong.");
                    }
                  },
                  onSaveCallback: (value) => fieldComboMKota = value,
                  validatorCallback: (value) {
                    if (value == null) addError("Kota tidak boleh kosong.");
                  },
                  labelText: 'Pilih',
                ) : _buildDisabledDropdown(fieldComboMKota?.kotaDesc ?? 'Belum diisi'),
              ),

              _buildLabel("Kode Pos"),
              _buildStyledDropdown(
                child: isEditingSection ? buildFieldComboRKodepos(
                  initItem: fieldComboRKodepos,
                  kotaId: fieldComboMKota?.mkotaId ?? "",
                  onChangedCallback: (value) {
                    if (value != null) {
                      fieldComboRKodepos = value;
                      bloc.add(ComboRKodeposChangedEvent(comboRKodepos: value));
                      removeError("Kode pos tidak boleh kosong.");
                    }
                  },
                  onSaveCallback: (value) => fieldComboRKodepos = value,
                  validatorCallback: (value) {
                    if (value == null) addError("Kode pos tidak boleh kosong.");
                  },
                  labelText: 'Pilih',
                ) : _buildDisabledDropdown(fieldComboRKodepos?.kodeposNo ?? 'Belum diisi'),
              ),

              _buildLabel("No. HP"),
              _buildTextField(
                controller: fieldTelpController,
                hintText: "Contoh: 6283388774644",
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                errorKey: "Nomor HP tidak boleh kosong.",
              ),

              if (errors.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: errors.map((e) => Text(e, style: const TextStyle(color: Colors.red, fontSize: 12))).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w400)),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int? maxLines,
    required String errorKey,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: !isEditingSection,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontFamily: 'Satoshi', fontSize: 14, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade400)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.blue.shade400)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        filled: true,
        fillColor: isEditingSection ? Colors.white : Colors.grey.shade50,
        isDense: true,
      ),
      style: const TextStyle(fontFamily: 'Satoshi', fontSize: 14),
      validator: (value) {
        if (value == null || value.isEmpty) {
          addError(errorKey);
          return "";
        }
        return null;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(errorKey);
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

  Widget _buildDisabledDropdown(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: const TextStyle(fontFamily: 'Satoshi', fontSize: 14, color: Colors.black87)),
    );
  }

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final record = MRekanContactCrudModel(
        alamat1: fieldAlamat1Controller.text,
        email: fieldEmailController.text,
        mkotaId: fieldComboMKota?.mkotaId,
        mpropinsiId: fieldComboMPropinsi?.mpropinsiId,
        mrekancontact1Id: bloc.state.record?.mrekancontact1Id ?? '',
        rkodeposId: fieldComboRKodepos?.rkodeposId,
        telp: fieldTelpController.text,
      );

      bloc.add(MRekanContactCrudUbahEvent(record: record));
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
