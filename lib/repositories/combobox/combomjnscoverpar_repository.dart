import 'package:eassist_tools_app/apis/combobox/combomjnscoverpar_api.dart';
import 'package:eassist_tools_app/models/combobox/combomjnscoverpar_model.dart';

class ComboMJnscoverParRepository {

	Future<List<ComboMJnscoverParModel>> getComboMJnscoverPar() async {
		ComboMJnscoverParAPI api = ComboMJnscoverParAPI();
		return await api.getComboMJnscoverParAPI();
	}
}
