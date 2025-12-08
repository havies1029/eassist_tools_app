import 'package:eassist_tools_app/apis/payment/dnsppacari_api.dart';
import 'package:eassist_tools_app/models/payment/dnsppacari_model.dart';

class DnsppaCariRepository {

	Future<List<DnsppaCariModel>> getDnsppaCari(String cobId, String currId, String searchText, int hal) async {
		DnsppaCariAPI api = DnsppaCariAPI();
		return await api.getDnsppaCariAPI(cobId, currId, searchText, hal);
	}
}
