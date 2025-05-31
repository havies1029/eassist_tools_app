
class EmailVerificationModel {
	String email;

	EmailVerificationModel({required this.email});

	factory EmailVerificationModel.fromJson(Map<String, dynamic> data) {
		return EmailVerificationModel(
			email: data['email']??'',
		);

	}

	Map<String, dynamic> toJson() =>
		{'email': email,};

}
