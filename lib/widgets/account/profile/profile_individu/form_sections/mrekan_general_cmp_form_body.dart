import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralcmpcrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekangeneralcmpcrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combombentukcst_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombentukcst_widget.dart';
import 'package:eassist_tools_app/models/combobox/combombidang_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombidang_widget.dart';

class MRekanGeneralCmpFormBody extends StatefulWidget {
  const MRekanGeneralCmpFormBody({super.key});

  @override
  State<MRekanGeneralCmpFormBody> createState() => _MRekanGeneralCmpFormBodyState();
}

class _MRekanGeneralCmpFormBodyState extends State<MRekanGeneralCmpFormBody> {
  final _formKey = GlobalKey<FormState>();
  late MRekanGeneralCmpCrudBloc bloc;

  final TextEditingController fieldRekanNamaController = TextEditingController();

  ComboMBentukCstModel? fieldComboMBentukCst;
  ComboMBidangModel? fieldComboMBidang;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      bloc.add(MRekanGeneralCmpCrudLihatEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<MRekanGeneralCmpCrudBloc>(context);

    return BlocListener<MRekanGeneralCmpCrudBloc, MRekanGeneralCmpCrudState>(
      listener: (context, state) {
        if (state.isLoaded && state.record != null) {
          fieldRekanNamaController.text = state.record!.rekanNama;
          fieldComboMBentukCst = state.comboMBentukCst;
          fieldComboMBidang = state.comboMBidang;
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLabelText("Nama Rekan"),
              const SizedBox(height: 6),
              _buildTextField(
                controller: fieldRekanNamaController,
                hintText: "Masukkan nama perusahaan",
                keyboardType: TextInputType.multiline,
                maxLines: 2,
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

              ElevatedButton(
                onPressed: onSaveForm,
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabelText(String text) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.w600));
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _buildStyledDropdown({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: child,
    );
  }

  Widget _buildComboMBentukCst() {
    return buildFieldComboMBentukCst(
      labelText: 'Bentuk Badan Usaha',
      initItem: fieldComboMBentukCst,
      onChangedCallback: (value) {
        if (value != null) {
          fieldComboMBentukCst = value;
          bloc.add(ComboMBentukCstChangedEvent(comboMBentukCst: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) fieldComboMBentukCst = value;
      },
      validatorCallback: (value) {},
      comboKey: null,
    );
  }

  Widget _buildComboMBidang() {
    return buildFieldComboMBidang(
      labelText: 'Bidang Usaha',
      initItem: fieldComboMBidang,
      onChangedCallback: (value) {
        if (value != null) {
          fieldComboMBidang = value;
          bloc.add(ComboMBidangChangedEvent(comboMBidang: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) fieldComboMBidang = value;
      },
      validatorCallback: (value) {},
      comboKey: null,
    );
  }

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final record = MRekanGeneralCmpCrudModel(
        rekanNama: fieldRekanNamaController.text,
        mbentukcstId: fieldComboMBentukCst?.mbentukcstId,
        mbidangId: fieldComboMBidang?.mbidangId,
        mrekan1Id: bloc.state.record?.mrekan1Id ?? '',
      );

      bloc.add(MRekanGeneralCmpCrudUbahEvent(record: record));
    }
  }
}
