import 'package:eassist_tools_app/apis/combobox/combommvtipe_api.dart';
import 'package:eassist_tools_app/models/combobox/combommvtipe_model.dart';

class ComboMMvtipeRepository {

	Future<List<ComboMMvtipeModel>> getComboMMvtipe(String mvmerkId, String filter) async {
		ComboMMvtipeAPI api = ComboMMvtipeAPI();
		return await api.getComboMMvtipeAPI(mvmerkId, filter);
	}
}
