import 'package:eassist_tools_app/apis/combobox/comborkodepos_api.dart';
import 'package:eassist_tools_app/models/combobox/comborkodepos_model.dart';

class ComboRKodeposRepository {

	Future<List<ComboRKodeposModel>> getComboRKodepos(String kotaId, String filter) async {
		ComboRKodeposAPI api = ComboRKodeposAPI();
		return await api.getComboRKodeposAPI(kotaId, filter);
	}
}
