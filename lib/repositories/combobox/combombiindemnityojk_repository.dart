import 'package:eassist_tools_app/apis/combobox/combombiindemnityojk_api.dart';
import 'package:eassist_tools_app/models/combobox/combombiindemnityojk_model.dart';

class ComboMBiindemnityOjkRepository {

	Future<List<ComboMBiindemnityOjkModel>> getComboMBiindemnityOjk() async {
		ComboMBiindemnityOjkAPI api = ComboMBiindemnityOjkAPI();
		return await api.getComboMBiindemnityOjkAPI();
	}
}
