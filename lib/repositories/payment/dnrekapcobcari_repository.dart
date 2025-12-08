import 'package:eassist_tools_app/apis/payment/dnrekapcobcari_api.dart';
import 'package:eassist_tools_app/models/payment/dnrekapcobcari_model.dart';

class DnrekapcobCariRepository {

	Future<List<DnrekapcobCariModel>> getDnrekapcobCari() async {
		DnrekapcobCariAPI api = DnrekapcobCariAPI();
		return await api.getDnrekapcobCariAPI();
	}
}
