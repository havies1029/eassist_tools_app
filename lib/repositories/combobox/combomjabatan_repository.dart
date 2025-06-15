import 'package:eassist_tools_app/apis/combobox/combomjabatan_api.dart';
import 'package:eassist_tools_app/models/combobox/combomjabatan_model.dart';

class ComboMJabatanRepository {

	Future<List<ComboMJabatanModel>> getComboMJabatan() async {
		ComboMJabatanAPI api = ComboMJabatanAPI();
		return await api.getComboMJabatanAPI();
	}
}
