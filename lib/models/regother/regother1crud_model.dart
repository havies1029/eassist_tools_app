import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';

class Regother1CrudModel {
	String regother1Id;
	String remark;
	double tsi;
	String? currId;
	ComboRMatauangModel? comboRMatauang;

	Regother1CrudModel({required this.regother1Id, required this.remark, 
		required this.tsi, this.currId, this.comboRMatauang});

	factory Regother1CrudModel.fromJson(Map<String, dynamic> data) {
		ComboRMatauangModel? comboRMatauang;
		if (data['comboRMatauang'] != null) {
			comboRMatauang = ComboRMatauangModel.fromJson(data['comboRMatauang']);
		}

		return Regother1CrudModel(
			regother1Id: data['regother1Id']??'',
			remark: data['remark']??'',
			tsi: double.tryParse(data['tsi'].toString())??0,
			currId: data['currId']??'',
			comboRMatauang: comboRMatauang
		);

	}

	Map<String, dynamic> toJson() =>
		{'regother1Id': regother1Id,
		'remark': remark,
		'tsi': tsi.toString(),
		'currId': currId,
		'comboRMatauang': comboRMatauang?.toJson()};

}
