import 'package:eassist_tools_app/models/combobox/combompekerjaan_model.dart';

class MRekanGeneralIdvCrudModel {
	String mjnsclientId;
	String mjnskelId;
	String mrekan1Id;
	String rekanNama;
	String? mpekerjaanId;
	ComboMPekerjaanModel? comboMPekerjaan;

	MRekanGeneralIdvCrudModel({required this.mjnsclientId, required this.mjnskelId, 
		required this.mrekan1Id, required this.rekanNama, 
		this.mpekerjaanId, this.comboMPekerjaan});

	factory MRekanGeneralIdvCrudModel.fromJson(Map<String, dynamic> data) {
		ComboMPekerjaanModel? comboMPekerjaan;
		if (data['comboMPekerjaan'] != null) {
			comboMPekerjaan = ComboMPekerjaanModel.fromJson(data['comboMPekerjaan']);
		}

		return MRekanGeneralIdvCrudModel(
			mjnsclientId: data['mjnsclientId']??'',
			mjnskelId: data['mjnskelId']??'',
			mrekan1Id: data['mrekan1Id']??'',
			rekanNama: data['rekanNama']??'',
			mpekerjaanId: data['mpekerjaanId']??'',
			comboMPekerjaan: comboMPekerjaan
		);

	}

	Map<String, dynamic> toJson() =>
		{'mjnsclientId': mjnsclientId,
		'mjnskelId': mjnskelId,
		'mrekan1Id': mrekan1Id,
		'rekanNama': rekanNama,
		'mpekerjaanId': mpekerjaanId,
		'comboMPekerjaan': comboMPekerjaan?.toJson()};

}
