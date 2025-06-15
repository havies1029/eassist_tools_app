import 'package:eassist_tools_app/apis/gen_profile/mrekan1list_api.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekan1list_model.dart';

class MRekan1ListRepository {

	Future<List<MRekan1ListModel>> getMRekan1List(String searchText, int hal) async {
		MRekan1ListAPI api = MRekan1ListAPI();
		return await api.getMRekan1ListAPI(searchText, hal);
	}
}
