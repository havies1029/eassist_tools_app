import 'package:eassist_tools_app/apis/gen_aset_hull/asethullcari_api.dart';
import 'package:eassist_tools_app/models/gen_aset_hull/asethullcari_model.dart';

class AsethullCariRepository {

	Future<List<AsethullCariModel>> getAsethullCari(String statusId, String searchText, int hal) async {
		AsethullCariAPI api = AsethullCariAPI();
		return await api.getAsethullCariAPI(statusId, searchText, hal);
	}
}
