import 'package:eassist_tools_app/apis/perbaruiklaimpar/klaim5parlist_api.dart';
import 'package:eassist_tools_app/models/perbaruiklaimpar/klaim5parlist_model.dart';

class Klaim5parListRepository {

	Future<List<Klaim5parListModel>> getKlaim5parList(String searchText, int hal) async {
		Klaim5parListAPI api = Klaim5parListAPI();
		return await api.getKlaim5parListAPI(searchText, hal);
	}
}
