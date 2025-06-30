import 'package:eassist_tools_app/blocs/reguser/reguser_bloc.dart';
import 'package:eassist_tools_app/widgets/account/login/login_gmail/Base_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/app_data.dart';
import '../../../../models/reguser/reguser_model.dart';
import 'package:eassist_tools_app/models/combobox/combomjnsclient_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomjnsclient_widget.dart';
class RegisterClientDialog extends BaseDialog {
  const RegisterClientDialog({super.key});

  @override
  State<RegisterClientDialog> createState() => _RegisterClientDialogState();
}

class _RegisterClientDialogState extends BaseDialogState<RegisterClientDialog> {
  final _nameController = TextEditingController();
  final hpController = TextEditingController();
  final pswdController = TextEditingController();
  final confirmPswdController = TextEditingController();
  ComboMJnsclientModel? fieldComboJnsClient;
  String _selectedChoice = '';
  bool _isHovering = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    hpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildDialogContainer(
      title: 'Daftar Klien',
      body: BlocConsumer<RegUserBloc, RegUserState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  buildLogo(),
                  const SizedBox(height: 30),

                  // Input Nama
                  buildTextField(
                    controller: _nameController,
                    hintText: 'Nama Lengkap',
                  ),
                  const SizedBox(height: 20),

                  // Input HP
                  TextFormField(
                    controller: hpController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          SizedBox(width: 15),
                          Text(
                            '+62',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 5),
                        ],
                      ),
                      hintText: '8xxxxxxx',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nomor HP wajib diisi';
                      }
                      if (!RegExp(r'^8[0-9]{8,12}$').hasMatch(value)) {
                        return 'Format nomor harus diawali 8 dan panjang 9-13 digit';
                      }
                      return null;
                    },
                    onTap: () {
                      // Jika kosong, otomatis isi awalan 8
                      if (hpController.text.isEmpty) {
                        hpController.text = '8';
                        hpController.selection = TextSelection.fromPosition(
                          TextPosition(offset: hpController.text.length),
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 20),

                  // Input pswd
                  buildTextField(
                    controller: pswdController,
                    hintText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 20),

                  // Input confirm pswd
                  buildTextField(
                    controller: confirmPswdController,
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 20),

                  // Dropdown
                  buildFieldJenisClient(),
                  const SizedBox(height: 40),

                  // Tombol Daftar
                  buildAnimatedButton(
                    text: 'Daftar',
                    isHovering: _isHovering,
                    onHover: (hovering) => setState(() => _isHovering = hovering),
                    backgroundColor:
                    _isHovering ? const Color(0xFF6B9639) : Colors.grey.shade400,
                    onPressed: () => _handleRegister(),
                  ),
                ],
              ),
            ),
          );
        }, listener: (context, state) {  },
      ),
    );
  }

  // Widget _buildDropdown() {
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.symmetric(horizontal: 15),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey.shade300),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: DropdownButtonHideUnderline(
  //       child: DropdownButton<String>(
  //         value: _selectedChoice,
  //         hint: const Text('Pilihan'),
  //         isExpanded: true,
  //         icon: const Icon(Icons.keyboard_arrow_down),
  //         items: ['Pilihan', 'Individual', 'Perusahaan', 'Organisasi']
  //             .map((String value) {
  //           return DropdownMenuItem<String>(
  //             value: value,
  //             child: Text(value),
  //           );
  //         }).toList(),
  //         onChanged: (String? newValue) {
  //           setState(() {
  //             _selectedChoice = newValue!;
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget buildFieldJenisClient() {
    return buildFieldComboMJnsclient(
      labelText: 'Jenis Client',
      initItem: fieldComboJnsClient,
      onChangedCallback: (value) {
        if (value != null) {
          //fieldComboJnsClient = value;
          _selectedChoice = value.mjnsclientId;
          debugPrint("fieldComboJnsClient: $_selectedChoice}");
        }
      },
      onSaveCallback: (value) {},
    );
  }

  // Fungsi yang akan disambungkan ke API
  // Fungsi yang akan disambungkan ke API
  void _handleRegister() {

    debugPrint("AppData.userToken.token : ${AppData.userToken}");


    if (_formKey.currentState!.validate()) {
      if (pswdController.text != confirmPswdController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password tidak cocok'))
        );
        return;
      }

      final fullPhone = '62${hpController.text}';

      RegUserModel record = RegUserModel(
        userNama: AppData.user.username ?? "",
        personalNama: _nameController.text,
        telepon: fullPhone,
        password: pswdController.text,
        jnsClientId: _selectedChoice,
        email: AppData.user.email ?? "",
      );

      context.read<RegUserBloc>().add(
          RegUserTambahEvent(record: record)
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Isi semua field dengan benar'))
      );
    }


  }
}