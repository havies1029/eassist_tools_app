import 'package:eassist_tools_app/apis/regreaktif/regreaktif2cari_api.dart';
import 'package:eassist_tools_app/models/regreaktif/regreaktif2cari_model.dart';

class Regreaktif2CariRepository {

	Future<List<Regreaktif2CariModel>> getRegreaktif2Cari(String regreaktif1Id) async {
		Regreaktif2CariAPI api = Regreaktif2CariAPI();
		return await api.getRegreaktif2CariAPI(regreaktif1Id);
	}
}
