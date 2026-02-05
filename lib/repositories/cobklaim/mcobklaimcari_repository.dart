import 'package:eassist_tools_app/apis/cobklaim/mcobklaimcari_api.dart';
import 'package:eassist_tools_app/models/cobklaim/mcobklaimcari_model.dart';

class McobklaimCariRepository {

	Future<List<McobklaimCariModel>> getMcobklaimCari() async {
		McobklaimCariAPI api = McobklaimCariAPI();
		return await api.getMcobklaimCariAPI();
	}
}
