import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanbankcrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekanbankcrud_model.dart';

class RekanBankIdv extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const RekanBankIdv({
    Key? key,
    required this.viewMode,
    required this.recordId,
  }) : super(key: key);

  @override
  State<RekanBankIdv> createState() => _RekanBankIdvState();
}

class _RekanBankIdvState extends State<RekanBankIdv> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _errors = [];
  late MRekanBankCrudBloc bloc;

  final TextEditingController fieldMrekan1IdController = TextEditingController();
  final TextEditingController fieldRekNamaController = TextEditingController();
  final TextEditingController fieldRekNoController = TextEditingController();

  bool isEditing = true;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<MRekanBankCrudBloc>(context); // ✅ inisialisasi lebih awal

    Future.delayed(Duration.zero, () {
      if (widget.viewMode == "ubah") {
        setState(() {
          isEditing = false;
        });
        bloc.add(MRekanBankCrudLihatEvent(recordId: widget.recordId));
      }
    });
  }

  @override
  void dispose() {
    super.dispose(); // Controller dikelola di luar jika ingin modular
  }

  void _addError(String error) {
    if (!_errors.contains(error)) {
      setState(() {
        _errors.add(error);
      });
    }
  }

  void _removeError(String error) {
    if (_errors.contains(error)) {
      setState(() {
        _errors.remove(error);
      });
    }
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final record = MRekanBankCrudModel(
        mrekan1Id: fieldMrekan1IdController.text,
        rekNama: fieldRekNamaController.text,
        rekNo: fieldRekNoController.text,
        mrekanbankId: bloc.state.record?.mrekanbankId ?? '',
      );

      if (widget.viewMode == "tambah") {
        bloc.add(MRekanBankCrudTambahEvent(record: record));
      } else {
        bloc.add(MRekanBankCrudUbahEvent(record: record));
      }

      Navigator.pop(context);
    }
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
    int maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: !isEditing,
      keyboardType: keyboardType,
      maxLines: maxLines,
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
      style: const TextStyle(fontSize: 16),
      validator: validator,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<MRekanBankCrudBloc>(context);

    return BlocListener<MRekanBankCrudBloc, MRekanBankCrudState>(
      listener: (context, state) {
        if (state.isLoaded && state.record != null) {
          fieldMrekan1IdController.text = state.record!.mrekan1Id;
          fieldRekNamaController.text = state.record!.rekNama;
          fieldRekNoController.text = state.record!.rekNo;
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header + Tombol Edit/Check
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Informasi Rekening Bank",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Icon(isEditing ? Icons.check : Icons.edit),
                    onPressed: () {
                      if (isEditing) {
                        _onSave();
                      } else {
                        setState(() => isEditing = true);
                      }
                    },
                  )
                ],
              ),
              const SizedBox(height: 12),
              FormError(errors: _errors, key: null),

              // ID Rekan
              _buildLabelText("ID Rekan"),
              const SizedBox(height: 6),
              _buildStyledTextField(
                controller: fieldMrekan1IdController,
                hintText: "Masukkan ID rekan",
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

              // Nama Rekening
              _buildLabelText("Nama Rekening"),
              const SizedBox(height: 6),
              _buildStyledTextField(
                controller: fieldRekNamaController,
                hintText: "Masukkan nama pemilik rekening",
                keyboardType: TextInputType.name,
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

              // No. Rekening
              _buildLabelText("No. Rekening"),
              const SizedBox(height: 6),
              _buildStyledTextField(
                controller: fieldRekNoController,
                hintText: "Masukkan nomor rekening",
                keyboardType: TextInputType.number,
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
            ],
          ),
        ),
      ),
    );
  }
}