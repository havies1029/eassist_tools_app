import 'dart:convert';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekangeneralidvcrud_model.dart';

class MRekanGeneralIdvCrudAPI {

	Future<ReturnDataAPI> mRekanGeneralIdvCrudTambahAPI(MRekanGeneralIdvCrudModel record) async {
		String tambahEndpoint =
			"${AppData.prefixEndPoint}/api/profile/mrekangeneralidvcrud/create";
		Map<String, String> queryParams = {"modul_id": "mRekanGeneralIdvCrudTambahAPI"};
		var uri = AppData.uriHtpp(AppData.httpAuthority, tambahEndpoint, queryParams);

		ReturnDataAPI returnData;
		final http.Response response = await http.post(uri,
			headers: <String, String>{
				'Content-Type': 'application/json; odata=verbos',
				'Accept': 'application/json; odata=verbos',
				'Authorization': 'Bearer ${AppData.userToken}'
			},
			body: jsonEncode(record.toJson()));

		if (response.statusCode == 200) {
			returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
		} else {
			returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
		}
		return returnData;
	}
	Future<bool> mRekanGeneralIdvCrudUbahAPI(MRekanGeneralIdvCrudModel record) async {
		String ubahEndpoint =
			"${AppData.prefixEndPoint}/api/profile/mrekangeneralidvcrud/update";
		Map<String, String> queryParams = {"modul_id": "mRekanGeneralIdvCrudUbahAPI"};

		var uri = AppData.uriHtpp(AppData.httpAuthority, ubahEndpoint, queryParams);

		final http.Response response = await http.post(uri,
			headers: <String, String>{
				'Content-Type': 'application/json; odata=verbos',
				'Accept': 'application/json; odata=verbos',
				'Authorization': 'Bearer ${AppData.userToken}'
			},
			body: jsonEncode(record.toJson()));

		ReturnDataAPI returnData;
		if (response.statusCode == 200) {
			returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
		} else {
			returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
		}
		return returnData.success;
	}
	Future<bool> mRekanGeneralIdvCrudHapusAPI(String mrekan1Id) async {
		String hapusEndpoint = "${AppData.prefixEndPoint}/api/profile/mrekangeneralidvcrud/delete";
		Map<String, String> queryParams = {
			'mrekan1Id': mrekan1Id,
			'modul_id': 'mRekanGeneralIdvCrudHapusAPI'};
		var uri = AppData.uriHtpp(AppData.httpAuthority, hapusEndpoint, queryParams);
		final http.Response response =
			await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		ReturnDataAPI returnData;
		if (response.statusCode == 200) {
			returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
		} else {
			returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
		}
		return returnData.success;
	}
	Future<MRekanGeneralIdvCrudModel> mRekanGeneralIdvCrudLihatAPI(String mrekan1Id) async {
		String lihatEndpoint = "${AppData.prefixEndPoint}/api/profile/mrekangeneralidvcrud/read";
		Map<String, String> queryParams = {'mrekan1Id': mrekan1Id};
		var uri = AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
		final http.Response response =
			await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			var returnData = MRekanGeneralIdvCrudModel.fromJson(jsonDecode(response.body));
			return returnData;
		} else {
			return throw Exception("Failed to load data");
		}
	}
}
