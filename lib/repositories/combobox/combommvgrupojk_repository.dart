import 'package:eassist_tools_app/apis/combobox/combommvgrupojk_api.dart';
import 'package:eassist_tools_app/models/combobox/combommvgrupojk_model.dart';

class ComboMMvgrupOjkRepository {

	Future<List<ComboMMvgrupOjkModel>> getComboMMvgrupOjk() async {
		ComboMMvgrupOjkAPI api = ComboMMvgrupOjkAPI();
		return await api.getComboMMvgrupOjkAPI();
	}
}
