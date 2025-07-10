import 'package:eassist_tools_app/apis/gen_aset_par/asetparcari_api.dart';
import 'package:eassist_tools_app/models/gen_aset_par/asetparcari_model.dart';

class AsetParCariRepository {

	Future<List<AsetParCariModel>> getAsetParCari(String searchText, int hal) async {
		AsetParCariAPI api = AsetParCariAPI();
		return await api.getAsetParCariAPI(searchText, hal);
	}
}
