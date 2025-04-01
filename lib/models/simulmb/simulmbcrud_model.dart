import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';

class SimulmbCrudModel {
	int coverBulan;
	double premi;
	double rate;
	String simulmbId;
	double tsi;
	String? rmatauangKode;
	ComboRMatauangModel? comboRMatauang;

	SimulmbCrudModel({required this.coverBulan, required this.premi, 
		required this.rate, required this.simulmbId, 
		required this.tsi, this.rmatauangKode, this.comboRMatauang});

	factory SimulmbCrudModel.fromJson(Map<String, dynamic> data) {
		ComboRMatauangModel? comboRMatauang;
		if (data['comboRMatauang'] != null) {
			comboRMatauang = ComboRMatauangModel.fromJson(data['comboRMatauang']);
		}

		return SimulmbCrudModel(
			coverBulan: int.tryParse(data['coverBulan'].toString())??0,
			premi: double.tryParse(data['premi'].toString())??0,
			rate: double.tryParse(data['rate'].toString())??0,
			simulmbId: data['simulmbId']??'',
			tsi: double.tryParse(data['tsi'].toString())??0,
			rmatauangKode: data['rmatauangKode']??'',
			comboRMatauang: comboRMatauang
		);

	}

	Map<String, dynamic> toJson() =>
		{'coverBulan': coverBulan.toString(),
		'premi': premi.toString(),
		'rate': rate.toString(),
		'simulmbId': simulmbId,
		'tsi': tsi.toString(),
		'rmatauangKode': rmatauangKode,
		'comboRMatauang': comboRMatauang?.toJson()};

}
