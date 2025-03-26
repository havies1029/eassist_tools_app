import 'package:eassist_tools_app/apis/combobox/combormatauang_api.dart';
import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';

class ComboRMatauangRepository {

	Future<List<ComboRMatauangModel>> getComboRMatauang() async {
		ComboRMatauangAPI api = ComboRMatauangAPI();
		return await api.getComboRMatauangAPI();
	}
}
