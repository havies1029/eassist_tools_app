
class RegUserModel {
	String confirmPwd;
	String email;
	String kodePin;
	String password;
	String personalNama;
	String reguserId;
	String telepon;
	String userNama;

	RegUserModel({required this.confirmPwd, required this.email, required this.kodePin, 
    required this.password, required this.personalNama, required this.reguserId, 
		required this.telepon, required this.userNama, });

	factory RegUserModel.fromJson(Map<String, dynamic> data) {
		return RegUserModel(
			confirmPwd: data['confirmPwd']??'',
			email: data['email']??'',
			kodePin: data['kodePin']??'',
			password: data['password']??'',
			personalNama: data['personalNama']??'',
			reguserId: data['reguserId']??'',
			telepon: data['telepon']??'',
			userNama: data['userNama']??'',			
		);

	}

	Map<String, dynamic> toJson() =>
		{'confirmPwd': confirmPwd,
		'email': email,
		'kodePin': kodePin,
		'password': password,
		'personalNama': personalNama,
		'reguserId': reguserId,
		'telepon': telepon,
		'userNama': userNama,
		};

}
