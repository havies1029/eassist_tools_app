import 'package:eassist_tools_app/apis/payment/mstsgroupinvcari_api.dart';
import 'package:eassist_tools_app/models/payment/mstsgroupinvcari_model.dart';

class MstsgroupinvCariRepository {

	Future<List<MstsgroupinvCariModel>> getMstsgroupinvCari() async {
		MstsgroupinvCariAPI api = MstsgroupinvCariAPI();
		return await api.getMstsgroupinvCariAPI();
	}
}
