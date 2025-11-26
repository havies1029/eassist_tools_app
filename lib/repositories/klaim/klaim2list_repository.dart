import 'package:eassist_tools_app/apis/klaim/klaim2list_api.dart';
import 'package:eassist_tools_app/models/klaim/klaim2list_model.dart';

class Klaim2ListRepository {

	Future<List<Klaim2ListModel>> getKlaim2List(String klaim1Id) async {
		Klaim2ListAPI api = Klaim2ListAPI();
		return await api.getKlaim2ListAPI(klaim1Id);
	}
}
