import 'package:eassist_tools_app/apis/combobox/combommop_api.dart';
import 'package:eassist_tools_app/models/combobox/combommop_model.dart';

class ComboMMopRepository {

	Future<List<ComboMMopModel>> getComboMMop() async {
		ComboMMopAPI api = ComboMMopAPI();
		return await api.getComboMMopAPI();
	}
}
