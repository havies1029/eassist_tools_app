// lib/widgets/form_sections/rekan_pic_form_body.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';

/// Widget yang hanya berisi “body” form Informasi PIC (tanpa Dialog).
class RekanPICFormBody extends StatefulWidget {
  final bool isEditing;
  final Map<String, TextEditingController> controllers;
  final void Function(String sectionKey) toggleEdit;

  const RekanPICFormBody({
    Key? key,
    required this.isEditing,
    required this.controllers,
    required this.toggleEdit,
  }) : super(key: key);

  @override
  _RekanPICFormBodyState createState() => _RekanPICFormBodyState();
}

class _RekanPICFormBodyState extends State<RekanPICFormBody> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _errors = [];

  @override
  void initState() {
    super.initState();
    // Pastikan semua controller sudah ada, termasuk "isDefault" meski tidak ditampilkan
    widget.controllers.putIfAbsent("picNama", () => TextEditingController());
    widget.controllers.putIfAbsent("picEmail", () => TextEditingController());
    widget.controllers.putIfAbsent("picHp", () => TextEditingController());
    widget.controllers.putIfAbsent("mjabatanId", () => TextEditingController());
    widget.controllers.putIfAbsent("isDefault", () => TextEditingController());
  }

  @override
  void dispose() {
    // Jangan dispose controller karena dimiliki parent
    super.dispose();
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
      widget.toggleEdit("Informasi PIC");
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
    TextAlign textAlign = TextAlign.start,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: !widget.isEditing,
      keyboardType: keyboardType,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      textAlign: textAlign,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 14,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      style: const TextStyle(fontSize: 16),
      validator: validator,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    "Informasi PIC",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon:
                  Icon(widget.isEditing ? Icons.check : Icons.edit),
                  onPressed: () {
                    if (widget.isEditing) {
                      _onSave();
                    } else {
                      widget.toggleEdit("Informasi PIC");
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Daftar error
            FormError(errors: _errors, key: null),
            // 1) Nama PIC
            _buildLabelText('Nama PIC'),
            const SizedBox(height: 6),
            _buildStyledTextField(
              controller: widget.controllers["picNama"]!,
              hintText: 'Masukkan Nama PIC',
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

            // 2) Email PIC
            _buildLabelText('Email PIC'),
            const SizedBox(height: 6),
            _buildStyledTextField(
              controller: widget.controllers["picEmail"]!,
              hintText: 'Masukkan Email PIC',
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

            // 3) No. HP PIC
            _buildLabelText('No. HP PIC'),
            const SizedBox(height: 6),
            _buildStyledTextField(
              controller: widget.controllers["picHp"]!,
              hintText: 'Masukkan No. HP PIC',
              keyboardType: TextInputType.phone,
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

            // 4) Jabatan PIC
            _buildLabelText('Jabatan PIC'),
            const SizedBox(height: 6),
            _buildStyledTextField(
              controller: widget.controllers["mjabatanId"]!,
              hintText: 'Masukkan Jabatan PIC',
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
