import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';

class SimultreeCrudModel {
	int coverBulan;
	double premi;
	double rate;
	double si1;
	double si2;
	String simultreeId;
	double tsi;
	String? rmatauangKode;
	ComboRMatauangModel? comboRMatauang;

	SimultreeCrudModel({required this.coverBulan, required this.premi, 
		required this.rate, required this.si1, 
		required this.si2, required this.simultreeId, 
		required this.tsi, this.rmatauangKode, this.comboRMatauang});

	factory SimultreeCrudModel.fromJson(Map<String, dynamic> data) {
		ComboRMatauangModel? comboRMatauang;
		if (data['comboRMatauang'] != null) {
			comboRMatauang = ComboRMatauangModel.fromJson(data['comboRMatauang']);
		}

		return SimultreeCrudModel(
			coverBulan: int.tryParse(data['coverBulan'].toString())??0,
			premi: double.tryParse(data['premi'].toString())??0,
			rate: double.tryParse(data['rate'].toString())??0,
			si1: double.tryParse(data['si1'].toString())??0,
			si2: double.tryParse(data['si2'].toString())??0,
			simultreeId: data['simultreeId']??'',
			tsi: double.tryParse(data['tsi'].toString())??0,
			rmatauangKode: data['rmatauangKode']??'',
			comboRMatauang: comboRMatauang
		);

	}

	Map<String, dynamic> toJson() =>
		{'coverBulan': coverBulan.toString(),
		'premi': premi.toString(),
		'rate': rate.toString(),
		'si1': si1.toString(),
		'si2': si2.toString(),
		'simultreeId': simultreeId,
		'tsi': tsi.toString(),
		'rmatauangKode': rmatauangKode,
		'comboRMatauang': comboRMatauang?.toJson()};

}
