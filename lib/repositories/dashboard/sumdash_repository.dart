import 'package:eassist_tools_app/apis/dashboard/sumdash_api.dart';
import 'package:eassist_tools_app/models/dashboard/sumdash_model.dart';

class SumdashRepository {

	SumdashAPI api = SumdashAPI();

	Future<SumdashModel?> sumdashLihat() async {
		return await api.sumdashLihatAPI();
	}
}
