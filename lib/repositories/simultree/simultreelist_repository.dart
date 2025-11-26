import 'package:eassist_tools_app/apis/simultree/simultreelist_api.dart';
import 'package:eassist_tools_app/models/simultree/simultreelist_model.dart';

class SimultreeListRepository {

	Future<List<SimultreeListModel>> getSimultreeList(String searchText, int hal) async {
		SimultreeListAPI api = SimultreeListAPI();
		return await api.getSimultreeListAPI(searchText, hal);
	}
}
