import 'package:eassist_tools_app/apis/payment/pay1list_api.dart';
import 'package:eassist_tools_app/models/payment/pay1list_model.dart';

class Pay1ListRepository {

	Future<List<Pay1ListModel>> getPay1List(String searchText, int hal) async {
		Pay1ListAPI api = Pay1ListAPI();
		return await api.getPay1ListAPI(searchText, hal);
	}
}
