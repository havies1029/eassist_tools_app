import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/blocs/profile/rekangeneral_bloc.dart';
import 'package:eassist_tools_app/models/profile/rekangeneral_model.dart';
import 'package:eassist_tools_app/models/combobox/combombentukcst_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombentukcst_widget.dart';
import 'package:eassist_tools_app/models/combobox/combombidang_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combombidang_widget.dart';
import 'package:eassist_tools_app/models/combobox/combomtipecst_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomtipecst_widget.dart';
import 'package:eassist_tools_app/models/combobox/combomtitle_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomtitle_widget.dart';
import '../../inline_error_text.dart';


/// Widget yang hanya berisi “body” form General Information (tanpa Dialog).
class RekanGeneralFormBody extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const RekanGeneralFormBody({
    Key? key,
    required this.viewMode,
    required this.recordId,
  }) : super(key: key);

  @override
  _RekanGeneralFormBodyState createState() => _RekanGeneralFormBodyState();
}

class _RekanGeneralFormBodyState extends State<RekanGeneralFormBody> {
  late RekanGeneralBloc rekanGeneralBloc;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  // Dropdown models
  ComboMBentukCstModel? fieldComboMBentukCst;
  ComboMBidangModel? fieldComboMBidang;
  ComboMTipeCstModel? fieldComboMTipeCst;
  ComboMTitleModel? fieldComboMTitle;

  // Text controller
  final TextEditingController fieldRekanNamaController =
  TextEditingController();

  // Edit mode flag
  bool isEditingSection = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      _loadData();
    });
  }

  @override
  void dispose() {
    fieldRekanNamaController.dispose();
    super.dispose();
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

  void _loadData() {
    if (widget.viewMode == "ubah") {
      rekanGeneralBloc.add(
        RekanGeneralLihatEvent(recordId: widget.recordId),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    rekanGeneralBloc = BlocProvider.of<RekanGeneralBloc>(context);

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
                    widget.viewMode == "tambah"
                        ? "Tambah General Information"
                        : "Ubah General Information",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(isEditingSection ? Icons.check : Icons.edit),
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

            // Error alert
            if (errors.isNotEmpty)
              const InlineErrorText("Silakan lengkapi semua kolom wajib."),
            const SizedBox(height: 8),

            // Dropdown: Bentuk Customer
            _buildLabelText('Bentuk Customer'),
            const SizedBox(height: 6),
            _buildStyledDropdown(child: buildFieldMbentukcstId()),
            const SizedBox(height: 12),

            // Dropdown: Bidang
            _buildLabelText('Bidang'),
            const SizedBox(height: 6),
            _buildStyledDropdown(child: buildFieldMbidangId()),
            const SizedBox(height: 12),

            // Dropdown: Tipe Customer
            _buildLabelText('Tipe Customer'),
            const SizedBox(height: 6),
            _buildStyledDropdown(child: buildFieldMtipecstId()),
            const SizedBox(height: 12),

            // Dropdown: Title
            _buildLabelText('Title'),
            const SizedBox(height: 6),
            _buildStyledDropdown(child: buildFieldMtitleId()),
            const SizedBox(height: 12),

            // Field: Nama Rekan
            _buildLabelText('Nama Rekan'),
            const SizedBox(height: 6),
            _buildStyledTextField(
              controller: fieldRekanNamaController,
              hintText: 'Masukkan nama rekan',
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

  // Helper: Label
  Widget _buildLabelText(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  // Helper: TextField style Outline
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
      readOnly: !isEditingSection,
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
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }

  // Helper: Dropdown style Outline
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

  // Simpan form (trigger Bloc event)
  void _onSaveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final record = RekanGeneralModel(
        mbentukcstId: fieldComboMBentukCst?.mbentukcstId,
        mbidangId: fieldComboMBidang?.mbidangId,
        mrekan1Id: '',
        mtipecstId: fieldComboMTipeCst?.mtipecustId,
        mtitleId: fieldComboMTitle?.mtitleId,
        rekanNama: fieldRekanNamaController.text,
      );

      if (widget.viewMode == "tambah") {
        rekanGeneralBloc.add(RekanGeneralTambahEvent(record: record));
      } else {
        record.mrekan1Id = rekanGeneralBloc.state.record!.mrekan1Id;
        rekanGeneralBloc.add(RekanGeneralUbahEvent(record: record));
      }

      setState(() {
        isEditingSection = false;
      });
    }
  }

  // Tambah/hapus error
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

  Widget buildFieldMbentukcstId() {
    return isEditingSection
        ? buildFieldComboMBentukCst(
      labelText: 'mbentukcstId',
      initItem: fieldComboMBentukCst,
      onChangedCallback: (value) {
        if (value != null) {
          _removeError("Field ComboMBentukCst tidak boleh kosong.");
          rekanGeneralBloc.add(ComboMBentukCstChangedEvent(comboMBentukCst: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) fieldComboMBentukCst = value;
      },
      validatorCallback: (value) {
        if (value == null) _addError("Field ComboMBentukCst tidak boleh kosong.");
      },
    )
        : _buildDisabledDropdown(
      text: fieldComboMBentukCst?.bentukNama ?? '-',
    );
  }


  Widget buildFieldMbidangId() {
    return isEditingSection
        ? buildFieldComboMBidang(
      labelText: 'mbidangId',
      initItem: fieldComboMBidang,
      onChangedCallback: (value) {
        if (value != null) {
          _removeError("Field ComboMBidang tidak boleh kosong.");
          rekanGeneralBloc.add(ComboMBidangChangedEvent(comboMBidang: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboMBidang = value;
        }
      },
      validatorCallback: (value) {
        if (value == null) {
          _addError("Field ComboMBidang tidak boleh kosong.");
        }
      },
    )
        : _buildDisabledDropdown(
      text: fieldComboMBidang?.bidangNama ?? '-',
    );
  }

  Widget buildFieldMtipecstId() {
    return isEditingSection
        ? buildFieldComboMTipeCst(
      labelText: 'mtipecstId',
      initItem: fieldComboMTipeCst,
      onChangedCallback: (value) {
        if (value != null) {
          _removeError("Field ComboMTipeCst tidak boleh kosong.");
          rekanGeneralBloc.add(ComboMTipeCstChangedEvent(comboMTipeCst: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboMTipeCst = value;
        }
      },
      validatorCallback: (value) {
        if (value == null) {
          _addError("Field ComboMTipeCst tidak boleh kosong.");
        }
      },
    )
        : _buildDisabledDropdown(
      text: fieldComboMTipeCst?.tipeNama ?? '-',
    );
  }

  Widget buildFieldMtitleId() {
    return isEditingSection
        ? buildFieldComboMTitle(
      labelText: 'mtitleId',
      initItem: fieldComboMTitle,
      onChangedCallback: (value) {
        if (value != null) {
          _removeError("Field ComboMTitle tidak boleh kosong.");
          rekanGeneralBloc.add(ComboMTitleChangedEvent(comboMTitle: value));
        }
      },
      onSaveCallback: (value) {
        if (value != null) {
          fieldComboMTitle = value;
        }
      },
      validatorCallback: (value) {
        if (value == null) {
          _addError("Field ComboMTitle tidak boleh kosong.");
        }
      },
    )
        : _buildDisabledDropdown(
      text: fieldComboMTitle?.titleDesc ?? '-',
    );
  }
}
