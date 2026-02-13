import 'package:eassist_tools_app/apis/combobox/combomjenisrugi_api.dart';
import 'package:eassist_tools_app/models/combobox/combomjenisrugi_model.dart';

class ComboMJenisrugiRepository {

	Future<List<ComboMJenisrugiModel>> getComboMJenisrugi() async {
		ComboMJenisrugiAPI api = ComboMJenisrugiAPI();
		return await api.getComboMJenisrugiAPI();
	}
}
