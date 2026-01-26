import 'package:eassist_tools_app/apis/regendors/regendorscari_api.dart';
import 'package:eassist_tools_app/models/regendors/regendorscari_model.dart';

class RegendorsCariRepository {

	Future<List<RegendorsCariModel>> getRegendorsCari(String searchText, int hal) async {
		RegendorsCariAPI api = RegendorsCariAPI();
		return await api.getRegendorsCariAPI(searchText, hal);
	}
}
