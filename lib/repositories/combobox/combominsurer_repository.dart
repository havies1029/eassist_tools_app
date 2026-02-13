import 'package:eassist_tools_app/apis/combobox/combominsurer_api.dart';
import 'package:eassist_tools_app/models/combobox/combominsurer_model.dart';

class ComboMInsurerRepository {

	Future<List<ComboMInsurerModel>> getComboMInsurer(String filter) async {
		ComboMInsurerAPI api = ComboMInsurerAPI();
		return await api.getComboMInsurerAPI(filter);
	}
}
