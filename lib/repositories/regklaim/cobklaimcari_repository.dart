import 'package:eassist_tools_app/apis/regklaim/cobklaimcari_api.dart';
import 'package:eassist_tools_app/models/regklaim/cobklaimcari_model.dart';

class CobklaimcariRepository {

	Future<List<CobklaimcariModel>> getCobklaimcari() async {
		CobklaimcariAPI api = CobklaimcariAPI();
		return await api.getCobklaimcariAPI();
	}
}
