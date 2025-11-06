import 'package:eassist_tools_app/apis/combobox/combommvmodel_api.dart';
import 'package:eassist_tools_app/models/combobox/combommvmodel_model.dart';

class ComboMMvmodelRepository {

	Future<List<ComboMMvmodelModel>> getComboMMvmodel(String filter) async {
		ComboMMvmodelAPI api = ComboMMvmodelAPI();
		return await api.getComboMMvmodelAPI(filter);
	}
}
