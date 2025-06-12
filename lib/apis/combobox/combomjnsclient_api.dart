import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:http/http.dart' as http;
import 'package:eassist_tools_app/models/combobox/combomjnsclient_model.dart';

class ComboMJnsclientAPI {
  Future<List<ComboMJnsclientModel>> getComboMJnsclientAPI() async {
    String urlGetComboEndPoint = "${AppData.prefixEndPoint}/api/mjnsclientcombobox/getlist";
    var uri = AppData.uriHtpp(AppData.httpAuthority, urlGetComboEndPoint);

    final String token = AppData.userToken;
    debugPrint('🌐 GET ComboMJnsclient ke: $uri');
    debugPrint('🔐 Token: ${token.length > 10 ? token.substring(0, 10) + '...' : token}');

    try {
      final http.Response response = await http.get(uri, headers: <String, String>{
        'Content-Type': 'application/json; odata=verbos',
        'Accept': 'application/json; odata=verbos',
        'Authorization': 'Bearer $token',
      });

      debugPrint('📥 Status Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        debugPrint('✅ Data MJnsclient diterima (${parsed.length} item)');
        return parsed
            .map<ComboMJnsclientModel>((json) => ComboMJnsclientModel.fromJson(json))
            .toList();
      } else {
        debugPrint('❌ Gagal mengambil data MJnsclient.');
        debugPrint('   ↪ Response body: ${response.body}');
        throw Exception("Failed to load data");
      }
    } catch (e, stacktrace) {
      debugPrint('❗ Exception saat GET ComboMJnsclient: $e');
      debugPrint('📌 Stacktrace: $stacktrace');
      throw Exception("Failed to load data");
    }
  }
}
