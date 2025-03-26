import 'package:eassist_tools_app/apis/simulpar/simulparlist_api.dart';
import 'package:eassist_tools_app/models/simulpar/simulparlist_model.dart';

class SimulparListRepository {

	Future<List<SimulparListModel>> getSimulparList(String searchText, int hal) async {
		SimulparListAPI api = SimulparListAPI();
		return await api.getSimulparListAPI(searchText, hal);
	}
}
