import 'package:eassist_tools_app/apis/simulgis/simulgislist_api.dart';
import 'package:eassist_tools_app/models/simulgis/simulgislist_model.dart';

class SimulgisListRepository {

	Future<List<SimulgisListModel>> getSimulgisList(String searchText, int hal) async {
		SimulgisListAPI api = SimulgisListAPI();
		return await api.getSimulgisListAPI(searchText, hal);
	}
}
