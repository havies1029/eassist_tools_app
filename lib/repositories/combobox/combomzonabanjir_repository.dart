import 'package:eassist_tools_app/apis/combobox/combomzonabanjir_api.dart';
import 'package:eassist_tools_app/models/combobox/combomzonabanjir_model.dart';

class ComboMZonaBanjirRepository {

	Future<List<ComboMZonaBanjirModel>> getComboMZonaBanjir() async {
		ComboMZonaBanjirAPI api = ComboMZonaBanjirAPI();
		return await api.getComboMZonaBanjirAPI();
	}
}
