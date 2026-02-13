import 'package:eassist_tools_app/apis/combobox/combomwilayahbengkel_api.dart';
import 'package:eassist_tools_app/models/combobox/combomwilayahbengkel_model.dart';

class ComboMWilayahBengkelRepository {

	Future<List<ComboMWilayahBengkelModel>> getComboMWilayahBengkel(String filter) async {
		ComboMWilayahBengkelAPI api = ComboMWilayahBengkelAPI();
		return await api.getComboMWilayahBengkelAPI(filter);
	}
}
