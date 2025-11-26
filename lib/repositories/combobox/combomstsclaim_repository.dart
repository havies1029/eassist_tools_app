import 'package:eassist_tools_app/apis/combobox/combomstsclaim_api.dart';
import 'package:eassist_tools_app/models/combobox/combomstsclaim_model.dart';

class ComboMStsclaimRepository {

	Future<List<ComboMStsclaimModel>> getComboMStsclaim() async {
		ComboMStsclaimAPI api = ComboMStsclaimAPI();
		return await api.getComboMStsclaimAPI();
	}
}
