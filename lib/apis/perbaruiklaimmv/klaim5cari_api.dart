import 'dart:convert';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:eassist_tools_app/models/perbaruiklaimmv/klaim5cari_model.dart';

class Klaim5cariAPI{
	Future<List<Klaim5cariModel>> getKlaim5cariAPI(String klaim1Id) async {
		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/perbaruiklaimmv/klaim5cari/getlist";
    
		Map<String, String> queryParams = {'klaim1Id': klaim1Id};
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams);
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<Klaim5cariModel>((json) => Klaim5cariModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
