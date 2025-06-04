import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/login/emailverification_model.dart';
import 'package:eassist_tools_app/repositories/login/emailverification_repository.dart';

part 'emailverification_event.dart';
part 'emailverification_state.dart';

class EmailVerificationBloc extends Bloc<EmailVerificationEvents, EmailVerificationState> {
	final EmailVerificationRepository repository;
	EmailVerificationBloc({required this.repository}) : super(const EmailVerificationState()) {
		on<EmailVerificationTambahEvent>(onTambahEmailVerification);
	}

	Future<void> onTambahEmailVerification(
		EmailVerificationTambahEvent event, Emitter<EmailVerificationState> emit) async {

		ReturnDataAPI returnData;
		bool hasFailure = true;
		emit(state.copyWith(isLoading: true, isLoaded: false));
		returnData = await repository.emailVerificationTambah(event.record);
		hasFailure = !returnData.success;
		emit(state.copyWith(
			isLoading: false,
			isLoaded: true,
			hasFailure: hasFailure));
	}
	
}