import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/profile_bloc.dart';
import 'package:eassist_tools_app/common/constants.dart';
import 'package:eassist_tools_app/common/size_config.dart';
import 'package:eassist_tools_app/models/user/user_model.dart';
import 'package:eassist_tools_app/widgets/custom_sufix_icon.dart';
import 'package:eassist_tools_app/widgets/form_error.dart';
import 'package:eassist_tools_app/widgets/default_button.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String fullName = "";
  String phoneNumber = "";
  //String alamat1 = "";
  //String alamat2 = "";
  //String? jnskel = "P";
  Uint8List? foto;

  final List<String> errors = [];
  var fullnameController = TextEditingController();
  var nohpController = TextEditingController();
  var emailController = TextEditingController();

  void addError({required String error}) {
    if (!errors.contains(error))
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {

    //debugPrint("ProfileForm -> Widget - build");

    BlocProvider.of<ProfileBloc>(context).add(GetUserEvent());

    return BlocConsumer<ProfileBloc, UserState>(
        listenWhen: (previous, current) {
      //debugPrint("ProfileForm -> listenWhen");
      
      return (previous.isSaved != current.isSaved);
    }, listener: (context, state) {      
      //debugPrint("ProfileForm -> listener");
      if (state.isSaved) {
        //debugPrint("Proses simpan data berhasil !");

        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Success !'),
            content: const Text('Penyimpanan data berhasil !'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }, buildWhen: (previous, current) {          
      //debugPrint("ProfileForm -> buildWhen");
      return (current.isLoaded);
    }, builder: (context, state) {               
      //debugPrint("ProfileForm -> builder");

      if (state.user != null) {
        fullnameController.text = state.user!.nama!;
        nohpController.text = state.user!.hp!;
        emailController.text = state.user!.email!;
        //alamat1Controller.text = state.user!.alamat1!;
        //alamat2Controller.text = state.user!.alamat2!;
        //jnskelController.text = state.user!.jnskel!;
        //jnskel = state.user!.jnskel!;
        foto = state.user!.foto;
        /*
        comboPropinsiSelected = ComboPropinsi(
            propinsiId: state.user!.propinsiId!,
            propinsiDesc: state.user!.propinsiDesc!);
        */
      }

      return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(10)),
            buildFullNameFormField(),
            SizedBox(height: getProportionateScreenHeight(10)),
            buildPhoneNumberFormField(),
            SizedBox(height: getProportionateScreenHeight(10)),
            buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(15)),
            FormError(
              errors: errors,
              key: null,
            ),
            DefaultButton(
              text: "Save",
              press: () {
                if (_formKey.currentState!.validate()) {
                  //Navigator.pushNamed(context, OtpScreen.routeName);

                  _formKey.currentState?.save();

                  User user = User(
                      username: state.user?.username,
                      nama: fullName,
                      email: email,
                      hp: phoneNumber,
                      //alamat1: alamat1,
                      //alamat2: alamat2,
                      //propinsiId: comboPropinsiSelected?.propinsiId,
                      //propinsiDesc: comboPropinsiSelected?.propinsiDesc,
                      //jnskel: jnskel,
                      foto: foto,
                      token: state.user?.token);

                  BlocProvider.of<ProfileBloc>(context)
                      .add(UpdateUserEvent(user: user));
                }
              },
              key: null,
            ),
          ],
        ),
      );
    });
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        /*
        else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        */

        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        /*
        else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        */
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Masukan email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufixIcon(
          svgIcon: "assets/icons/Mail.svg",
          key: null,
        ),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: nohpController,
      onSaved: (newValue) => phoneNumber = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        //return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Phone Number",
        hintText: "Masukan hp / telp",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufixIcon(
          svgIcon: "assets/icons/Phone.svg",
          key: null,
        ),
      ),
    );
  }

  TextFormField buildFullNameFormField() {
    return TextFormField(
      controller: fullnameController,
      //onSaved: (newValue) => fullName = newValue!,
      onSaved: (newValue) {
        fullName = newValue!;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        //return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Name",
        hintText: "Masukan nama",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSufixIcon(
          svgIcon: "assets/icons/User.svg",
          key: null,
        ),
      ),
    );
  }

  

}
