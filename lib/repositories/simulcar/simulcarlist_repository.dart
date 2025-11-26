import 'package:eassist_tools_app/apis/simulcar/simulcarlist_api.dart';
import 'package:eassist_tools_app/models/simulcar/simulcarlist_model.dart';

class SimulcarListRepository {

	Future<List<SimulcarListModel>> getSimulcarList(String searchText, int hal) async {
		SimulcarListAPI api = SimulcarListAPI();
		return await api.getSimulcarListAPI(searchText, hal);
	}
}
