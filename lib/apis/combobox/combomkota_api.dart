import 'dart:convert';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:eassist_tools_app/models/combobox/combomkota_model.dart';

class ComboMKotaAPI {
	Future<List<ComboMKotaModel>> getComboMKotaAPI(String propinsiId) async {
		String urlGetComboEndPoint = "${AppData.prefixEndPoint}/api/mkotacombobox/getlist";
		Map<String, String> queryParams = {"propinsiId": propinsiId};
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetComboEndPoint, queryParams);

		// 🔍 Debug Log
		print("[ComboMKotaAPI] --- MULAI REQUEST ---");
		print("[ComboMKotaAPI] URI: $uri");
		print("[ComboMKotaAPI] Query Params: $queryParams");
		print("[ComboMKotaAPI] Bearer: ${AppData.userToken}");

		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		print("[ComboMKotaAPI] Status Code: ${response.statusCode}");
		print("[ComboMKotaAPI] Raw Body: ${response.body}");

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body);
			print("[ComboMKotaAPI] Decoded JSON: $parsed");

			final list = parsed.cast<Map<String, dynamic>>();
			final result = list.map<ComboMKotaModel>((json) => ComboMKotaModel.fromJson(json)).toList();
			print("[ComboMKotaAPI] Jumlah data: ${result.length}");
			return result;
		} else {
			print("[ComboMKotaAPI] ERROR ${response.statusCode}: ${response.reasonPhrase}");
			throw Exception("Failed to load data");
		}
	}
}
