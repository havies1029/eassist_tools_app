import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';

class SimulwpCrudModel {
	int coverBulan;
	double plafond;
	double premi;
	double rate;
	String simulwp1Id;
	int usia;
	String? rmatauangKode;
	ComboRMatauangModel? comboRMatauang;

	SimulwpCrudModel({required this.coverBulan, required this.plafond, 
		required this.premi, required this.rate, 
		required this.simulwp1Id, required this.usia, 
		this.rmatauangKode, this.comboRMatauang});

	factory SimulwpCrudModel.fromJson(Map<String, dynamic> data) {
		ComboRMatauangModel? comboRMatauang;
		if (data['comboRMatauang'] != null) {
			comboRMatauang = ComboRMatauangModel.fromJson(data['comboRMatauang']);
		}

		return SimulwpCrudModel(
			coverBulan: int.tryParse(data['coverBulan'].toString())??0,
			plafond: double.tryParse(data['plafond'].toString())??0,
			premi: double.tryParse(data['premi'].toString())??0,
			rate: double.tryParse(data['rate'].toString())??0,
			simulwp1Id: data['simulwp1Id']??'',
			usia: int.tryParse(data['usia'].toString())??0,
			rmatauangKode: data['rmatauangKode']??'',
			comboRMatauang: comboRMatauang
		);

	}

	Map<String, dynamic> toJson() =>
		{'coverBulan': coverBulan.toString(),
		'plafond': plafond.toString(),
		'premi': premi.toString(),
		'rate': rate.toString(),
		'simulwp1Id': simulwp1Id,
		'usia': usia.toString(),
		'rmatauangKode': rmatauangKode,
		'comboRMatauang': comboRMatauang?.toJson()};

}
