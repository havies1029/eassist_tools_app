import 'package:eassist_tools_app/apis/gallery/galleryeventcari_api.dart';
import 'package:eassist_tools_app/models/gallery/galleryeventcari_model.dart';

class GalleryeventCariRepository {

	Future<List<GalleryeventCariModel>> getGalleryeventCari() async {
		GalleryeventCariAPI api = GalleryeventCariAPI();
		return await api.getGalleryeventCariAPI();
	}
}
