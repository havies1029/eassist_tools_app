import 'package:eassist_tools_app/apis/klaimrinci/mstatusrincicari_api.dart';
import 'package:eassist_tools_app/models/klaimrinci/mstatusrincicari_model.dart';

class MstatusrinciCariRepository {

	Future<List<MstatusrinciCariModel>> getMstatusrinciCari() async {
		MstatusrinciCariAPI api = MstatusrinciCariAPI();
		return await api.getMstatusrinciCariAPI();
	}
}
