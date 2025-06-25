import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanbankcrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekanbankcrud_model.dart';

class RekanBank extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const RekanBank({
    super.key,
    required this.viewMode,
    required this.recordId,
  });

  @override
  RekanBankState createState() => RekanBankState();
}

class RekanBankState extends State<RekanBank> {
  late MRekanBankCrudBloc mRekanBankCrudBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  final fieldMrekan1IdController = TextEditingController();
  final fieldRekNamaController = TextEditingController();
  final fieldRekNoController = TextEditingController();

  bool isEditingSection = false;

  @override
  void initState() {
    super.initState();
    // Set initial editing state based on viewMode
    isEditingSection = false; // selalu read only

    Future.delayed(Duration.zero, () {
      mRekanBankCrudBloc = BlocProvider.of<MRekanBankCrudBloc>(context);
      if (widget.viewMode == "ubah") {
        mRekanBankCrudBloc.add(
            MRekanBankCrudLihatEvent(recordId: widget.recordId));
      }
    });
  }

  @override
  void dispose() {
    fieldMrekan1IdController.dispose();
    fieldRekNamaController.dispose();
    fieldRekNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MRekanBankCrudBloc, MRekanBankCrudState>(
      listener: (context, state) {
        if (state.isLoaded && state.record != null) {
          fieldMrekan1IdController.text = state.record!.mrekan1Id;
          fieldRekNamaController.text = state.record!.rekNama;
          fieldRekNoController.text = state.record!.rekNo;
        }
      },
      builder: (context, state) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with title and edit button
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                          "Informasi Rekening :",
                          style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold)
                      ),
                    ),
                    IconButton(
                      icon: Icon(isEditingSection ? Icons.check : Icons.edit),
                      onPressed: () => isEditingSection ? onSaveForm() : setState(() => isEditingSection = true),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                _buildLabel("ID Rekan"),
                _buildTextField(
                  controller: fieldMrekan1IdController,
                  hintText: "Masukkan ID rekan",
                  errorKey: "ID rekan tidak boleh kosong.",
                ),

                _buildLabel("Nama Rekening"),
                _buildTextField(
                  controller: fieldRekNamaController,
                  hintText: "Masukkan nama pemilik rekening",
                  maxLines: 2,
                  errorKey: "Nama rekening tidak boleh kosong.",
                ),

                _buildLabel("No. Rekening"),
                _buildTextField(
                  controller: fieldRekNoController,
                  hintText: "Masukkan nomor rekening",
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  errorKey: "Nomor rekening tidak boleh kosong.",
                ),

                // Error messages
                if (errors.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: errors.map((e) => Text(
                          e,
                          style: const TextStyle(color: Colors.red, fontSize: 12)
                      )).toList(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
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
        hintStyle: const TextStyle(
            fontFamily: 'Satoshi',
            fontSize: 14,
            color: Colors.grey
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade400)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.blue.shade400)
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300)
        ),
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

  void onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final record = MRekanBankCrudModel(
        mrekan1Id: fieldMrekan1IdController.text,
        mrekanbankId: widget.viewMode == "ubah"
            ? mRekanBankCrudBloc.state.record!.mrekanbankId
            : '',
        rekNama: fieldRekNamaController.text,
        rekNo: fieldRekNoController.text,
      );

      if (widget.viewMode == "tambah") {
        mRekanBankCrudBloc.add(MRekanBankCrudTambahEvent(record: record));
      } else {
        mRekanBankCrudBloc.add(MRekanBankCrudUbahEvent(record: record));
      }

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