import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';

class Calpar2FormModel {
	String calpar2Id;
	double siBuilding;
	double siContent;
	double siMachinery;
	double siOther;
	double siStock;
	String? rmatauangKode;
	ComboRMatauangModel? comboRMatauang;

	Calpar2FormModel({required this.calpar2Id, required this.siBuilding, 
		required this.siContent, required this.siMachinery, 
		required this.siOther, required this.siStock, 
		this.rmatauangKode, this.comboRMatauang});

	factory Calpar2FormModel.fromJson(Map<String, dynamic> data) {
		ComboRMatauangModel? comboRMatauang;
		if (data['comboRMatauang'] != null) {
			comboRMatauang = ComboRMatauangModel.fromJson(data['comboRMatauang']);
		}

		return Calpar2FormModel(
			calpar2Id: data['calpar2Id']??'',
			siBuilding: double.tryParse(data['siBuilding'].toString())??0,
			siContent: double.tryParse(data['siContent'].toString())??0,
			siMachinery: double.tryParse(data['siMachinery'].toString())??0,
			siOther: double.tryParse(data['siOther'].toString())??0,
			siStock: double.tryParse(data['siStock'].toString())??0,
			rmatauangKode: data['rmatauangKode']??'',
			comboRMatauang: comboRMatauang
		);

	}

	Map<String, dynamic> toJson() =>
		{'calpar2Id': calpar2Id,
		'siBuilding': siBuilding.toString(),
		'siContent': siContent.toString(),
		'siMachinery': siMachinery.toString(),
		'siOther': siOther.toString(),
		'siStock': siStock.toString(),
		'rmatauangKode': rmatauangKode,
		'comboRMatauang': comboRMatauang?.toJson()};

}
