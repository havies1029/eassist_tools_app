import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/common/thousand_separator_input_formatter.dart';
import 'package:eassist_tools_app/blocs/profile/rekanbank_bloc.dart';
import 'package:eassist_tools_app/models/profile/rekanbank_model.dart';
import 'package:eassist_tools_app/models/combobox/combombank_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombank_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../inline_error_text.dart';

/// Widget untuk menampilkan alert merah atas section
class SectionErrorAlert extends StatelessWidget {
  final String message;
  const SectionErrorAlert(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.red,
              fontWeight: FontWeight.w500,
              fontFamily: 'Satoshi',
            ),
          ),
        ),
      ],
    );
  }
}

class RekanBankFormBody extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const RekanBankFormBody({
    Key? key,
    required this.viewMode,
    required this.recordId,
  }) : super(key: key);

  @override
  _RekanBankFormBodyState createState() => _RekanBankFormBodyState();
}

class _RekanBankFormBodyState extends State<RekanBankFormBody> {
  late RekanBankBloc rekanBankBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  ComboMBankModel? fieldComboMBank;
  final comboMBankKey = GlobalKey<DropdownSearchState<ComboMBankModel>>();
  final TextEditingController fieldMrekan1IdController = TextEditingController();
  final TextEditingController fieldRekNamaController = TextEditingController();
  final TextEditingController fieldRekNoController = TextEditingController();

  bool isEditingSection = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), _loadData);
  }

  @override
  void dispose() {
    fieldMrekan1IdController.dispose();
    fieldRekNamaController.dispose();
    fieldRekNoController.dispose();
    super.dispose();
  }

  void _loadData() {
    if (widget.viewMode == "ubah") {
      rekanBankBloc.add(
        RekanBankLihatEvent(recordId: widget.recordId),
      );
    }
  }

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

  void _onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final record = RekanBankModel(
        mbankId: fieldComboMBank?.mbankId,
        mrekan1Id: fieldMrekan1IdController.text,
        mrekanbankId: '',
        rekNama: fieldRekNamaController.text,
        rekNo: fieldRekNoController.text,
      );

      if (widget.viewMode == "tambah") {
        rekanBankBloc.add(RekanBankTambahEvent(record: record));
      } else {
        record.mrekanbankId = rekanBankBloc.state.record!.mrekanbankId;
        rekanBankBloc.add(RekanBankUbahEvent(record: record));
      }

      setState(() {
        isEditingSection = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Data bank berhasil disimpan',
            style: TextStyle(fontFamily: 'Satoshi'),
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Widget _buildLabelText(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Satoshi',
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildStyledTextField({
    required TextEditingController controller,
    String? hintText,
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
      style: const TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 14,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }

  Widget _buildStyledDropdown({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: DefaultTextStyle(
        style: const TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 14,
        ),
        child: child,
      ),
    );
  }

  Widget buildFieldMbankId() {
    return buildFieldComboMBank(
      comboKey: comboMBankKey,
      labelText: 'mbankId',
      initItem: fieldComboMBank,
      onChangedCallback: (value) {
        if (value != null) {
          _removeError("Field Bank tidak boleh kosong.");
          rekanBankBloc.add(ComboMBankChangedEvent(comboMBank: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboMBank = value;
        }
      },
      validatorCallback: (value) {
        if (value == null) {
          _addError("Field Bank tidak boleh kosong.");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    rekanBankBloc = BlocProvider.of<RekanBankBloc>(context);

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Judul + tombol edit
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.viewMode == "tambah"
                          ? "Tambah Informasi Bank"
                          : "Ubah Informasi Bank",
                      style: const TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isEditingSection ? Icons.check : Icons.edit,
                      color: Colors.black,
                    ),
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

              // Alert Merah Validasi Section
              if (errors.isNotEmpty && isEditingSection)
                const SectionErrorAlert(
                  'Lengkapi data berikut untuk proses verifikasi dan transaksi.',
                ),
              if (errors.isNotEmpty && isEditingSection)
                const SizedBox(height: 16),

              _buildLabelText('Bank'),
              const SizedBox(height: 6),
              isEditingSection
                  ? _buildStyledDropdown(child: buildFieldMbankId())
                  : Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  fieldComboMBank?.mbankId ?? "-",
                  style: const TextStyle(
                    fontFamily: 'Satoshi',
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              const SizedBox(height: 12),

              _buildLabelText('ID Rekanan'),
              const SizedBox(height: 6),
              _buildStyledTextField(
                controller: fieldMrekan1IdController,
                hintText: 'Masukkan ID Rekanan',
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

              _buildLabelText('Nama Rekening'),
              const SizedBox(height: 6),
              _buildStyledTextField(
                controller: fieldRekNamaController,
                hintText: 'Masukkan Nama Rekening',
                maxLines: 3,
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

              _buildLabelText('Nomor Rekening'),
              const SizedBox(height: 6),
              _buildStyledTextField(
                controller: fieldRekNoController,
                hintText: 'Masukkan Nomor Rekening',
                keyboardType: TextInputType.number,
                inputFormatters: [ThousandsSeparatorInputFormatter()],
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
            ],
          ),
        ),
      ),
    );
  }
}