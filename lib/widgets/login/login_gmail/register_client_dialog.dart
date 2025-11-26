import 'package:eassist_tools_app/blocs/reguser/reguser_bloc.dart';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/models/combobox/combomjnsclient_model.dart';
import 'package:eassist_tools_app/models/reguser/reguser_model.dart';
import 'package:eassist_tools_app/widgets/combobox/combomjnsclient_widget.dart';
import 'package:eassist_tools_app/widgets/login/login_gmail/Base_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  buildTextField(
                    controller: hpController,
                    hintText: 'HP',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
              
                  // Input pswd
                  buildTextField(
                    controller: pswdController,
                    hintText: 'Password',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
              
                  // Input confirm pswd
                  buildTextField(
                    controller: confirmPswdController,
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
              
                  // Dropdown
                  buildFieldJenisClient(),
                  const SizedBox(height: 40),

                  // Pesan kesalahan jika ada
                  if (state.hasFailure)
                    Text(
                      state.errors[0],
                      style: const TextStyle(color: Colors.red),
                    ),
              
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
  void _handleRegister() {

    debugPrint("AppData.userToken.token : ${AppData.userToken}");

    
    if (_formKey.currentState!.validate()) {
      if (pswdController.text != confirmPswdController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password tidak cocok'))
        );
        return;
      }

      RegUserModel record = RegUserModel(
        userNama: AppData.user.username??"",
        personalNama: _nameController.text,
        telepon: hpController.text,
        password: pswdController.text,
        jnsClientId: _selectedChoice,
        email: AppData.user.email??""
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