
import 'package:eassist_tools_app/models/combobox/combombank_model.dart';

class MRekanBankCrudModel {
	String mrekan1Id;
	String mrekanbankId;
	String rekNama;
	String rekNo;
	ComboMBankModel? comboMBank;

	MRekanBankCrudModel({required this.mrekan1Id, required this.mrekanbankId, 
		required this.rekNama, required this.rekNo, ComboMBankModel? comboMBank});

	factory MRekanBankCrudModel.fromJson(Map<String, dynamic> data) {
    ComboMBankModel? comboMBank;
		if (data['comboMBank'] != null) {
			comboMBank = ComboMBankModel.fromJson(data['comboMBank']);
		}

		return MRekanBankCrudModel(
			mrekan1Id: data['mrekan1Id']??'',
			mrekanbankId: data['mrekanbankId']??'',
			rekNama: data['rekNama']??'',
			rekNo: data['rekNo']??'',
      comboMBank: comboMBank
		);

	}

	Map<String, dynamic> toJson() =>
		{'mrekan1Id': mrekan1Id,
		'mrekanbankId': mrekanbankId,
		'rekNama': rekNama,
		'rekNo': rekNo,
    'comboMBank': comboMBank?.toJson()};

}
