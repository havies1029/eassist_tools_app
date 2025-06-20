import 'package:eassist_tools_app/widgets/checkbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpiccrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekanpiccrud_model.dart';
import 'package:eassist_tools_app/models/combobox/combomjabatan_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomjabatan_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';

class MRekanPicCrudFormBody extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const MRekanPicCrudFormBody({
    super.key,
    this.viewMode = 'tambah',
    this.recordId = '',
  });

  @override
  State<MRekanPicCrudFormBody> createState() => _MRekanPicCrudFormBodyState();
}

class _MRekanPicCrudFormBodyState extends State<MRekanPicCrudFormBody> {
  late MRekanPicCrudBloc bloc;
  final _formKey = GlobalKey<FormState>();

  final fieldPicEmailController = TextEditingController();
  final fieldPicHpController = TextEditingController();
  final fieldPicNamaController = TextEditingController();

  final comboMJabatanKey = GlobalKey<DropdownSearchState<ComboMJabatanModel>>();
  ComboMJabatanModel? fieldComboMJabatan;
  bool isDefaultChecked = false;

  final TextStyle labelStyle = const TextStyle(fontWeight: FontWeight.w500);
  final TextStyle hintStyle = TextStyle(
    fontFamily: 'Satoshi',
    fontSize: 14,
    color: Colors.grey.shade600,
  );
  final TextStyle textStyle = const TextStyle(
    fontFamily: 'Satoshi',
    fontSize: 14,
  );

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<MRekanPicCrudBloc>(context);

    Future.delayed(Duration.zero, () {
      if (widget.viewMode == 'ubah' && widget.recordId.isNotEmpty) {
        bloc.add(MRekanPicCrudLihatEvent(recordId: widget.recordId));
      } else {
        clearAllFields();
      }
    });
  }

  void clearAllFields() {
    fieldPicEmailController.clear();
    fieldPicHpController.clear();
    fieldPicNamaController.clear();
    fieldComboMJabatan = null;
    isDefaultChecked = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MRekanPicCrudBloc, MRekanPicCrudState>(
      listener: (context, state) {
        if (state.isLoaded && state.record != null && widget.viewMode == 'ubah') {
          final record = state.record!;
          setState(() {
            isDefaultChecked = record.isDefault ?? false;
            fieldPicEmailController.text = record.picEmail ?? '';
            fieldPicHpController.text = record.picHp ?? '';
            fieldPicNamaController.text = record.picNama ?? '';
            fieldComboMJabatan = state.comboMJabatan;
          });
        }
      },
      child: BlocBuilder<MRekanPicCrudBloc, MRekanPicCrudState>(
        builder: (context, state) {
          if (!state.isLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          return Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Informasi PIC",
                          style: TextStyle(
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: onSaveForm,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  _buildLabelText("Nama PIC"),
                  const SizedBox(height: 6),
                  _buildStyledTextField(
                    controller: fieldPicNamaController,
                    hintText: "Masukkan nama",
                  ),

                  const SizedBox(height: 12),
                  _buildLabelText("Email PIC"),
                  const SizedBox(height: 6),
                  _buildStyledTextField(
                    controller: fieldPicEmailController,
                    hintText: "Masukkan email",
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 12),
                  _buildLabelText("No. HP PIC"),
                  const SizedBox(height: 6),
                  _buildStyledTextField(
                    controller: fieldPicHpController,
                    hintText: "Masukkan nomor HP",
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 12),
                  _buildLabelText("Jabatan"),
                  const SizedBox(height: 6),
                  _buildStyledDropdown(child: _buildFieldComboMJabatan()),

                  const SizedBox(height: 12),
                  _buildLabelText("Default PIC"),
                  const SizedBox(height: 6),
                  CheckboxWidget(
                    leftLabel: "",
                    rightLabel: "Default",
                    initialValue: isDefaultChecked,
                    callback: (value) {
                      setState(() => isDefaultChecked = value);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Label
  Widget _buildLabelText(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: labelStyle),
    );
  }

  // Input TextField
  Widget _buildStyledTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: textStyle,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      validator: (value) => value == null || value.trim().isEmpty
          ? 'Field tidak boleh kosong'
          : null,
    );
  }

  // Dropdown Wrapper
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

  // Dropdown Jabatan
  Widget _buildFieldComboMJabatan() {
    return FormField<ComboMJabatanModel>(
      validator: (value) {
        if (fieldComboMJabatan == null) return 'Jabatan harus dipilih';
        return null;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildFieldComboMJabatan(
              comboKey: comboMJabatanKey,
              labelText: 'Pilih Jabatan',
              initItem: fieldComboMJabatan,
              onChangedCallback: (value) {
                setState(() => fieldComboMJabatan = value);
                state.didChange(value);
              },
              onSaveCallback: (value) => fieldComboMJabatan = value,
              validatorCallback: (_) {},
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }

  // Simpan Form
  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final isTambah = widget.viewMode == "tambah";

      final record = MRekanPicCrudModel(
        isDefault: isDefaultChecked,
        mjabatanId: fieldComboMJabatan?.mjabatanId,
        mrekanpicId: isTambah ? '' : (bloc.state.record?.mrekanpicId ?? ''),
        picEmail: fieldPicEmailController.text,
        picHp: fieldPicHpController.text,
        picNama: fieldPicNamaController.text,
      );

      if (isTambah) {
        bloc.add(MRekanPicCrudTambahEvent(record: record));
      } else {
        bloc.add(MRekanPicCrudUbahEvent(record: record));
      }
    }
  }
}
