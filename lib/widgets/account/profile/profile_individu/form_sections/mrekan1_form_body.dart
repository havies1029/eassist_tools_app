// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:eassist_tools_app/common/constants.dart';
// import 'package:eassist_tools_app/blocs/gen_profile/mrekan1crud_bloc.dart';
// import 'package:eassist_tools_app/models/gen_profile/mrekan1crud_model.dart';
// import 'package:eassist_tools_app/models/combobox/combombentukcst_model.dart';
// import 'package:eassist_tools_app/models/combobox/combombidang_model.dart';
// import 'package:eassist_tools_app/models/combobox/combomjnsclient_model.dart';
// import 'package:eassist_tools_app/models/combobox/combomjnskel_model.dart';
// import 'package:eassist_tools_app/models/combobox/combompekerjaan_model.dart';
// import 'package:eassist_tools_app/models/combobox/combomtitle_model.dart';
// import 'package:eassist_tools_app/widgets/combobox/combombentukcst_widget.dart';
// import 'package:eassist_tools_app/widgets/combobox/combombidang_widget.dart';
// import 'package:eassist_tools_app/widgets/combobox/combomjnsclient_widget.dart';
// import 'package:eassist_tools_app/widgets/combobox/combomjnskel_widget.dart';
// import 'package:eassist_tools_app/widgets/combobox/combompekerjaan_widget.dart';
// import 'package:eassist_tools_app/widgets/combobox/combomtitle_widget.dart';
//
// class MRekan1FormBody extends StatefulWidget {
//   final String viewMode;
//   final String recordId;
//
//   const MRekan1FormBody({
//     super.key,
//     required this.viewMode,
//     required this.recordId,
//   });
//
//   @override
//   State<MRekan1FormBody> createState() => _MRekan1FormBodyState();
// }
//
// class _MRekan1FormBodyState extends State<MRekan1FormBody> {
//   final _formKey = GlobalKey<FormState>();
//   late MRekan1CrudBloc bloc;
//
//   final TextEditingController fieldRekanNamaController = TextEditingController();
//
//   ComboMBentukCstModel? fieldComboMBentukCst;
//   ComboMBidangModel? fieldComboMBidang;
//   ComboMJnsclientModel? fieldComboMJnsclient;
//   ComboMJnskelModel? fieldComboMJnskel;
//   ComboMPekerjaanModel? fieldComboMPekerjaan;
//   ComboMTitleModel? fieldComboMTitle;
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () {
//       if (widget.viewMode == "ubah") {
//         bloc.add(MRekan1CrudLihatEvent(recordId: widget.recordId));
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     bloc = BlocProvider.of<MRekan1CrudBloc>(context);
//
//     return BlocListener<MRekan1CrudBloc, MRekan1CrudState>(
//       listener: (context, state) {
//         if (state.isLoaded && state.record != null) {
//           final r = state.record!;
//           fieldRekanNamaController.text = r.rekanNama;
//           fieldComboMBentukCst = state.comboMBentukCst;
//           fieldComboMBidang = state.comboMBidang;
//           fieldComboMJnsclient = state.comboMJnsclient;
//           fieldComboMJnskel = state.comboMJnskel;
//           fieldComboMPekerjaan = state.comboMPekerjaan;
//           fieldComboMTitle = state.comboMTitle;
//         }
//       },
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         color: Colors.white,
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _buildLabel("Nama Rekan"),
//               _buildTextField(controller: fieldRekanNamaController, hint: "Nama Rekan"),
//               const SizedBox(height: 12),
//
//               _buildLabel("Bentuk Usaha"),
//               _buildDropdown(() => buildFieldComboMBentukCst(
//                 comboKey: null,
//                 labelText: 'Bentuk Usaha',
//                 initItem: fieldComboMBentukCst ?? ComboMBentukCstModel(),
//                 onChangedCallback: (value) {
//                   fieldComboMBentukCst = value;
//                   bloc.add(ComboMBentukCstChangedEvent(comboMBentukCst: value));
//                 },
//                 onSaveCallback: (value) => fieldComboMBentukCst = value,
//                 validatorCallback: (_) {},
//               )),
//               const SizedBox(height: 12),
//
//               _buildLabel("Bidang"),
//               _buildDropdown(() => buildFieldComboMBidang(
//                 comboKey: null,
//                 labelText: 'Bidang',
//                 initItem: fieldComboMBidang ?? ComboMBidangModel(),
//                 onChangedCallback: (value) {
//                   fieldComboMBidang = value;
//                   bloc.add(ComboMBidangChangedEvent(comboMBidang: value));
//                 },
//                 onSaveCallback: (value) => fieldComboMBidang = value,
//                 validatorCallback: (_) {},
//               )),
//               const SizedBox(height: 12),
//
//               _buildLabel("Jenis Client"),
//               _buildDropdown(() => buildFieldComboMJnsclient(
//                 comboKey: null,
//                 labelText: 'Jenis Client',
//                 initItem: fieldComboMJnsclient ?? ComboMJnsclientModel(),
//                 onChangedCallback: (value) {
//                   fieldComboMJnsclient = value;
//                   bloc.add(ComboMJnsclientChangedEvent(comboMJnsclient: value));
//                 },
//                 onSaveCallback: (value) => fieldComboMJnsclient = value,
//                 validatorCallback: (_) {},
//               )),
//               const SizedBox(height: 12),
//
//               _buildLabel("Jenis Kelamin"),
//               _buildDropdown(() => buildFieldComboMJnskel(
//                 comboKey: null,
//                 labelText: 'Jenis Kelamin',
//                 initItem: fieldComboMJnskel ?? ComboMJnskelModel(),
//                 onChangedCallback: (value) {
//                   fieldComboMJnskel = value;
//                   bloc.add(ComboMJnskelChangedEvent(comboMJnskel: value));
//                 },
//                 onSaveCallback: (value) => fieldComboMJnskel = value,
//                 validatorCallback: (_) {},
//               )),
//               const SizedBox(height: 12),
//
//               _buildLabel("Pekerjaan"),
//               _buildDropdown(() => buildFieldComboMPekerjaan(
//                 comboKey: null,
//                 labelText: 'Pekerjaan',
//                 initItem: fieldComboMPekerjaan ?? ComboMPekerjaanModel(),
//                 onChangedCallback: (value) {
//                   fieldComboMPekerjaan = value;
//                   bloc.add(ComboMPekerjaanChangedEvent(comboMPekerjaan: value));
//                 },
//                 onSaveCallback: (value) => fieldComboMPekerjaan = value,
//                 validatorCallback: (_) {},
//               )),
//               const SizedBox(height: 12),
//
//               _buildLabel("Title"),
//               _buildDropdown(() => buildFieldComboMTitle(
//                 comboKey: null,
//                 labelText: 'Title',
//                 initItem: fieldComboMTitle ?? ComboMTitleModel(),
//                 onChangedCallback: (value) {
//                   fieldComboMTitle = value;
//                   bloc.add(ComboMTitleChangedEvent(comboMTitle: value));
//                 },
//                 onSaveCallback: (value) => fieldComboMTitle = value,
//                 validatorCallback: (_) {},
//               )),
//               const SizedBox(height: 16),
//
//               ElevatedButton(onPressed: _onSave, child: const Text("Simpan")),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLabel(String text) {
//     return Text(text, style: const TextStyle(fontWeight: FontWeight.w600));
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hint,
//   }) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hint,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) return 'Tidak boleh kosong';
//         return null;
//       },
//     );
//   }
//
//   Widget _buildDropdown(Widget Function() builder) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade400),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//       child: builder(),
//     );
//   }
//
//   void _onSave() {
//     if (_formKey.currentState!.validate()) {
//       final record = MRekan1CrudModel(
//         rekanNama: fieldRekanNamaController.text,
//         mrekan1Id: widget.viewMode == 'ubah' ? bloc.state.record?.mrekan1Id ?? '' : '',
//         mbentukcstId: fieldComboMBentukCst?.mbentukcstId,
//         mbidangId: fieldComboMBidang?.mbidangId,
//         mjnsclientId: fieldComboMJnsclient?.mjnsclientId,
//         mjnskelId: fieldComboMJnskel?.mjnskelId,
//         mpekerjaanId: fieldComboMPekerjaan?.mpekerjaanId,
//         mtitleId: fieldComboMTitle?.mtitleId,
//       );
//
//       if (widget.viewMode == "tambah") {
//         bloc.add(MRekan1CrudTambahEvent(record: record));
//       } else {
//         bloc.add(MRekan1CrudUbahEvent(record: record));
//       }
//
//       Navigator.pop(context);
//     }
//   }
// }
