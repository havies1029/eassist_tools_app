import 'package:eassist_tools_app/apis/simulbon/simulbonlist_api.dart';
import 'package:eassist_tools_app/models/simulbon/simulbonlist_model.dart';

class SimulbonListRepository {

	Future<List<SimulbonListModel>> getSimulbonList(String searchText, int hal) async {
		SimulbonListAPI api = SimulbonListAPI();
		return await api.getSimulbonListAPI(searchText, hal);
	}
}
