import 'package:eassist_tools_app/apis/combobox/combombengkel_api.dart';
import 'package:eassist_tools_app/models/combobox/combombengkel_model.dart';

class ComboMBengkelRepository {

	Future<List<ComboMBengkelModel>> getComboMBengkel(String mwilayahbengkelId, String filter) async {
		ComboMBengkelAPI api = ComboMBengkelAPI();
		return await api.getComboMBengkelAPI(mwilayahbengkelId, filter);
	}
}
