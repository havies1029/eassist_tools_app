import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekancontactcrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekancontactcrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combomkota_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomkota_widget.dart';
import 'package:eassist_tools_app/models/combobox/combompropinsi_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combompropinsi_widget.dart';
import 'package:eassist_tools_app/models/combobox/comborkodepos_model.dart';
import 'package:eassist_tools_app/widgets/combobox/comborkodepos_widget.dart';

class MRekanContactFormBody extends StatefulWidget {
  const MRekanContactFormBody({super.key});

  @override
  State<MRekanContactFormBody> createState() => _MRekanContactFormBodyState();
}

class _MRekanContactFormBodyState extends State<MRekanContactFormBody> {
  final _formKey = GlobalKey<FormState>();
  late MRekanContactCrudBloc bloc;
  final comboMPropinsiKey = GlobalKey<DropdownSearchState<ComboMPropinsiModel>>();

  final fieldAlamat1Controller = TextEditingController();
  final fieldEmailController = TextEditingController();
  final fieldTelpController = TextEditingController();

  ComboMKotaModel? fieldComboMKota;
  ComboMPropinsiModel? fieldComboMPropinsi;
  ComboRKodeposModel? fieldComboRKodepos;

  // Edit mode flag
  bool isEditingSection = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
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
              // Header dengan judul dan tombol edit/save
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Contact Information",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(isEditingSection ? Icons.check : Icons.edit),
                    onPressed: () {
                      if (isEditingSection) {
                        onSaveForm();
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

              _buildLabelText("Alamat"),
              const SizedBox(height: 6),
              _buildStyledTextField(
                controller: fieldAlamat1Controller,
                hintText: "Masukkan alamat lengkap",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              _buildLabelText("Email"),
              const SizedBox(height: 6),
              _buildStyledTextField(
                controller: fieldEmailController,
                hintText: "contoh@mail.com",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              _buildLabelText("Provinsi"),
              const SizedBox(height: 6),
              _buildStyledDropdown(
                child: _buildFieldMPropinsiDropdown(),
              ),
              const SizedBox(height: 12),

              _buildLabelText("Kota"),
              const SizedBox(height: 6),
              _buildStyledDropdown(
                child: _buildFieldMKotaDropdown(),
              ),
              const SizedBox(height: 12),

              _buildLabelText("Kode Pos"),
              const SizedBox(height: 6),
              _buildStyledDropdown(
                child: _buildFieldRKodeposDropdown(),
              ),
              const SizedBox(height: 12),

              _buildLabelText("No. HP"),
              const SizedBox(height: 6),
              _buildStyledTextField(
                controller: fieldTelpController,
                hintText: "08xxxxxxxxxx",
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Field tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabelText(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: !isEditingSection,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
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
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildStyledDropdown({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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

  Widget _buildFieldMKotaDropdown() {
    return isEditingSection
        ? buildFieldComboMKota(
      labelText: 'Kota',
      initItem: fieldComboMKota,
      propinsiId: fieldComboMPropinsi?.mpropinsiId ?? "",
      onChangedCallback: (value) {
        if (value != null) {
          setState(() {
            fieldComboMKota = value;
            fieldComboRKodepos = null;
          });
          bloc.add(ComboMKotaChangedEvent(comboMKota: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) fieldComboMKota = value;
      },
      validatorCallback: (value) {},
    )
        : _buildDisabledDropdown(
      text: fieldComboMKota?.kotaDesc ?? '-',
    );
  }

  Widget _buildFieldMPropinsiDropdown() {
    return isEditingSection
        ? buildFieldComboMPropinsi(
      comboKey: comboMPropinsiKey,
      labelText: 'Provinsi',
      initItem: fieldComboMPropinsi,
      onChangedCallback: (value) {
        if (value != null) {
          setState(() {
            fieldComboMPropinsi = value;
            // Reset dependent values
            fieldComboMKota = null;
            fieldComboRKodepos = null;
            // Trigger API Kota berdasarkan propinsiId baru
            bloc.add(ComboMPropinsiChangedEvent(comboMPropinsi: value));
          });

          // OPTIONAL: Notifikasi pemilihan
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Provinsi dipilih: ${value.propinsiNama}'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      onSaveCallback: (value) {
        if (value != null) fieldComboMPropinsi = value;
      },
      validatorCallback: (value) {},
    )
        : _buildDisabledDropdown(
      text: fieldComboMPropinsi?.propinsiNama ?? '-',
    );
  }

  Widget _buildFieldRKodeposDropdown() {
    return isEditingSection
        ? buildFieldComboRKodepos(
      labelText: 'Kode Pos',
      initItem: fieldComboRKodepos,
      kotaId: fieldComboMKota?.mkotaId ?? "",
      onChangedCallback: (value) {
        if (value != null) {
          fieldComboRKodepos = value;
          bloc.add(ComboRKodeposChangedEvent(comboRKodepos: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) fieldComboRKodepos = value;
      },
      validatorCallback: (value) {},
    )
        : _buildDisabledDropdown(
      text: fieldComboRKodepos?.kodeposNo ?? '-',
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

      setState(() {
        isEditingSection = false;
      });
    }
  }
}