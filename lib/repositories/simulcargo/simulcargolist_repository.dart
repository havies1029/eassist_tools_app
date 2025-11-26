import 'package:eassist_tools_app/apis/simulcargo/simulcargolist_api.dart';
import 'package:eassist_tools_app/models/simulcargo/simulcargolist_model.dart';

class SimulcargoListRepository {

	Future<List<SimulcargoListModel>> getSimulcargoList(String searchText, int hal) async {
		SimulcargoListAPI api = SimulcargoListAPI();
		return await api.getSimulcargoListAPI(searchText, hal);
	}
}
