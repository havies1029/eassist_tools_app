import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/profile/rekancontact_bloc.dart';
import 'package:eassist_tools_app/models/profile/rekancontact_model.dart';
import 'package:eassist_tools_app/models/combobox/combomkota_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomkota_widget.dart';
import 'package:eassist_tools_app/models/combobox/combompropinsi_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combompropinsi_widget.dart';
import 'package:eassist_tools_app/models/combobox/comborkodepos_model.dart';
import 'package:eassist_tools_app/widgets/combobox/comborkodepos_widget.dart';

/// Widget yang hanya berisi “body” form Kontak Perusahaan (tanpa Dialog).
class RekanContactFormBody extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const RekanContactFormBody({
    Key? key,
    required this.viewMode,
    required this.recordId,
  }) : super(key: key);

  @override
  _RekanContactFormBodyState createState() => _RekanContactFormBodyState();
}

class _RekanContactFormBodyState extends State<RekanContactFormBody> {
  late RekanContactBloc rekanContactBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  // Controllers
  final TextEditingController fieldAlamat1Controller = TextEditingController();
  final TextEditingController fieldEmailController = TextEditingController();
  final TextEditingController fieldMrekan1IdController =
  TextEditingController();
  final TextEditingController fieldTelpController = TextEditingController();

  // Dropdown models
  ComboMKotaModel? fieldComboMKota;
  ComboMPropinsiModel? fieldComboMPropinsi;
  ComboRKodeposModel? fieldComboRKodepos;

  // Edit mode flag
  bool isEditingSection = false;

  @override
  void initState() {
    super.initState();
    // Delay untuk memastikan Bloc sudah siap
    Future.delayed(const Duration(milliseconds: 500), () {
      _loadData();
    });
  }

  @override
  void dispose() {
    fieldAlamat1Controller.dispose();
    fieldEmailController.dispose();
    fieldMrekan1IdController.dispose();
    fieldTelpController.dispose();
    super.dispose();
  }

  void _loadData() {
    if (widget.viewMode == "ubah") {
      rekanContactBloc.add(
        RekanContactLihatEvent(recordId: widget.recordId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    rekanContactBloc = BlocProvider.of<RekanContactBloc>(context);

    return Container(
      color: Colors.white, // <— atur background jadi putih
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Judul + tombol edit/check
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.viewMode == "tambah"
                          ? "Tambah Kontak Perusahaan"
                          : "Ubah Kontak Perusahaan",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(isEditingSection ? Icons.check : Icons.edit),
                    onPressed: () {
                      if (isEditingSection) {
                        _onSaveForm();
                      } else {
                        setState(() {
                          isEditingSection = true;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Field Alamat
              _buildLabelText('Alamat'),
              const SizedBox(height: 6),
              _buildStyledTextField(
                controller: fieldAlamat1Controller,
                hintText: 'Masukkan alamat lengkap',
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    _addError(kStringNullError);
                    return "";
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.isNotEmpty) _removeError(kStringNullError);
                },
              ),
              const SizedBox(height: 12),

              // Field Email
              _buildLabelText('Email'),
              const SizedBox(height: 6),
              _buildStyledTextField(
                controller: fieldEmailController,
                hintText: 'contoh@mail.com',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    _addError(kStringNullError);
                    return "";
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.isNotEmpty) _removeError(kStringNullError);
                },
              ),
              const SizedBox(height: 12),

              // Dropdown: Provinsi
              _buildLabelText('Provinsi'),
              const SizedBox(height: 6),
              _buildStyledDropdown(
                child: buildFieldMpropinsiId(),
              ),
              const SizedBox(height: 12),

              // Dropdown: Kota
              _buildLabelText('Kota'),
              const SizedBox(height: 6),
              _buildStyledDropdown(
                child: buildFieldMkotaId(),
              ),
              const SizedBox(height: 12),

              // Dropdown: Kode Pos
              _buildLabelText('Kode Pos'),
              const SizedBox(height: 6),
              _buildStyledDropdown(
                child: buildFieldRkodeposId(),
              ),
              const SizedBox(height: 12),

              // Field ID Rekan
              _buildLabelText('ID Rekan'),
              const SizedBox(height: 6),
              _buildStyledTextField(
                controller: fieldMrekan1IdController,
                hintText: 'Masukkan ID Rekan',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    _addError(kStringNullError);
                    return "";
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.isNotEmpty) _removeError(kStringNullError);
                },
              ),
              const SizedBox(height: 12),

              // Field Telp
              _buildLabelText('No. HP'),
              const SizedBox(height: 6),
              _buildStyledTextField(
                controller: fieldTelpController,
                hintText: '08xxxxxxxxxx',
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    _addError(kStringNullError);
                    return "";
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.isNotEmpty) _removeError(kStringNullError);
                },
              ),

              const SizedBox(height: 16),

              // Daftar error
              FormError(errors: errors, key: null),
            ],
          ),
        ),
      ),
    );
  }

  // Helper: Label
  Widget _buildLabelText(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  // Helper: TextField style Outline
  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: !isEditingSection,
      keyboardType: keyboardType,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }

  // Helper: Dropdown style Outline
  Widget _buildStyledDropdown({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }

  // Simpan form (trigger Bloc event)
  // Simpan form (trigger Bloc event)
  void _onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final record = RekanContactModel(
        alamat1: fieldAlamat1Controller.text,
        email: fieldEmailController.text,
        mkotaId: fieldComboMKota?.mkotaId,
        mpropinsiId: fieldComboMPropinsi?.mpropinsiId,
        mrekan1Id: fieldMrekan1IdController.text,
        mrekancontact1Id: '',
        rkodeposId: fieldComboRKodepos?.rkodeposId,
        telp: fieldTelpController.text,
      );

      if (widget.viewMode == "tambah") {
        rekanContactBloc.add(RekanContactTambahEvent(record: record));
      } else {
        record.mrekancontact1Id =
            rekanContactBloc.state.record!.mrekancontact1Id;
        rekanContactBloc.add(RekanContactUbahEvent(record: record));
      }

      // Setelah save, keluar dari mode edit
      setState(() {
        isEditingSection = false;
      });
    }
  }

  // Tambah/hapus error
  void _addError(String error) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void _removeError(String error) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  // ======================================================================
  // Salin “helper” dropdown persis dari versi dialog Anda, HANYA hapus comboKey
  // ======================================================================

  Widget buildFieldMkotaId() {
    return buildFieldComboMKota(
      labelText: 'mkotaId',
      initItem: fieldComboMKota,
      onChangedCallback: (value) {
        if (value != null) {
          _removeError("Field ComboMKota tidak boleh kosong.");
          rekanContactBloc.add(ComboMKotaChangedEvent(comboMKota: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboMKota = value;
        }
      },
      validatorCallback: (value) {
        if (value == null) {
          _addError("Field ComboMKota tidak boleh kosong.");
        }
      },
    );
  }

  Widget buildFieldMpropinsiId() {
    return buildFieldComboMPropinsi(
      labelText: 'mpropinsiId',
      initItem: fieldComboMPropinsi,
      onChangedCallback: (value) {
        if (value != null) {
          _removeError("Field ComboMPropinsi tidak boleh kosong.");
          rekanContactBloc
              .add(ComboMPropinsiChangedEvent(comboMPropinsi: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboMPropinsi = value;
        }
      },
      validatorCallback: (value) {
        if (value == null) {
          _addError("Field ComboMPropinsi tidak boleh kosong.");
        }
      },
    );
  }

  Widget buildFieldRkodeposId() {
    return buildFieldComboRKodepos(
      labelText: 'rkodeposId',
      initItem: fieldComboRKodepos,
      onChangedCallback: (value) {
        if (value != null) {
          _removeError("Field ComboRKodepos tidak boleh kosong.");
          rekanContactBloc.add(ComboRKodeposChangedEvent(comboRKodepos: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboRKodepos = value;
        }
      },
      validatorCallback: (value) {
        if (value == null) {
          _addError("Field ComboRKodepos tidak boleh kosong.");
        }
      },
    );
  }
}
