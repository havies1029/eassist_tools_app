part of 'emailverification_bloc.dart';

abstract class EmailVerificationEvents extends Equatable {
	const EmailVerificationEvents();

	@override
	List<Object> get props => [];
}

class EmailVerificationTambahEvent extends EmailVerificationEvents {
	final EmailVerificationModel record;
	const EmailVerificationTambahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class EmailVerificationUbahEvent extends EmailVerificationEvents {
	final EmailVerificationModel record;
	const EmailVerificationUbahEvent({required this.record});

	@override
	List<Object> get props => [record];
}

class EmailVerificationHapusEvent extends EmailVerificationEvents {
	final String recordId;
	const EmailVerificationHapusEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

class EmailVerificationLihatEvent extends EmailVerificationEvents {
	final String recordId;
	const EmailVerificationLihatEvent({required this.recordId});

	@override
	List<Object> get props => [recordId];
}

