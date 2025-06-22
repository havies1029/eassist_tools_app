import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralcmpcrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekangeneralcmpcrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combombentukcst_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombentukcst_widget.dart';
import 'package:eassist_tools_app/models/combobox/combombidang_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombidang_widget.dart';

class RekanGeneralCmp extends StatefulWidget {
  const RekanGeneralCmp({super.key});

  @override
  State<RekanGeneralCmp> createState() => _RekanGeneralCmpState();
}

class _RekanGeneralCmpState extends State<RekanGeneralCmp> {
  final _formKey = GlobalKey<FormState>();
  late MRekanGeneralCmpCrudBloc bloc;

  final TextEditingController fieldRekanNamaController = TextEditingController();

  ComboMBentukCstModel? fieldComboMBentukCst;
  ComboMBidangModel? fieldComboMBidang;

  bool isEditingSection = false;

  // === Styles ===
  static const TextStyle labelStyle = TextStyle(fontWeight: FontWeight.w200);
  static const TextStyle hintStyle = TextStyle(
    fontFamily: 'Satoshi',
    fontSize: 14,
    color: Colors.grey,
  );
  static const TextStyle textStyle = TextStyle(
    fontFamily: 'Satoshi',
    fontSize: 14,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      bloc.add(MRekanGeneralCmpCrudLihatEvent());
    });
  }

  @override
  void dispose() {
    fieldRekanNamaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<MRekanGeneralCmpCrudBloc>(context);

    return BlocListener<MRekanGeneralCmpCrudBloc, MRekanGeneralCmpCrudState>(
      listener: (context, state) {
        if (state.isLoaded && state.record != null) {
          fieldRekanNamaController.text = state.record!.rekanNama!;
          fieldComboMBentukCst = state.comboMBentukCst;
          fieldComboMBidang = state.comboMBidang;
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Informasi Perusahaan :",
                      style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Icon(isEditingSection ? Icons.check : Icons.edit),
                    onPressed: () {
                      isEditingSection ? onSaveForm() : setState(() => isEditingSection = true);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _buildLabelText("Nama Badan Usaha"),
              const SizedBox(height: 6),
              _buildStyledTextField(
                controller: fieldRekanNamaController,
                hintText: "Masukkan nama perusahaan",
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                validator: (value) => (value == null || value.isEmpty) ? 'Field tidak boleh kosong' : null,
              ),
              const SizedBox(height: 12),

              _buildLabelText("Bentuk Badan Usaha"),
              const SizedBox(height: 6),
              _buildStyledDropdown(child: _buildComboMBentukCst()),
              const SizedBox(height: 12),

              _buildLabelText("Bidang Usaha"),
              const SizedBox(height: 6),
              _buildStyledDropdown(child: _buildComboMBidang()),
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
      child: Text(text, style: labelStyle),
    );
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: !isEditingSection,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      validator: validator,
      onChanged: onChanged,
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
      child: Text(text, style: textStyle),
    );
  }

  Widget _buildComboMBentukCst() {
    return isEditingSection
        ? buildFieldComboMBentukCst(
      labelText: 'Pilih',
      initItem: fieldComboMBentukCst,
      onChangedCallback: (value) {
        if (value != null) {
          fieldComboMBentukCst = value;
          bloc.add(ComboMBentukCstChangedEvent(comboMBentukCst: value));
        }
      },
      onSaveCallback: (value) => fieldComboMBentukCst = value,
      validatorCallback: (value) {},
      comboKey: null,
    )
        : _buildDisabledDropdown(text: fieldComboMBentukCst?.bentukNama ?? 'Belum diisi');
  }

  Widget _buildComboMBidang() {
    return isEditingSection
        ? buildFieldComboMBidang(
      labelText: 'Pilih',
      initItem: fieldComboMBidang,
      onChangedCallback: (value) {
        if (value != null) {
          fieldComboMBidang = value;
          bloc.add(ComboMBidangChangedEvent(comboMBidang: value));
        }
      },
      onSaveCallback: (value) => fieldComboMBidang = value,
      validatorCallback: (value) {},
      comboKey: null,
    )
        : _buildDisabledDropdown(text: fieldComboMBidang?.bidangNama ?? 'Belum diisi');
  }

  // === API Submit & Logic ===
  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final record = MRekanGeneralCmpCrudModel(
        rekanNama: fieldRekanNamaController.text,
        mbentukcstId: fieldComboMBentukCst?.mbentukcstId,
        mbidangId: fieldComboMBidang?.mbidangId,
      );

      bloc.add(MRekanGeneralCmpCrudUbahEvent(record: record));

      setState(() => isEditingSection = false);
    }
  }
}