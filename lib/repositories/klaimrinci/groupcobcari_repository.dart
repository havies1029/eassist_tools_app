import 'package:eassist_tools_app/apis/klaimrinci/groupcobcari_api.dart';
import 'package:eassist_tools_app/models/klaimrinci/groupcobcari_model.dart';

class GroupcobCariRepository {

	Future<List<GroupcobCariModel>> getGroupcobCari(String statusId, String searchText) async {
		GroupcobCariAPI api = GroupcobCariAPI();
		return await api.getGroupcobCariAPI(statusId, searchText);
	}
}
