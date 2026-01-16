import 'package:eassist_tools_app/apis/asetothers/asetotherscari_api.dart';
import 'package:eassist_tools_app/models/asetothers/asetotherscari_model.dart';

class AsetothersCariRepository {

	Future<List<AsetothersCariModel>> getAsetothersCari(String cobId, String statusId, String searchText, int hal) async {
		AsetothersCariAPI api = AsetothersCariAPI();
		return await api.getAsetothersCariAPI(cobId, statusId, searchText, hal);
	}
}
