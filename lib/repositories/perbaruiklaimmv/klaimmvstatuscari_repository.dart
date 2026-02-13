import 'package:eassist_tools_app/apis/perbaruiklaimmv/klaimmvstatuscari_api.dart';
import 'package:eassist_tools_app/models/perbaruiklaimmv/klaimmvstatuscari_model.dart';

class KlaimmvstatuscariRepository {

	Future<List<KlaimmvstatuscariModel>> getKlaimmvstatuscari(String klaim1Id) async {
		KlaimmvstatuscariAPI api = KlaimmvstatuscariAPI();
		return await api.getKlaimmvstatuscariAPI(klaim1Id);
	}
}
