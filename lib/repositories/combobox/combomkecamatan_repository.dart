import 'package:eassist_tools_app/apis/combobox/combomkecamatan_api.dart';
import 'package:eassist_tools_app/models/combobox/combomkecamatan_model.dart';

class ComboMKecamatanRepository {

	Future<List<ComboMKecamatanModel>> getComboMKecamatan(String kotaId) async {
		ComboMKecamatanAPI api = ComboMKecamatanAPI();
		return await api.getComboMKecamatanAPI(kotaId);
	}
}
