import 'package:eassist_tools_app/apis/gen_endors/endors1list_api.dart';
import 'package:eassist_tools_app/models/gen_endors/endors1list_model.dart';

class Endors1ListRepository {

	Future<List<Endors1ListModel>> getEndors1List(String searchText, int hal) async {
		Endors1ListAPI api = Endors1ListAPI();
		return await api.getEndors1ListAPI(searchText, hal);
	}
}
