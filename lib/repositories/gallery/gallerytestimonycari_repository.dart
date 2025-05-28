import 'package:eassist_tools_app/apis/gallery/gallerytestimonycari_api.dart';
import 'package:eassist_tools_app/models/gallery/gallerytestimonycari_model.dart';

class GallerytestimonyCariRepository {

	Future<List<GallerytestimonyCariModel>> getGallerytestimonyCari() async {
		GallerytestimonyCariAPI api = GallerytestimonyCariAPI();
		return await api.getGallerytestimonyCariAPI();
	}
}
