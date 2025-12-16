import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/payment/pay1crud_api.dart';
import 'package:eassist_tools_app/models/payment/pay1crud_model.dart';

class Pay1CrudRepository {

	Pay1CrudAPI api = Pay1CrudAPI();

	Future<ReturnDataAPI> pay1CrudTambah(Pay1CrudModel record) async {
		return await api.pay1CrudTambahAPI(record);
	}
	Future<bool> pay1CrudUbah(Pay1CrudModel record) async {
		return await api.pay1CrudUbahAPI(record);
	}
	Future<bool> pay1CrudHapus(String ar1Id) async {
		return await api.pay1CrudHapusAPI(ar1Id);
	}
	Future<Pay1CrudModel> pay1CrudLihat(String ar1Id) async {
		return await api.pay1CrudLihatAPI(ar1Id);
	}
}
