import 'package:eassist_tools_app/apis/combobox/combommvmerk_api.dart';
import 'package:eassist_tools_app/models/combobox/combommvmerk_model.dart';

class ComboMMvmerkRepository {

	Future<List<ComboMMvmerkModel>> getComboMMvmerk(String filter) async {
		ComboMMvmerkAPI api = ComboMMvmerkAPI();
		return await api.getComboMMvmerkAPI(filter);
	}
}
