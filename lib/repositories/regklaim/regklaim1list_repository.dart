import 'package:eassist_tools_app/apis/regklaim/regklaim1list_api.dart';
import 'package:eassist_tools_app/models/regklaim/regklaim1list_model.dart';

class Regklaim1ListRepository {

	Future<List<Regklaim1ListModel>> getRegklaim1List(String searchText, int hal) async {
		Regklaim1ListAPI api = Regklaim1ListAPI();
		return await api.getRegklaim1ListAPI(searchText, hal);
	}
}
