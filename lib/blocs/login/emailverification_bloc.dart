import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/main.dart';
import 'package:eassist_tools_app/models/authentication/auth_model.dart';
import 'package:eassist_tools_app/models/user/user_model.dart';
import 'package:eassist_tools_app/models/user/user_token_model.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/login/emailverification_model.dart';
import 'package:eassist_tools_app/repositories/login/emailverification_repository.dart';

part 'emailverification_event.dart';
part 'emailverification_state.dart';

class EmailVerificationBloc
    extends Bloc<EmailVerificationEvents, EmailVerificationState> {
  final EmailVerificationRepository repository;
  final AuthenticationBloc authenticationBloc;

  EmailVerificationBloc(
      {required this.repository, required this.authenticationBloc})
      : super(const EmailVerificationState()) {
    on<EmailVerificationTambahEvent>(onTambahEmailVerification);
    on<ValidasiPinEmailEvent>(onValidasiPinEmail);
    on<FieldSimpanPasswordChangedEvent>(onFieldSimpanPasswordChangedEvent);
  }

  Future<void> onTambahEmailVerification(EmailVerificationTambahEvent event,
      Emitter<EmailVerificationState> emit) async {
    ReturnDataAPI returnData;
    bool hasFailure = true;
    emit(state.copyWith(isLoading: true, isLoaded: false));
    returnData = await repository.emailVerificationTambah(event.record);
    hasFailure = !returnData.success;
    
    if (!hasFailure) {
      
      List<String> infoData = returnData.data.split(";");

      if (infoData[0] == '1') {

        Token token = Token.split(event.record.email, infoData[1]);

        UserRepository userRepository = UserRepository();
        UserToken userToken = UserToken(id: 0, token: token.token, custType: 'U');

        User user = User(
          id: 0,
          username: event.record.email,
          email: event.record.email,
          token: token.token,
        );

        if (state.isSimpanPassword) {
          if (AppData.kIsWeb) {
            //userRepository.persistTokenWeb(userToken: userToken);
          } else {
            userRepository.persistToken(userToken: userToken);
          }
        }      

        authenticationBloc.add(UserAuthenticated(user: user));

      } else if (infoData[0] == '2') {
        event.record.requestId = infoData[1];
        authenticationBloc
          .add(RequirePinEmailVerification(email: event.record.email));
      }      
    }

    debugPrint("onTambahEmailVerification returnData: ${returnData.data}");
    emit(state.copyWith(
      isLoading: false,
      isLoaded: true,
      hasFailure: hasFailure,
      record: event.record,
    ));
   
  }

  Future<void> onValidasiPinEmail(
      ValidasiPinEmailEvent event, Emitter<EmailVerificationState> emit) async {
    ReturnDataAPI returnData;
    bool hasFailure = true;
    emit(state.copyWith(
        isLoading: true, isLoaded: false, verificationFailed: false));
    event.record.requestId = state.record?.requestId ?? '';
    returnData = await repository.validasiPinEmail(event.record);

    debugPrint("onValidasiPinEmail returnData: ${returnData.data}");

    hasFailure = !returnData.success;
    emit(state.copyWith(
      isLoading: false,
      isLoaded: true,
      hasFailure: hasFailure,
    ));

    if (!hasFailure && returnData.data.isNotEmpty) {
      Token token = Token.split(event.record.email, returnData.data);

      UserRepository userRepository = UserRepository();
      UserToken userToken = UserToken(id: 0, token: token.token, custType: 'U');

      User user = User(
        id: 0,
        username: event.record.email,
        email: event.record.email,
        token: token.token,
      );

      if (state.isSimpanPassword) {
        if (AppData.kIsWeb) {
          //userRepository.persistTokenWeb(userToken: userToken);
        } else {
          userRepository.persistToken(userToken: userToken);
        }
      }      

      authenticationBloc.add(UserAuthenticated(user: user));
    } else {
      List<String> errors = [];
      errors.add(returnData.data);
      emit(state.copyWith(verificationFailed: true, errors: errors));
    }
  }

  Future<void> onFieldSimpanPasswordChangedEvent(
      FieldSimpanPasswordChangedEvent event,
      Emitter<EmailVerificationState> emit) async {
    
    debugPrint("onFieldSimpanPasswordChangedEvent event: ${event.isSimpanPassword}");
    emit(state.copyWith(isSimpanPassword: event.isSimpanPassword));
    
    debugPrint("onFieldSimpanPasswordChangedEvent state: ${state.isSimpanPassword}");
  }
}
