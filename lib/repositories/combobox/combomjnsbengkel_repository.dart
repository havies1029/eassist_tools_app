import 'package:eassist_tools_app/apis/combobox/combomjnsbengkel_api.dart';
import 'package:eassist_tools_app/models/combobox/combomjnsbengkel_model.dart';

class ComboMJnsbengkelRepository {

	Future<List<ComboMJnsbengkelModel>> getComboMJnsbengkel() async {
		ComboMJnsbengkelAPI api = ComboMJnsbengkelAPI();
		return await api.getComboMJnsbengkelAPI();
	}
}
