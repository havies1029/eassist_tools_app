import 'package:eassist_tools_app/apis/simuleei/simuleeilist_api.dart';
import 'package:eassist_tools_app/models/simuleei/simuleeilist_model.dart';

class SimuleeiListRepository {

	Future<List<SimuleeiListModel>> getSimuleeiList(String searchText, int hal) async {
		SimuleeiListAPI api = SimuleeiListAPI();
		return await api.getSimuleeiListAPI(searchText, hal);
	}
}
