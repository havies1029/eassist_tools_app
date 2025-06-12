class EmailVerificationModel {
  String? requestId = '';
  String email;
  String? pin;

  EmailVerificationModel({required this.email, this.pin, this.requestId});

  factory EmailVerificationModel.fromJson(Map<String, dynamic> data) {
    return EmailVerificationModel(
      email: data['email'] ?? '',
      pin: data['pin'] ?? '',
      requestId: data['requestId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'pin': pin,
        'requestId': requestId,
      };
}
