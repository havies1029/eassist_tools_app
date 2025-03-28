import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';

class SimulgitCrudModel {
	int coverBulan;
	double premi;
	double rate;
	String simulgitId;
	double tsi;
	String? rmatauangKode;
	ComboRMatauangModel? comboRMatauang;

	SimulgitCrudModel({required this.coverBulan, required this.premi, 
		required this.rate, required this.simulgitId, 
		required this.tsi, this.rmatauangKode, this.comboRMatauang});

	factory SimulgitCrudModel.fromJson(Map<String, dynamic> data) {
		ComboRMatauangModel? comboRMatauang;
		if (data['comboRMatauang'] != null) {
			comboRMatauang = ComboRMatauangModel.fromJson(data['comboRMatauang']);
		}

		return SimulgitCrudModel(
			coverBulan: int.tryParse(data['coverBulan'].toString())??0,
			premi: double.tryParse(data['premi'].toString())??0,
			rate: double.tryParse(data['rate'].toString())??0,
			simulgitId: data['simulgitId']??'',
			tsi: double.tryParse(data['tsi'].toString())??0,
			rmatauangKode: data['rmatauangKode']??'',
			comboRMatauang: comboRMatauang
		);

	}

	Map<String, dynamic> toJson() =>
		{'coverBulan': coverBulan.toString(),
		'premi': premi.toString(),
		'rate': rate.toString(),
		'simulgitId': simulgitId,
		'tsi': tsi.toString(),
		'rmatauangKode': rmatauangKode,
		'comboRMatauang': comboRMatauang?.toJson()};

}
