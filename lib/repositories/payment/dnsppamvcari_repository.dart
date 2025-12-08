import 'package:eassist_tools_app/apis/payment/dnsppamvcari_api.dart';
import 'package:eassist_tools_app/models/payment/dnsppamvcari_model.dart';

class DnsppamvCariRepository {

	Future<List<DnsppamvCariModel>> getDnsppamvCari(String sppa1Id, String searchText, int hal) async {
		DnsppamvCariAPI api = DnsppamvCariAPI();
		return await api.getDnsppamvCariAPI(sppa1Id, searchText, hal);
	}
}
