import 'dart:convert';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/simulcargo/simulcargocrud_model.dart';

class SimulcargoCrudAPI {

	Future<ReturnDataAPI> simulcargoCrudTambahAPI(SimulcargoCrudModel record) async {
		String tambahEndpoint =
			"${AppData.prefixEndPoint}/api/simulcargo/simulcargocrud/create";
		Map<String, String> queryParams = {"modul_id": "simulcargoCrudTambahAPI"};
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
	Future<bool> simulcargoCrudUbahAPI(SimulcargoCrudModel record) async {
		String ubahEndpoint =
			"${AppData.prefixEndPoint}/api/simulcargo/simulcargocrud/update";
		Map<String, String> queryParams = {"modul_id": "simulcargoCrudUbahAPI"};

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
	Future<bool> simulcargoCrudHapusAPI(String simulcargoId) async {
		String hapusEndpoint = "${AppData.prefixEndPoint}/api/simulcargo/simulcargocrud/delete";
		Map<String, String> queryParams = {
			'simulcargoId': simulcargoId,
			'modul_id': 'simulcargoCrudHapusAPI'};
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
	Future<SimulcargoCrudModel> simulcargoCrudLihatAPI(String simulcargoId) async {
		String lihatEndpoint = "${AppData.prefixEndPoint}/api/simulcargo/simulcargocrud/read";
		Map<String, String> queryParams = {'simulcargoId': simulcargoId};
		var uri = AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
		final http.Response response =
			await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			var returnData = SimulcargoCrudModel.fromJson(jsonDecode(response.body));
			return returnData;
		} else {
			return throw Exception("Failed to load data");
		}
	}

  Future<SimulcargoCrudModel> simulCargoCrudInitValueAPI() async {
    String initValueEndpoint =
        "${AppData.prefixEndPoint}/api/simulcargo/simulcargocrud/initvalue";
    var uri = AppData.uriHtpp(AppData.httpAuthority, initValueEndpoint);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    if (response.statusCode == 200) {
      var returnData = SimulcargoCrudModel.fromJson(jsonDecode(response.body));
      return returnData;
    } else {
      return throw Exception("Failed to load data");
    }
  }

  Future<ReturnDataAPI> simulCargoCrudCalcPremiAPI(
      SimulcargoCrudModel record) async {
    String tambahEndpoint =
        "${AppData.prefixEndPoint}/api/simulcargo/simulcargocrud/calcpremi";
    Map<String, String> queryParams = {"modul_id": "simulCargoCrudCalcPremiAPI"};
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
