import 'package:eassist_tools_app/apis/asettracking/asettrackcari_api.dart';
import 'package:eassist_tools_app/models/asettracking/asettrackcari_model.dart';

class AsettrackCariRepository {

	Future<List<AsettrackCariModel>> getAsettrackCari(String searchText, int hal) async {
		AsettrackCariAPI api = AsettrackCariAPI();
		return await api.getAsettrackCariAPI(searchText, hal);
	}
}
