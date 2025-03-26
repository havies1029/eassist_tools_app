import 'package:eassist_tools_app/apis/combobox/combomkabzonagempa_api.dart';
import 'package:eassist_tools_app/models/combobox/combomkabzonagempa_model.dart';

class ComboMKabZonaGempaRepository {

	Future<List<ComboMKabZonaGempaModel>> getComboMKabZonaGempa(String filter) async {
		ComboMKabZonaGempaAPI api = ComboMKabZonaGempaAPI();
		return await api.getComboMKabZonaGempaAPI(filter);
	}
}
