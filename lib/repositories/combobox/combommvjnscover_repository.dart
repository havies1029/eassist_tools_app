import 'package:eassist_tools_app/apis/combobox/combommvjnscover_api.dart';
import 'package:eassist_tools_app/models/combobox/combommvjnscover_model.dart';

class ComboMMvjnscoverRepository {

	Future<List<ComboMMvjnscoverModel>> getComboMMvjnscover() async {
		ComboMMvjnscoverAPI api = ComboMMvjnscoverAPI();
		return await api.getComboMMvjnscoverAPI();
	}
}
