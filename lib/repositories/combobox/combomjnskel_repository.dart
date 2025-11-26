import 'package:eassist_tools_app/apis/combobox/combomjnskel_api.dart';
import 'package:eassist_tools_app/models/combobox/combomjnskel_model.dart';

class ComboMJnskelRepository {

	Future<List<ComboMJnskelModel>> getComboMJnskel() async {
		ComboMJnskelAPI api = ComboMJnskelAPI();
		return await api.getComboMJnskelAPI();
	}
}
