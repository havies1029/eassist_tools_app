import 'package:eassist_tools_app/apis/combobox/combombentukcst_api.dart';
import 'package:eassist_tools_app/models/combobox/combombentukcst_model.dart';

class ComboMBentukCstRepository {

	Future<List<ComboMBentukCstModel>> getComboMBentukCst() async {
		ComboMBentukCstAPI api = ComboMBentukCstAPI();
		return await api.getComboMBentukCstAPI();
	}
}
