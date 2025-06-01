import 'package:eassist_tools_app/apis/profile/rekanpiclist_api.dart';
import 'package:eassist_tools_app/models/profile/rekanpiclist_model.dart';

class RekanPicListRepository {

	Future<List<RekanPicListModel>> getRekanPicList(String searchText, int hal) async {
		RekanPicListAPI api = RekanPicListAPI();
		return await api.getRekanPicListAPI(searchText, hal);
	}
}
