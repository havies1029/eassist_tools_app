import 'package:eassist_tools_app/apis/simulmb/simulmblist_api.dart';
import 'package:eassist_tools_app/models/simulmb/simulmblist_model.dart';

class SimulmbListRepository {

	Future<List<SimulmbListModel>> getSimulmbList(String searchText, int hal) async {
		SimulmbListAPI api = SimulmbListAPI();
		return await api.getSimulmbListAPI(searchText, hal);
	}
}
