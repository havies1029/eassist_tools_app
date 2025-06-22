import 'package:eassist_tools_app/apis/gen_profile/mrekanpiclist_api.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekanpiclist_model.dart';

class MRekanPicListRepository {

	Future<List<MRekanPicListModel>> getMRekanPicList() async {
		MRekanPicListAPI api = MRekanPicListAPI();
		return await api.getMRekanPicListAPI();
	}
}
