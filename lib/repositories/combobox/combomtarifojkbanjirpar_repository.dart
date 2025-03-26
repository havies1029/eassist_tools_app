import 'package:eassist_tools_app/apis/combobox/combomtarifojkbanjirpar_api.dart';
import 'package:eassist_tools_app/models/combobox/combomtarifojkbanjirpar_model.dart';

class ComboMTarifojkBanjirParRepository {

	Future<List<ComboMTarifojkBanjirParModel>> getComboMTarifojkBanjirPar() async {
		ComboMTarifojkBanjirParAPI api = ComboMTarifojkBanjirParAPI();
		return await api.getComboMTarifojkBanjirParAPI();
	}
}
