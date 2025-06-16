import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanbankcrud_bloc.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekanbankcrud_model.dart';

class MRekanBankFormBody extends StatefulWidget {
  final String viewMode;
  final String recordId;

  const MRekanBankFormBody({
    Key? key,
    required this.viewMode,
    required this.recordId,
  }) : super(key: key);

  @override
  State<MRekanBankFormBody> createState() => _MRekanBankFormBodyState();
}

class _MRekanBankFormBodyState extends State<MRekanBankFormBody> {
  final _formKey = GlobalKey<FormState>();
  late MRekanBankCrudBloc bloc;

  final TextEditingController fieldMrekan1IdController = TextEditingController();
  final TextEditingController fieldRekNamaController = TextEditingController();
  final TextEditingController fieldRekNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (widget.viewMode == "ubah") {
        bloc.add(MRekanBankCrudLihatEvent(recordId: widget.recordId));
      }
    });
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
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildLabelText("ID Rekan"),
              const SizedBox(height: 6),
              _buildTextField(
                controller: fieldMrekan1IdController,
                hintText: "Masukkan ID rekan",
              ),
              const SizedBox(height: 12),

              _buildLabelText("Nama Rekening"),
              const SizedBox(height: 6),
              _buildTextField(
                controller: fieldRekNamaController,
                hintText: "Masukkan nama pemilik rekening",
                keyboardType: TextInputType.name,
                maxLines: 2,
              ),
              const SizedBox(height: 12),

              _buildLabelText("No. Rekening"),
              const SizedBox(height: 6),
              _buildTextField(
                controller: fieldRekNoController,
                hintText: "Masukkan nomor rekening",
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
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

  void onSaveForm() {
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
}
