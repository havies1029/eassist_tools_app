import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';

class SimulmbCrudModel {
	int coverBulan;
	double premi;
	double rate;
	String simulmbId;
	double tsi;
	String? rmatauangKode;
	String? currDesc;
	int? thnBuat;
	ComboRMatauangModel? comboRMatauang;

	SimulmbCrudModel({
		this.coverBulan = 0,
		this.premi = 0,
		this.rate = 0,
		this.simulmbId = '',
		this.tsi = 0,
		this.rmatauangKode = '',
		this.comboRMatauang,
		this.currDesc = '',});

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
			// currDesc: data['currDesc'] ?? 'IDR',
				currDesc: data['currDesc'] ?? 'IDR',
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
		'currDesc': currDesc,
		'comboRMatauang': comboRMatauang?.toJson()};

}
