import 'package:eassist_tools_app/apis/combobox/combomzonagempa_api.dart';
import 'package:eassist_tools_app/models/combobox/combomzonagempa_model.dart';

class ComboMZonaGempaRepository {

	Future<List<ComboMZonaGempaModel>> getComboMZonaGempa() async {
		ComboMZonaGempaAPI api = ComboMZonaGempaAPI();
		return await api.getComboMZonaGempaAPI();
	}
}
