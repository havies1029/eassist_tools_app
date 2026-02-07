import 'package:eassist_tools_app/apis/combobox/combominsurance_api.dart';
import 'package:eassist_tools_app/models/combobox/combominsurance_model.dart';

class ComboMInsuranceRepository {

	Future<List<ComboMInsuranceModel>> getComboMInsurance(String filter) async {
		ComboMInsuranceAPI api = ComboMInsuranceAPI();
		return await api.getComboMInsuranceAPI(filter);
	}
}
