import 'package:eassist_tools_app/apis/combobox/combompropinsi_api.dart';
import 'package:eassist_tools_app/models/combobox/combompropinsi_model.dart';

class ComboMPropinsiRepository {

	Future<List<ComboMPropinsiModel>> getComboMPropinsi(String filter) async {
		ComboMPropinsiAPI api = ComboMPropinsiAPI();
		return await api.getComboMPropinsiAPI(filter);
	}
}
