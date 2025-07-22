import 'package:eassist_tools_app/apis/gen_berita/berita2cari_api.dart';
import 'package:eassist_tools_app/models/gen_berita/berita2cari_model.dart';

class Berita2CariRepository {

	Future<List<Berita2CariModel>> getBerita2Cari(String berita1Id) async {
		Berita2CariAPI api = Berita2CariAPI();
		return await api.getBerita2CariAPI(berita1Id);
	}
}
