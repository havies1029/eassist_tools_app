import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanbankcrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekanbankcrud_model.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekan1crud_bloc.dart';

import 'package:eassist_tools_app/models/combobox/combombank_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombank_widget.dart';
import 'package:dropdown_search/dropdown_search.dart';

class RekanBank extends StatefulWidget {
  const RekanBank({super.key});

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

  final comboMBankKey = GlobalKey<DropdownSearchState<ComboMBankModel>>();
  ComboMBankModel? fieldComboMBank;

  bool isEditingSection = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      mRekanBankCrudBloc = context.read<MRekanBankCrudBloc>();
      final rekan1State = context.read<MRekan1CrudBloc>().state;
      final defaultRekanId = rekan1State.record?.mrekan1Id ?? '';
      fieldMrekan1IdController.text = defaultRekanId;

      if (mRekanBankCrudBloc.state.record?.mrekanbankId.isNotEmpty == true) {
        mRekanBankCrudBloc.add(
          MRekanBankCrudLihatEvent(recordId: mRekanBankCrudBloc.state.record!.mrekanbankId),
        );
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
          fieldComboMBank = state.comboMBank;
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
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Informasi Rekening :",
                        style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: Icon(isEditingSection ? Icons.check : Icons.edit),
                      onPressed: () => isEditingSection ? onSaveForm(state) : setState(() => isEditingSection = true),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Tetap disertakan dalam Form, tapi tidak tampil
                Visibility(
                  visible: false,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  child: TextFormField(
                    controller: fieldMrekan1IdController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(), // tetap bergaris bawah
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        addError("ID rekan tidak boleh kosong.");
                        return "";
                      }
                      return null;
                    },
                  ),
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

                _buildLabel("Bank"),
                _buildStyledDropdown(
                  child: isEditingSection
                      ? buildFieldComboMBank(
                    comboKey: comboMBankKey,
                    labelText: "Pilih Bank",
                    initItem: fieldComboMBank,
                    onChangedCallback: (value) {
                      if (value != null) {
                        setState(() => fieldComboMBank = value); // ⬅ penting
                        context.read<MRekanBankCrudBloc>().add(ComboMBankChangedEvent(comboMBank: value));
                        removeError("Bank tidak boleh kosong.");
                      }
                    },
                    onSaveCallback: (value) => fieldComboMBank = value,
                    validatorCallback: (value) {
                      if (value == null) addError("Bank tidak boleh kosong.");
                    },
                  )
                      : _buildDisabledDropdown(fieldComboMBank?.bankNama ?? "Belum diisi"),
                ),

                if (errors.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: errors
                          .map((e) => Text(e, style: const TextStyle(color: Colors.red, fontSize: 12)))
                          .toList(),
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
        hintStyle: const TextStyle(fontFamily: 'Satoshi', fontSize: 14, color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade400)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.blue.shade400)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
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
          if (value != null) {
            setState(() => fieldComboMBank = value as ComboMBankModel?);
          }
        }
    );
  }

  Widget _buildStyledDropdown({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: child,
    );
  }

  Widget _buildDisabledDropdown(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: const TextStyle(fontFamily: 'Satoshi', fontSize: 14, color: Colors.black87)),
    );
  }

  void onSaveForm(MRekanBankCrudState state) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final isNew = state.record == null || state.record!.mrekanbankId.isEmpty;

      final record = MRekanBankCrudModel(
        mrekan1Id: fieldMrekan1IdController.text,
        mrekanbankId: isNew ? "DUMMY-ID-${DateTime.now().millisecondsSinceEpoch}" : state.record!.mrekanbankId,
        rekNama: fieldRekNamaController.text,
        rekNo: fieldRekNoController.text,
        comboMBank: fieldComboMBank,
      );


      mRekanBankCrudBloc.add(MRekanBankCrudUbahEvent(record: record));

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
