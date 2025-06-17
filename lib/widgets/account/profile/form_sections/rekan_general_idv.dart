import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralidvcrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekangeneralidvcrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combompekerjaan_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combompekerjaan_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';

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
  late MRekanGeneralIdvCrudBloc bloc;

  final TextEditingController fieldMjnsclientIdController = TextEditingController();
  final TextEditingController fieldMjnskelIdController = TextEditingController();
  final TextEditingController fieldRekanNamaController = TextEditingController();

  ComboMPekerjaanModel? fieldComboMPekerjaan;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (widget.viewMode == "ubah") {
        bloc.add(MRekanGeneralIdvCrudLihatEvent(recordId: widget.recordId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<MRekanGeneralIdvCrudBloc>(context);

    return BlocListener<MRekanGeneralIdvCrudBloc, MRekanGeneralIdvCrudState>(
      listener: (context, state) {
        if (state.isLoaded && state.record != null) {
          fieldMjnsclientIdController.text = state.record!.mjnsclientId;
          fieldMjnskelIdController.text = state.record!.mjnskelId;
          fieldRekanNamaController.text = state.record!.rekanNama;
          fieldComboMPekerjaan = state.comboMPekerjaan;
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
              _buildLabelText("Jenis Client ID"),
              const SizedBox(height: 6),
              _buildTextField(controller: fieldMjnsclientIdController, hintText: "mjnsclientId"),
              const SizedBox(height: 12),

              _buildLabelText("Jenis Kelamin ID"),
              const SizedBox(height: 6),
              _buildTextField(controller: fieldMjnskelIdController, hintText: "mjnskelId"),
              const SizedBox(height: 12),

              _buildLabelText("Pekerjaan"),
              const SizedBox(height: 6),
              _buildStyledDropdown(child: _buildComboMPekerjaan()),
              const SizedBox(height: 12),

              _buildLabelText("Nama Rekan"),
              const SizedBox(height: 6),
              _buildTextField(
                controller: fieldRekanNamaController,
                hintText: "Masukkan nama lengkap",
                keyboardType: TextInputType.multiline,
                maxLines: 2,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                      child: const Text("Tutup"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onSaveForm,
                      child: const Text("Simpan"),
                    ),
                  ),
                ],
              )
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

  Widget _buildComboMPekerjaan() {
    return buildFieldComboMPekerjaan(
      labelText: 'Pekerjaan',
      initItem: fieldComboMPekerjaan,
      onChangedCallback: (value) {
        if (value != null) {
          fieldComboMPekerjaan = value;
          bloc.add(ComboMPekerjaanChangedEvent(comboMPekerjaan: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) fieldComboMPekerjaan = value;
      },
      validatorCallback: (value) {},
      comboKey: GlobalKey<DropdownSearchState<ComboMPekerjaanModel>>(),
    );
  }

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final record = MRekanGeneralIdvCrudModel(
        mjnsclientId: fieldMjnsclientIdController.text,
        mjnskelId: fieldMjnskelIdController.text,
        mpekerjaanId: fieldComboMPekerjaan?.mpekerjaanId,
        mrekan1Id: bloc.state.record?.mrekan1Id ?? '',
        rekanNama: fieldRekanNamaController.text,
      );

      if (widget.viewMode == "tambah") {
        bloc.add(MRekanGeneralIdvCrudTambahEvent(record: record));
      } else {
        bloc.add(MRekanGeneralIdvCrudUbahEvent(record: record));
      }

      Navigator.pop(context);
    }
  }
}
