
import 'package:eassist_tools_app/apis/onboardmenu/onboardmenucari_api.dart';
import 'package:eassist_tools_app/models/onboardmenu/onboardmenucari_model.dart';

class OnBoardMenuCariRepository {

	Future<OnBoardMenuCariModel> getOnBoardMenuCari() async {
		OnBoardMenuCariAPI api = OnBoardMenuCariAPI();
		return await api.getOnBoardMenuCariAPI();
	}
}
