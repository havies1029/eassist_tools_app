import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';

class SimulgisCrudModel {
	int? coverBulan;
	double? premi;
	double? rate;
	String? simulgisId;
	double? tsi;
	String? rmatauangKode;
	ComboRMatauangModel? comboRMatauang;

	SimulgisCrudModel({this.coverBulan, this.premi, 
		this.rate, this.simulgisId, 
		this.tsi, this.rmatauangKode, this.comboRMatauang});

	factory SimulgisCrudModel.fromJson(Map<String, dynamic> data) {
		ComboRMatauangModel? comboRMatauang;
		if (data['comboRMatauang'] != null) {
			comboRMatauang = ComboRMatauangModel.fromJson(data['comboRMatauang']);
		}

		return SimulgisCrudModel(
			coverBulan: int.tryParse(data['coverBulan'].toString())??0,
			premi: double.tryParse(data['premi'].toString())??0,
			rate: double.tryParse(data['rate'].toString())??0,
			simulgisId: data['simulgisId']??'',
			tsi: double.tryParse(data['tsi'].toString())??0,
			rmatauangKode: data['rmatauangKode']??'',
			comboRMatauang: comboRMatauang
		);

	}

	Map<String, dynamic> toJson() =>
		{'coverBulan': coverBulan.toString(),
		'premi': premi.toString(),
		'rate': rate.toString(),
		'simulgisId': simulgisId,
		'tsi': tsi.toString(),
		'rmatauangKode': rmatauangKode,
		'comboRMatauang': comboRMatauang?.toJson()};

}
