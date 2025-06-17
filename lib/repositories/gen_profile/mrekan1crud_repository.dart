import 'package:eassist_tools_app/apis/gen_profile/mrekan1crud_api.dart';
import 'package:eassist_tools_app/models/gen_profile/mrekan1crud_model.dart';

class MRekan1CrudRepository {

	MRekan1CrudAPI api = MRekan1CrudAPI();
	
	Future<MRekan1CrudModel> mRekan1CrudLihat() async {
		return await api.mRekan1CrudLihatAPI();
	}
}
