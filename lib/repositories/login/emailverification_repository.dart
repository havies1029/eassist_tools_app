import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/login/emailverification_api.dart';
import 'package:eassist_tools_app/models/login/emailverification_model.dart';

class EmailVerificationRepository {

	EmailVerificationAPI api = EmailVerificationAPI();

	Future<ReturnDataAPI> emailVerificationTambah(EmailVerificationModel record) async {
		return await api.emailVerificationTambahAPI(record);
	}

	Future<ReturnDataAPI> validasiPinEmail(EmailVerificationModel record) async {
		return await api.validasiPinEmailAPI(record);
	}

}
