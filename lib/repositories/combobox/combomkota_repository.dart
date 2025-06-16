import 'package:eassist_tools_app/apis/combobox/combomkota_api.dart';
import 'package:eassist_tools_app/models/combobox/combomkota_model.dart';

class ComboMKotaRepository {

	Future<List<ComboMKotaModel>> getComboMKota(String propinsiId) async {
		ComboMKotaAPI api = ComboMKotaAPI();
		return await api.getComboMKotaAPI(propinsiId);
	}
}
