part of 'emailverification_bloc.dart';

class EmailVerificationState extends Equatable {

	final EmailVerificationModel? record;
	final bool isLoading;
	final bool isLoaded;
	final bool isSaving;
	final bool isSaved;
	final bool hasFailure;
  final bool requestPinVerification;
	const EmailVerificationState(
		{this.record,
		this.isLoading = false,
		this.isLoaded = false,
		this.isSaving = false,
		this.isSaved = false,
		this.hasFailure = false,
    this.requestPinVerification = true,
});

	EmailVerificationState copyWith({
		EmailVerificationModel? record,
		bool? isLoading,
		bool? isLoaded,
		bool? isSaving,
		bool? isSaved,
		bool? hasFailure,
    bool? requestPinVerification,
	}){
		return EmailVerificationState(
			record: record ?? this.record,
			isLoading: isLoading ?? this.isLoading,
			isLoaded: isLoaded ?? this.isLoaded,
			isSaving: isSaving ?? this.isSaving,
			isSaved: isSaved ?? this.isSaved,
			hasFailure: hasFailure ?? this.hasFailure,
      requestPinVerification: requestPinVerification ?? this.requestPinVerification,  
		);
	}

	@override
	List<Object> get props => [isLoading, isLoaded, isSaving, isSaved, hasFailure];
}
