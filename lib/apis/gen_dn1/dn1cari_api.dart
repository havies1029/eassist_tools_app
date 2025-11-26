import 'dart:convert';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:eassist_tools_app/models/gen_dn1/dn1cari_model.dart';

class Dn1CariAPI{
	Future<List<Dn1CariModel>> getDn1CariAPI(String sppa1Id) async {
		String urlGetListEndPoint = "${AppData.prefixEndPoint}/api/dn/dn1cari/getlist";
   
		Map<String, String> queryParams = {"sppa1Id": sppa1Id};
		var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetListEndPoint, queryParams); 
		final http.Response response = await http.get(uri, headers: <String, String>{
			'Content-Type': 'application/json; odata=verbos',
			'Accept': 'application/json; odata=verbos',
			'Authorization': 'Bearer ${AppData.userToken}'
		});

		if (response.statusCode == 200) {
			final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
			return parsed
				.map<Dn1CariModel>((json) => Dn1CariModel.fromJson(json))
				.toList();
		} else {
			throw Exception("Failed to load data");
		}
	}
}
