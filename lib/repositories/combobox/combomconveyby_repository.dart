import 'package:eassist_tools_app/apis/combobox/combomconveyby_api.dart';
import 'package:eassist_tools_app/models/combobox/combomconveyby_model.dart';

class ComboMConveybyRepository {

	Future<List<ComboMConveybyModel>> getComboMConveyby() async {
		ComboMConveybyAPI api = ComboMConveybyAPI();
		return await api.getComboMConveybyAPI();
	}
}
