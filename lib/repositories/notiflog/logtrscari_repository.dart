import 'package:eassist_tools_app/apis/notiflog/logtrscari_api.dart';
import 'package:eassist_tools_app/models/notiflog/logtrscari_model.dart';

class LogtrscariRepository {

	Future<List<LogtrscariModel>> getLogtrscari(String groupLogId, int hal) async {
		LogtrscariAPI api = LogtrscariAPI();
		return await api.getLogtrscariAPI(groupLogId, hal);
	}

  Future<List<LogtrscariModel>> getLogtrscaritopx() async {
    LogtrscariAPI api = LogtrscariAPI();
    return await api.getLogtrscaritopxAPI();
  }
}
