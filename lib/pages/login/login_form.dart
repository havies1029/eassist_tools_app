import 'package:eassist_tools_app/common/app_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/blocs/login/login_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    //debugPrint("Masuk ke Login Form");

    onLoginButtonPressed() {
      //debugPrint("onLoginButtonPressed");
      //debugPrint("username : ${_usernameController.text}");
      //debugPrint("psswd : ${_passwordController.text}");

      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
    }

    return MultiBlocListener(
      listeners: [
        /*
        BlocListener<NetworkBloc, NetworkState>(listener: (context, state) {
          if (state is NetworkFailure) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("You're not Connected to Internet"),
              backgroundColor: Colors.red,
            ));
          } else if (state is NetworkSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("You're Connected to Internet"),
                backgroundColor: Colors.green,
              ));
          }
        }),
        */
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            /*
            if (state is AuthenticationUninitialized){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("state is AuthenticationUninitialized"),
                backgroundColor: Colors.red,
              ));
            }
    
            if (state is AuthenticationAuthenticated){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("state is AuthenticationAuthenticated"),
                backgroundColor: Colors.red,
              ));
            }
    
            if (state is AuthenticationUnauthenticated){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("state is AuthenticationUnauthenticated"),
                backgroundColor: Colors.red,
              ));
            }
    
            if (state is AuthenticationLoading){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("state is AuthenticationLoading"),
                backgroundColor: Colors.red,
              ));
            }
    
            if (state is AuthenticationPreCheckHasToken){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("state is AuthenticationPreCheckHasToken"),
                backgroundColor: Colors.red,
              ));
            }
    
    
            if (state is AuthenticationPostCheckHasToken){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("state is AuthenticationPostCheckHasToken"),
                backgroundColor: Colors.red,
              ));
            }
            */
          },
        ),
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            /*
            if (state is LoginInitial) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("state is LoginInitial"),
                backgroundColor: Colors.red,
              ));
            }
    
            if (state is LoginLoading) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("state is LoginLoading"),
                backgroundColor: Colors.red,
              ));
            }
    
            if (state is LoginPreAuthenticate) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("state is LoginPreAuthenticate"),
                backgroundColor: Colors.red,
              ));
            }
    
          if (state is LoginPostAuthenticate) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("state is LoginPostAuthenticate"),
                backgroundColor: Colors.red,
              ));
            }
            */
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Username atau Password Anda salah!"),
                backgroundColor: Colors.red,
              ));
            }            
          },
        ),
      ],
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return ((state is LoginInitial) || (state is LoginFailure)) ? 
            SingleChildScrollView(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                      width: 200,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Image.asset(
                          'assets/images/login_logo.png',
                          width: 200,
                          height: 150,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'username', icon: Icon(Icons.person)),
                      controller: _usernameController,
                    ),
                    TextFormField(
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                          labelText: 'password',
                          icon: const Icon(Icons.security),
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              })),
                      controller: _passwordController,
                    ),
                    SizedBox(
                      width: 300,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ElevatedButton(

                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.orange[300], 
                            backgroundColor: Colors.blueGrey, 
                            textStyle: TextStyle(
                              fontSize: 24.0
                            )
                          ),
                          onPressed: state is! LoginLoading
                              ? onLoginButtonPressed
                              : null,
                          
                          child: const Text(
                            'Login'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ) : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
