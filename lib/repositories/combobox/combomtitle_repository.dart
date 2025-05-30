import 'package:eassist_tools_app/apis/combobox/combomtitle_api.dart';
import 'package:eassist_tools_app/models/combobox/combomtitle_model.dart';

class ComboMTitleRepository {

	Future<List<ComboMTitleModel>> getComboMTitle() async {
		ComboMTitleAPI api = ComboMTitleAPI();
		return await api.getComboMTitleAPI();
	}
}
