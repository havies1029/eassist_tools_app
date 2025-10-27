import 'package:eassist_tools_app/models/responseAPI/returndataapi_model.dart';
import 'package:eassist_tools_app/apis/gen_compro/reqcompro_api.dart';
import 'package:eassist_tools_app/models/gen_compro/reqcompro_model.dart';

class ReqComproRepository {

	ReqComproAPI api = ReqComproAPI();

	Future<ReturnDataAPI> reqComproTambah(ReqComproModel record) async {
		return await api.reqComproTambahAPI(record);
	}	
}
