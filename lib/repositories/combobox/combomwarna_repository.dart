import 'package:eassist_tools_app/apis/combobox/combomwarna_api.dart';
import 'package:eassist_tools_app/models/combobox/combomwarna_model.dart';

class ComboMWarnaRepository {

	Future<List<ComboMWarnaModel>> getComboMWarna(String filter) async {
		ComboMWarnaAPI api = ComboMWarnaAPI();
		return await api.getComboMWarnaAPI(filter);
	}
}
