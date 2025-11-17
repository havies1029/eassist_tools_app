import 'package:eassist_tools_app/models/combobox/combomkabzonagempa_model.dart';
import 'package:eassist_tools_app/models/combobox/combomjnscoverpar_model.dart';
import 'package:eassist_tools_app/models/combobox/combomwilayah_model.dart';

class Calpar3FormModel {
	String calpar3Id;
	bool isEq;
	double rateEqvet;
	double rateOther;
	double ratePar;
	double rateRsmdcc;
	double rateTotal;
	double rateTsfwd;
	String? kab2zonagempaId;
	ComboMKabZonaGempaModel? comboMKabZonaGempa;
	String? mjnscoverparId;
	ComboMJnscoverParModel? comboMJnscoverPar;
	String? mwilayahId;
	ComboMWilayahModel? comboMWilayah;

	Calpar3FormModel({required this.calpar3Id, required this.isEq, 
		required this.rateEqvet, required this.rateOther, 
		required this.ratePar, required this.rateRsmdcc, 
		required this.rateTotal, required this.rateTsfwd, 
		this.kab2zonagempaId, this.comboMKabZonaGempa, this.mjnscoverparId, this.comboMJnscoverPar, 
		this.mwilayahId, this.comboMWilayah});

	factory Calpar3FormModel.fromJson(Map<String, dynamic> data) {
		ComboMKabZonaGempaModel? comboMKabZonaGempa;
		if (data['comboMKabZonaGempa'] != null) {
			comboMKabZonaGempa = ComboMKabZonaGempaModel.fromJson(data['comboMKabZonaGempa']);
		}

		ComboMJnscoverParModel? comboMJnscoverPar;
		if (data['comboMJnscoverPar'] != null) {
			comboMJnscoverPar = ComboMJnscoverParModel.fromJson(data['comboMJnscoverPar']);
		}

		ComboMWilayahModel? comboMWilayah;
		if (data['comboMWilayah'] != null) {
			comboMWilayah = ComboMWilayahModel.fromJson(data['comboMWilayah']);
		}

		return Calpar3FormModel(
			calpar3Id: data['calpar3Id']??'',
			isEq: data['isEq']??'',
			rateEqvet: double.tryParse(data['rateEqvet'].toString())??0,
			rateOther: double.tryParse(data['rateOther'].toString())??0,
			ratePar: double.tryParse(data['ratePar'].toString())??0,
			rateRsmdcc: double.tryParse(data['rateRsmdcc'].toString())??0,
			rateTotal: double.tryParse(data['rateTotal'].toString())??0,
			rateTsfwd: double.tryParse(data['rateTsfwd'].toString())??0,
			kab2zonagempaId: data['kab2zonagempaId']??'',
			comboMKabZonaGempa: comboMKabZonaGempa,
			mjnscoverparId: data['mjnscoverparId']??'',
			comboMJnscoverPar: comboMJnscoverPar,
			mwilayahId: data['mwilayahId']??'',
			comboMWilayah: comboMWilayah
		);

	}

	Map<String, dynamic> toJson() =>
		{'calpar3Id': calpar3Id,
		'isEq': isEq,
		'rateEqvet': rateEqvet.toString(),
		'rateOther': rateOther.toString(),
		'ratePar': ratePar.toString(),
		'rateRsmdcc': rateRsmdcc.toString(),
		'rateTotal': rateTotal.toString(),
		'rateTsfwd': rateTsfwd.toString(),
		'kab2zonagempaId': kab2zonagempaId,
		'comboMKabZonaGempa': comboMKabZonaGempa?.toJson(),
		'mjnscoverparId': mjnscoverparId,
		'comboMJnscoverPar': comboMJnscoverPar?.toJson(),
		'mwilayahId': mwilayahId,
		'comboMWilayah': comboMWilayah?.toJson()};

}
