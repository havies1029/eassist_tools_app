import 'dart:convert';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/simultree/simultreecrud_model.dart';

class SimultreeCrudAPI {

	Future<ReturnDataAPI> simultreeCrudTambahAPI(SimultreeCrudModel record) async {
		String tambahEndpoint =
			"${AppData.prefixEndPoint}/api/simultree/simultreecrud/create";
		Map<String, String> queryParams = {"modul_id": "simultreeCrudTambahAPI"};
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
	Future<bool> simultreeCrudUbahAPI(SimultreeCrudModel record) async {
		String ubahEndpoint =
			"${AppData.prefixEndPoint}/api/simultree/simultreecrud/update";
		Map<String, String> queryParams = {"modul_id": "simultreeCrudUbahAPI"};

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
	Future<bool> simultreeCrudHapusAPI(String simultreeId) async {
		String hapusEndpoint = "${AppData.prefixEndPoint}/api/simultree/simultreecrud/delete";
		Map<String, String> queryParams = {
			'simultreeId': simultreeId,
			'modul_id': 'simultreeCrudHapusAPI'};
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
	Future<SimultreeCrudModel> simultreeCrudLihatAPI(String simultreeId) async {
		String lihatEndpoint = "${AppData.prefixEndPoint}/api/simultree/simultreecrud/read";
		Map<String, String> queryParams = {'simultreeId': simultreeId};
		var uri = AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
		final http.Response response =
			await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			var returnData = SimultreeCrudModel.fromJson(jsonDecode(response.body));
			return returnData;
		} else {
			return throw Exception("Failed to load data");
		}
	}

	Future<SimultreeCrudModel> simultreeCrudInitValueAPI() async {
		String initValueEndpoint =
				"${AppData.prefixEndPoint}/api/simultree/simultreecrud/initvalue";
		var uri = AppData.uriHtpp(AppData.httpAuthority, initValueEndpoint);
		final http.Response response =
		await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			var returnData = SimultreeCrudModel.fromJson(jsonDecode(response.body));
			return returnData;
		} else {
			return throw Exception("Failed to load data");
		}
	}

	Future<ReturnDataAPI> simultreeCrudCalcPremiAPI(
			SimultreeCrudModel record) async {
		String tambahEndpoint =
				"${AppData.prefixEndPoint}/api/simultree/simultreecrud/calcpremi";
		Map<String, String> queryParams = {"modul_id": "simultreeCrudCalcPremiAPI"};
		var uri =
		AppData.uriHtpp(AppData.httpAuthority, tambahEndpoint, queryParams);

		ReturnDataAPI returnData;
		final http.Response response = await http.post(uri,
				headers: <String, String>{
					'Content-Type': 'application/json; odata=verbos',
					'Accept': 'application/json; odata=verbos',
					'Authorization': 'Bearer ${AppData.userToken}'
				},
				body: jsonEncode(record.toJson()));

		//debugPrint("response.statusCode : ${response.statusCode}");
		//debugPrint("response.body : ${response.body}");

		if (response.statusCode == 200) {
			returnData = ReturnDataAPI.fromDatabaseJson(jsonDecode(response.body));
		} else {
			returnData = ReturnDataAPI(success: false, data: "", rowcount: 0);
		}
		return returnData;
	}
}
