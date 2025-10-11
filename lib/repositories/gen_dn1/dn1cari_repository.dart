import 'package:eassist_tools_app/apis/gen_dn1/dn1cari_api.dart';
import 'package:eassist_tools_app/models/gen_dn1/dn1cari_model.dart';

class Dn1CariRepository {

	Future<List<Dn1CariModel>> getDn1Cari(String sppa1Id) async {
		Dn1CariAPI api = Dn1CariAPI();
		return await api.getDn1CariAPI(sppa1Id);
	}
}
