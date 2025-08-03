import 'package:eassist_tools_app/apis/combobox/combomvmerklist_api.dart';
import 'package:eassist_tools_app/models/combobox/combomvmerklist_model.dart';

class ComboMvmerkListRepository {

	Future<List<ComboMvmerkListModel>> getComboMvmerkList(String filter) async {
		ComboMvmerkListAPI api = ComboMvmerkListAPI();
		return await api.getComboMvmerkListAPI(filter);
	}
}
