import 'package:eassist_tools_app/apis/gen_profile/rekanpiccobcari_api.dart';
import 'package:eassist_tools_app/models/gen_profile/rekanpiccobcari_model.dart';

class RekanPicCobCariRepository {

	Future<List<RekanPicCobCariModel>> getRekanPicCobCari(String rekanPicId, String searchText, int hal) async {
		RekanPicCobCariAPI api = RekanPicCobCariAPI();
		return await api.getRekanPicCobCariAPI(rekanPicId, searchText, hal);
	}
}
