import 'package:eassist_tools_app/apis/simulmv/calcpremimv_api.dart';
import 'package:eassist_tools_app/models/simulmv/calcpremimv_model.dart';
import 'package:eassist_tools_app/models/simulmv/simulmvcrud_model.dart';

class CalcPremiMvRepository {

	Future<CalcPremiMvModel> getCalcPremiMv(SimulmvCrudModel record) async {
		CalcPremiMvAPI api = CalcPremiMvAPI();
		return await api.calcPremiMVAPI(record);
	}
}
