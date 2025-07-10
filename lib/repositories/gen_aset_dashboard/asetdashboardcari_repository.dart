import 'package:eassist_tools_app/apis/gen_aset_dashboard/asetdashboardcari_api.dart';
import 'package:eassist_tools_app/models/gen_aset_dashboard/asetdashboardcari_model.dart';

class AsetDashboardCariRepository {

	Future<List<AsetDashboardCariModel>> getAsetDashboardCari(String cobAppId) async {
		AsetDashboardCariAPI api = AsetDashboardCariAPI();
		return await api.getAsetDashboardCariAPI(cobAppId);
	}
}
