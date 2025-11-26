import 'package:eassist_tools_app/apis/simulgit/simulgitlist_api.dart';
import 'package:eassist_tools_app/models/simulgit/simulgitlist_model.dart';

class SimulgitListRepository {

	Future<List<SimulgitListModel>> getSimulgitList(String searchText, int hal) async {
		SimulgitListAPI api = SimulgitListAPI();
		return await api.getSimulgitListAPI(searchText, hal);
	}
}
