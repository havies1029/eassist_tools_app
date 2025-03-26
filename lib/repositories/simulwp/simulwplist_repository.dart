import 'package:eassist_tools_app/apis/simulwp/simulwplist_api.dart';
import 'package:eassist_tools_app/models/simulwp/simulwplist_model.dart';

class SimulwpListRepository {

	Future<List<SimulwpListModel>> getSimulwpList(String searchText, int hal) async {
		SimulwpListAPI api = SimulwpListAPI();
		return await api.getSimulwpListAPI(searchText, hal);
	}
}
