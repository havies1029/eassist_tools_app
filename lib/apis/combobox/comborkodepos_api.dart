import 'dart:convert';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:eassist_tools_app/models/combobox/comborkodepos_model.dart';

class ComboRKodeposAPI {
	Future<List<ComboRKodeposModel>> getComboRKodeposAPI(String kotaId, String filter) async {
		String urlGetComboEndPoint = "${AppData.prefixEndPoint}/api/rkodeposcombobox/getlist";

		Map<String, String> queryParams = {"kotaId": kotaId, "filter": filter};
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetComboEndPoint, queryParams);

		// 🔍 Debug Lengkap
		print("[ComboRKodeposAPI] --- MULAI REQUEST ---");
		print("[ComboRKodeposAPI] URI: $uri");
		print("[ComboRKodeposAPI] Query Params: $queryParams");
		print("[ComboRKodeposAPI] Bearer: ${AppData.userToken}");

		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		print("[ComboRKodeposAPI] Status Code: ${response.statusCode}");
		print("[ComboRKodeposAPI] Raw Body: ${response.body}");

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body);
			print("[ComboRKodeposAPI] Decoded JSON: $parsed");

			final list = parsed.cast<Map<String, dynamic>>();
			final result = list.map<ComboRKodeposModel>((json) => ComboRKodeposModel.fromJson(json)).toList();
			print("[ComboRKodeposAPI] Jumlah data: ${result.length}");
			return result;
		} else {
			print("[ComboRKodeposAPI] ERROR: ${response.statusCode} ${response.reasonPhrase}");
			throw Exception("Failed to load data");
		}
	}

}
