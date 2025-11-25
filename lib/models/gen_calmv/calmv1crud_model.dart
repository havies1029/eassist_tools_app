import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';
import 'package:eassist_tools_app/models/combobox/combommvgrupojk_model.dart';
import 'package:eassist_tools_app/models/combobox/combommvjnscover_model.dart';
import 'package:eassist_tools_app/models/combobox/combommvpakai_model.dart';
import 'package:eassist_tools_app/models/combobox/combomwilayah_model.dart';

class Calmv1CrudModel {
	String calmv1Id;
	int coverBulan;
	double harga;
	int thnBuat;
	String? currId;
	ComboRMatauangModel? comboRMatauang;
	String? mmvgrupojkId;
	ComboMMvgrupOjkModel? comboMMvgrupOjk;
	String? mmvjnscoverId;
	ComboMMvjnscoverModel? comboMMvjnscover;
	String? mmvpakaiId;
	ComboMMvpakaiModel? comboMMvpakai;
	String? mwilayahId;
	ComboMWilayahModel? comboMWilayah;

	Calmv1CrudModel({required this.calmv1Id, required this.coverBulan, 
		required this.harga, required this.thnBuat, 
		this.currId, this.comboRMatauang, this.mmvgrupojkId, this.comboMMvgrupOjk, 
		this.mmvjnscoverId, this.comboMMvjnscover, this.mmvpakaiId, this.comboMMvpakai, 
		this.mwilayahId, this.comboMWilayah});

	factory Calmv1CrudModel.fromJson(Map<String, dynamic> data) {
		ComboRMatauangModel? comboRMatauang;
		if (data['comboRMatauang'] != null) {
			comboRMatauang = ComboRMatauangModel.fromJson(data['comboRMatauang']);
		}

		ComboMMvgrupOjkModel? comboMMvgrupOjk;
		if (data['comboMMvgrupOjk'] != null) {
			comboMMvgrupOjk = ComboMMvgrupOjkModel.fromJson(data['comboMMvgrupOjk']);
		}

		ComboMMvjnscoverModel? comboMMvjnscover;
		if (data['comboMMvjnscover'] != null) {
			comboMMvjnscover = ComboMMvjnscoverModel.fromJson(data['comboMMvjnscover']);
		}

		ComboMMvpakaiModel? comboMMvpakai;
		if (data['comboMMvpakai'] != null) {
			comboMMvpakai = ComboMMvpakaiModel.fromJson(data['comboMMvpakai']);
		}

		ComboMWilayahModel? comboMWilayah;
		if (data['comboMWilayah'] != null) {
			comboMWilayah = ComboMWilayahModel.fromJson(data['comboMWilayah']);
		}

		return Calmv1CrudModel(
			calmv1Id: data['calmv1Id']??'',
			coverBulan: int.tryParse(data['coverBulan'].toString())??0,
			harga: double.tryParse(data['harga'].toString())??0,
			thnBuat: int.tryParse(data['thnBuat'].toString())??0,
			currId: data['currId']??'',
			comboRMatauang: comboRMatauang,
			mmvgrupojkId: data['mmvgrupojkId']??'',
			comboMMvgrupOjk: comboMMvgrupOjk,
			mmvjnscoverId: data['mmvjnscoverId']??'',
			comboMMvjnscover: comboMMvjnscover,
			mmvpakaiId: data['mmvpakaiId']??'',
			comboMMvpakai: comboMMvpakai,
			mwilayahId: data['mwilayahId']??'',
			comboMWilayah: comboMWilayah
		);

	}

	Map<String, dynamic> toJson() =>
		{'calmv1Id': calmv1Id,
		'coverBulan': coverBulan.toString(),
		'harga': harga.toString(),
		'thnBuat': thnBuat.toString(),
		'currId': currId,
		'comboRMatauang': comboRMatauang?.toJson(),
		'mmvgrupojkId': mmvgrupojkId,
		'comboMMvgrupOjk': comboMMvgrupOjk?.toJson(),
		'mmvjnscoverId': mmvjnscoverId,
		'comboMMvjnscover': comboMMvjnscover?.toJson(),
		'mmvpakaiId': mmvpakaiId,
		'comboMMvpakai': comboMMvpakai?.toJson(),
		'mwilayahId': mwilayahId,
		'comboMWilayah': comboMWilayah?.toJson()};

}
