import 'package:eassist_tools_app/apis/klaimringkas/mstatusringkascari_api.dart';
import 'package:eassist_tools_app/models/klaimringkas/mstatusringkascari_model.dart';

class MstatusringkasCariRepository {

	Future<List<MstatusringkasCariModel>> getMstatusringkasCari() async {
		MstatusringkasCariAPI api = MstatusringkasCariAPI();
		return await api.getMstatusringkasCariAPI();
	}
}
