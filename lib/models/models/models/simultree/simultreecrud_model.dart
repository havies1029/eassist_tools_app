import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';

class SimultreeCrudModel {
	int? coverBulan;
	double? rate;
	String? simultreeId;
	double? tsi;
	String? rmatauangKode;
	double? premi;
	String? currDesc;
	int? thnBuat;
	ComboRMatauangModel? comboRMatauang;

	SimultreeCrudModel({
		this.coverBulan = 0,
		this.premi = 0,
		this.rate = 0,
		this.simultreeId = '',
		this.tsi = 0,
		this.rmatauangKode = '',
		this.comboRMatauang,
		this.currDesc = '',
	});


	factory SimultreeCrudModel.fromJson(Map<String, dynamic> data) {
		ComboRMatauangModel? comboRMatauang;
		if (data['comboRMatauang'] != null) {
			comboRMatauang = ComboRMatauangModel.fromJson(data['comboRMatauang']);
		}

		return SimultreeCrudModel(
				coverBulan: int.tryParse(data['coverBulan'].toString())??0,
				premi: double.tryParse(data['premi'].toString())??0,
				rate: double.tryParse(data['rate'].toString())??0,
				simultreeId: data['simultreeId']??'',
				tsi: double.tryParse(data['tsi'].toString())??0,
				rmatauangKode: data['rmatauangKode']??'',
				currDesc: data['currDesc'] ?? 'IDR',
				comboRMatauang: comboRMatauang
		);

	}

	Map<String, dynamic> toJson() =>
			{'coverBulan': coverBulan.toString(),
				'premi': premi.toString(),
				'rate': rate.toString(),
				'simultreeId': simultreeId,
				'tsi': tsi.toString(),
				'rmatauangKode': rmatauangKode,
				'currDesc': currDesc,
				'comboRMatauang': comboRMatauang?.toJson()};

}
