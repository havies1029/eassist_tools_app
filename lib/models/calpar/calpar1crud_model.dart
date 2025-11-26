import 'package:eassist_tools_app/models/combobox/comborkonstruksiojk_model.dart';
import 'package:eassist_tools_app/models/combobox/comborokupasi_model.dart';

class Calpar1CrudModel {
	String calpar1Id;
	int coverBulan;
	String? rkonstruksiojkId;
	ComboRKonstruksiojkModel? comboRKonstruksiojk;
	String? rokupasiId;
	ComboROkupasiModel? comboROkupasi;

	Calpar1CrudModel({required this.calpar1Id, required this.coverBulan, 
		this.rkonstruksiojkId, this.comboRKonstruksiojk, this.rokupasiId, this.comboROkupasi});

	factory Calpar1CrudModel.fromJson(Map<String, dynamic> data) {
		ComboRKonstruksiojkModel? comboRKonstruksiojk;
		if (data['comboRKonstruksiojk'] != null) {
			comboRKonstruksiojk = ComboRKonstruksiojkModel.fromJson(data['comboRKonstruksiojk']);
		}

		ComboROkupasiModel? comboROkupasi;
		if (data['comboROkupasi'] != null) {
			comboROkupasi = ComboROkupasiModel.fromJson(data['comboROkupasi']);
		}

		return Calpar1CrudModel(
			calpar1Id: data['calpar1Id']??'',
			coverBulan: int.tryParse(data['coverBulan'].toString())??0,
			rkonstruksiojkId: data['rkonstruksiojkId']??'',
			comboRKonstruksiojk: comboRKonstruksiojk,
			rokupasiId: data['rokupasiId']??'',
			comboROkupasi: comboROkupasi
		);

	}

	Map<String, dynamic> toJson() =>
		{'calpar1Id': calpar1Id,
		'coverBulan': coverBulan.toString(),
		'rkonstruksiojkId': rkonstruksiojkId,
		'comboRKonstruksiojk': comboRKonstruksiojk?.toJson(),
		'rokupasiId': rokupasiId,
		'comboROkupasi': comboROkupasi?.toJson()};

}
