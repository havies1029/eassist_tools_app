//generate from : usp_flutter_crud_api

import 'dart:convert';
import 'dart:io';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/perbaruiklaimpar/klaim5parcrud_model.dart';

class Klaim5parCrudAPI {

	Future<ReturnDataAPI> klaim5parCrudTambahAPI(Klaim5parCrudModel record) async {
		String tambahEndpoint =
			"${AppData.prefixEndPoint}/api/perbaruiklaimpar/klaim5parcrud/create";
		Map<String, String> queryParams = {"modul_id": "klaim5parCrudTambahAPI"};
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
	Future<bool> klaim5parCrudUbahAPI(Klaim5parCrudModel record) async {
		String ubahEndpoint =
			"${AppData.prefixEndPoint}/api/perbaruiklaimpar/klaim5parcrud/update";
		Map<String, String> queryParams = {"modul_id": "klaim5parCrudUbahAPI"};

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
	Future<bool> klaim5parCrudHapusAPI(String klaim5Id) async {
		String hapusEndpoint = "${AppData.prefixEndPoint}/api/perbaruiklaimpar/klaim5parcrud/delete";
		Map<String, String> queryParams = {
			'klaim5Id': klaim5Id,
			'modul_id': 'klaim5parCrudHapusAPI'};
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
	Future<Klaim5parCrudModel?> klaim5parCrudLihatAPI(String klaim5Id) async {
		String lihatEndpoint = "${AppData.prefixEndPoint}/api/perbaruiklaimpar/klaim5parcrud/read";
		Map<String, String> queryParams = {'klaim5Id': klaim5Id};
		var uri = AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
		try{
			final http.Response response =
				await http.get(uri, headers: <String, String>{
				'Content-Type': 'application/json; odata=verbos',
				'Accept': 'application/json; odata=verbos',
				'Authorization': 'Bearer ${AppData.userToken}'
			});

			if (response.statusCode == 200) {
				var returnData = Klaim5parCrudModel.fromJson(jsonDecode(response.body));
				return returnData;
			}
			if (response.statusCode == 404) {
				return null;
			}
			throw HttpException('HTTP ${response.statusCode}: ${response.body}');
		} catch (e) {
			throw Exception("Failed to load data: $e");
		}
	}
}
