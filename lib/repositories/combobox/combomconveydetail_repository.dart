import 'package:eassist_tools_app/apis/combobox/combomconveydetail_api.dart';
import 'package:eassist_tools_app/models/combobox/combomconveydetail_model.dart';

class ComboMConveyDetailRepository {

	Future<List<ComboMConveyDetailModel>> getComboMConveyDetail() async {
		ComboMConveyDetailAPI api = ComboMConveyDetailAPI();
		return await api.getComboMConveyDetailAPI();
	}
}
