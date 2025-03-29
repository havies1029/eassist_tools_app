import 'dart:convert';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/models/simulgis/simulgiscrud_model.dart';

class SimulgisCrudAPI {

	Future<ReturnDataAPI> simulgisCrudTambahAPI(SimulgisCrudModel record) async {
		String tambahEndpoint =
			"${AppData.prefixEndPoint}/api/simulgis/simulgiscrud/create";
		Map<String, String> queryParams = {"modul_id": "simulgisCrudTambahAPI"};
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
	Future<bool> simulgisCrudUbahAPI(SimulgisCrudModel record) async {
		String ubahEndpoint =
			"${AppData.prefixEndPoint}/api/simulgis/simulgiscrud/update";
		Map<String, String> queryParams = {"modul_id": "simulgisCrudUbahAPI"};

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
	Future<bool> simulgisCrudHapusAPI(String simulgisId) async {
		String hapusEndpoint = "${AppData.prefixEndPoint}/api/simulgis/simulgiscrud/delete";
		Map<String, String> queryParams = {
			'simulgisId': simulgisId,
			'modul_id': 'simulgisCrudHapusAPI'};
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
	Future<SimulgisCrudModel> simulgisCrudLihatAPI(String simulgisId) async {
		String lihatEndpoint = "${AppData.prefixEndPoint}/api/simulgis/simulgiscrud/read";
		Map<String, String> queryParams = {'simulgisId': simulgisId};
		var uri = AppData.uriHtpp(AppData.httpAuthority, lihatEndpoint, queryParams);
		final http.Response response =
			await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			var returnData = SimulgisCrudModel.fromJson(jsonDecode(response.body));
			return returnData;
		} else {
			return throw Exception("Failed to load data");
		}
	}

  Future<SimulgisCrudModel> simulGisCrudInitValueAPI() async {
    String initValueEndpoint =
        "${AppData.prefixEndPoint}/api/simulgis/simulgiscrud/initvalue";
    var uri = AppData.uriHtpp(AppData.httpAuthority, initValueEndpoint);
    final http.Response response =
        await http.get(uri, headers: <String, String>{
      'Content-Type': 'application/json; odata=verbos',
      'Accept': 'application/json; odata=verbos',
      'Authorization': 'Bearer ${AppData.userToken}'
    });

    if (response.statusCode == 200) {
      var returnData = SimulgisCrudModel.fromJson(jsonDecode(response.body));
      return returnData;
    } else {
      return throw Exception("Failed to load data");
    }
  }

  Future<ReturnDataAPI> simulGisCrudCalcPremiAPI(
      SimulgisCrudModel record) async {
    String tambahEndpoint =
        "${AppData.prefixEndPoint}/api/simulgis/simulgiscrud/calcpremi";
    Map<String, String> queryParams = {"modul_id": "simulGisCrudCalcPremiAPI"};
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
