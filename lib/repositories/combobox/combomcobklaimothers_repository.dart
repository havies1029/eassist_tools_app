import 'package:eassist_tools_app/apis/combobox/combomcobklaimothers_api.dart';
import 'package:eassist_tools_app/models/combobox/combomcobklaimothers_model.dart';

class ComboMCobKlaimOthersRepository {

	Future<List<ComboMCobKlaimOthersModel>> getComboMCobKlaimOthers(String filter) async {
		ComboMCobKlaimOthersAPI api = ComboMCobKlaimOthersAPI();
		return await api.getComboMCobKlaimOthersAPI(filter);
	}
}
