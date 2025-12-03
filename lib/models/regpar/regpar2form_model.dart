import 'package:eassist_tools_app/models/combobox/combomkecamatan_model.dart';
import 'package:eassist_tools_app/models/combobox/combomkelurahan_model.dart';
import 'package:eassist_tools_app/models/combobox/combomkota_model.dart';
import 'package:eassist_tools_app/models/combobox/combompropinsi_model.dart';
import 'package:eassist_tools_app/models/combobox/comborkonstruksiojk_model.dart';
import 'package:eassist_tools_app/models/combobox/comborokupasi_model.dart';

class Regpar2FormModel {
  String regpar1Id;
	String objectAlamat;
	DateTime polisAkhir;
	DateTime polisMulai;
	String regpar2Id;
	String? objectKecamatanId;
	ComboMKecamatanModel? comboMKecamatan;
	String? objectKelurahanId;
	ComboMKelurahanModel? comboMKelurahan;
	String? objectKotaId;
	ComboMKotaModel? comboMKota;
	String? objectPropinsiId;
	ComboMPropinsiModel? comboMPropinsi;
	String? rkonstruksiojkId;
	ComboRKonstruksiojkModel? comboRKonstruksiojk;
	String? rokupasiId;
	ComboROkupasiModel? comboROkupasi;

	Regpar2FormModel({ required this.regpar1Id, required this.objectAlamat, 
		required this.polisAkhir, required this.polisMulai, 
		required this.regpar2Id, this.objectKecamatanId, this.comboMKecamatan, 
		this.objectKelurahanId, this.comboMKelurahan, this.objectKotaId, this.comboMKota, 
		this.objectPropinsiId, this.comboMPropinsi, this.rkonstruksiojkId, this.comboRKonstruksiojk, 
		this.rokupasiId, this.comboROkupasi});

	factory Regpar2FormModel.fromJson(Map<String, dynamic> data) {
		ComboMKecamatanModel? comboMKecamatan;
		if (data['comboMKecamatan'] != null) {
			comboMKecamatan = ComboMKecamatanModel.fromJson(data['comboMKecamatan']);
		}

		ComboMKelurahanModel? comboMKelurahan;
		if (data['comboMKelurahan'] != null) {
			comboMKelurahan = ComboMKelurahanModel.fromJson(data['comboMKelurahan']);
		}

		ComboMKotaModel? comboMKota;
		if (data['comboMKota'] != null) {
			comboMKota = ComboMKotaModel.fromJson(data['comboMKota']);
		}

		ComboMPropinsiModel? comboMPropinsi;
		if (data['comboMPropinsi'] != null) {
			comboMPropinsi = ComboMPropinsiModel.fromJson(data['comboMPropinsi']);
		}

		ComboRKonstruksiojkModel? comboRKonstruksiojk;
		if (data['comboRKonstruksiojk'] != null) {
			comboRKonstruksiojk = ComboRKonstruksiojkModel.fromJson(data['comboRKonstruksiojk']);
		}

		ComboROkupasiModel? comboROkupasi;
		if (data['comboROkupasi'] != null) {
			comboROkupasi = ComboROkupasiModel.fromJson(data['comboROkupasi']);
		}

		return Regpar2FormModel(
      regpar1Id: data['regpar1Id']??'',
			objectAlamat: data['objectAlamat']??'',
			polisAkhir: DateTime.tryParse(data['polisAkhir'].toString())??DateTime.now(),
			polisMulai: DateTime.tryParse(data['polisMulai'].toString())??DateTime.now(),
			regpar2Id: data['regpar2Id']??'',
			objectKecamatanId: data['objectKecamatanId']??'',
			comboMKecamatan: comboMKecamatan,
			objectKelurahanId: data['objectKelurahanId']??'',
			comboMKelurahan: comboMKelurahan,
			objectKotaId: data['objectKotaId']??'',
			comboMKota: comboMKota,
			objectPropinsiId: data['objectPropinsiId']??'',
			comboMPropinsi: comboMPropinsi,
			rkonstruksiojkId: data['rkonstruksiojkId']??'',
			comboRKonstruksiojk: comboRKonstruksiojk,
			rokupasiId: data['rokupasiId']??'',
			comboROkupasi: comboROkupasi
		);

	}

	Map<String, dynamic> toJson() =>
		{
      'regpar1Id': regpar1Id,
      'objectAlamat': objectAlamat,
		'polisAkhir': polisAkhir.toIso8601String(),
		'polisMulai': polisMulai.toIso8601String(),
		'regpar2Id': regpar2Id,
		'objectKecamatanId': objectKecamatanId,
		'comboMKecamatan': comboMKecamatan?.toJson(),
		'objectKelurahanId': objectKelurahanId,
		'comboMKelurahan': comboMKelurahan?.toJson(),
		'objectKotaId': objectKotaId,
		'comboMKota': comboMKota?.toJson(),
		'objectPropinsiId': objectPropinsiId,
		'comboMPropinsi': comboMPropinsi?.toJson(),
		'rkonstruksiojkId': rkonstruksiojkId,
		'comboRKonstruksiojk': comboRKonstruksiojk?.toJson(),
		'rokupasiId': rokupasiId,
		'comboROkupasi': comboROkupasi?.toJson()};

  Regpar2FormModel copyWith({
    String? regpar1Id,
    String? objectAlamat,
    DateTime? polisAkhir,
    DateTime? polisMulai,
    String? regpar2Id,
    String? objectKecamatanId,
    ComboMKecamatanModel? comboMKecamatan,
    String? objectKelurahanId,
    ComboMKelurahanModel? comboMKelurahan,
    String? objectKotaId,
    ComboMKotaModel? comboMKota,
    String? objectPropinsiId,
    ComboMPropinsiModel? comboMPropinsi,
    String? rkonstruksiojkId,
    ComboRKonstruksiojkModel? comboRKonstruksiojk,
    String? rokupasiId,
    ComboROkupasiModel? comboROkupasi,
  }){
    return Regpar2FormModel(
      regpar1Id: regpar1Id ?? this.regpar1Id,
      objectAlamat: objectAlamat ?? this.objectAlamat,
      polisAkhir: polisAkhir ?? this.polisAkhir,
      polisMulai: polisMulai ?? this.polisMulai,
      regpar2Id: regpar2Id ?? this.regpar2Id,
      objectKecamatanId: objectKecamatanId ?? this.objectKecamatanId,
      comboMKecamatan: comboMKecamatan ?? this.comboMKecamatan,
      objectKelurahanId: objectKelurahanId ?? this.objectKelurahanId,
      comboMKelurahan: comboMKelurahan ?? this.comboMKelurahan,
      objectKotaId: objectKotaId ?? this.objectKotaId,
      comboMKota: comboMKota ?? this.comboMKota,
      objectPropinsiId: objectPropinsiId ?? this.objectPropinsiId,
      comboMPropinsi: comboMPropinsi ?? this.comboMPropinsi,
      rkonstruksiojkId: rkonstruksiojkId ?? this.rkonstruksiojkId,
      comboRKonstruksiojk: comboRKonstruksiojk ?? this.comboRKonstruksiojk,
      rokupasiId: rokupasiId ?? this.rokupasiId,
      comboROkupasi: comboROkupasi ?? this.comboROkupasi,
    );
  }

}
