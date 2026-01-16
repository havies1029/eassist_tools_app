import 'package:eassist_tools_app/apis/klaimringkas/klaimringkascari_api.dart';
import 'package:eassist_tools_app/models/klaimringkas/klaimringkascari_model.dart';

class KlaimringkasCariRepository {

	Future<List<KlaimringkasCariModel>> getKlaimringkasCari(String statusId) async {
		KlaimringkasCariAPI api = KlaimringkasCariAPI();
		return await api.getKlaimringkasCariAPI(statusId);
	}
}
