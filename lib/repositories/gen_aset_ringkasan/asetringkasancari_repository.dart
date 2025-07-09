import 'package:eassist_tools_app/apis/gen_aset_ringkasan/asetringkasancari_api.dart';
import 'package:eassist_tools_app/models/gen_aset_ringkasan/asetringkasancari_model.dart';

class AsetRingkasanCariRepository {

	Future<List<AsetRingkasanCariModel>> getAsetRingkasanCari(String searchText, int hal) async {
		AsetRingkasanCariAPI api = AsetRingkasanCariAPI();
		return await api.getAsetRingkasanCariAPI(searchText, hal);
	}
}
