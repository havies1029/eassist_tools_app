import 'package:eassist_tools_app/apis/simulmv/simulmvlist_api.dart';
import 'package:eassist_tools_app/models/simulmv/simulmvlist_model.dart';

class SimulmvListRepository {

	Future<List<SimulmvListModel>> getSimulmvList(String searchText, int hal) async {
		SimulmvListAPI api = SimulmvListAPI();
		return await api.getSimulmvListAPI(searchText, hal);
	}
}
