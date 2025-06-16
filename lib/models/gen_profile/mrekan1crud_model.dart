import 'package:eassist_tools_app/models/combobox/combombentukcst_model.dart';
import 'package:eassist_tools_app/models/combobox/combombidang_model.dart';
import 'package:eassist_tools_app/models/combobox/combomjnsclient_model.dart';
import 'package:eassist_tools_app/models/combobox/combomjnskel_model.dart';
import 'package:eassist_tools_app/models/combobox/combompekerjaan_model.dart';
import 'package:eassist_tools_app/models/combobox/combomtitle_model.dart';

class MRekan1CrudModel {
	String mrekan1Id;
	String rekanNama;
	String? mbentukcstId;
	ComboMBentukCstModel? comboMBentukCst;
	String? mbidangId;
	ComboMBidangModel? comboMBidang;
	String? mjnsclientId;
	ComboMJnsclientModel? comboMJnsclient;
	String? mjnskelId;
	ComboMJnskelModel? comboMJnskel;
	String? mpekerjaanId;
	ComboMPekerjaanModel? comboMPekerjaan;
	String? mtitleId;
	ComboMTitleModel? comboMTitle;

	MRekan1CrudModel({required this.mrekan1Id, required this.rekanNama, 
		this.mbentukcstId, this.comboMBentukCst, this.mbidangId, this.comboMBidang, 
		this.mjnsclientId, this.comboMJnsclient, this.mjnskelId, this.comboMJnskel, 
		this.mpekerjaanId, this.comboMPekerjaan, this.mtitleId, this.comboMTitle});

	factory MRekan1CrudModel.fromJson(Map<String, dynamic> data) {
		ComboMBentukCstModel? comboMBentukCst;
		if (data['comboMBentukCst'] != null) {
			comboMBentukCst = ComboMBentukCstModel.fromJson(data['comboMBentukCst']);
		}

		ComboMBidangModel? comboMBidang;
		if (data['comboMBidang'] != null) {
			comboMBidang = ComboMBidangModel.fromJson(data['comboMBidang']);
		}

		ComboMJnsclientModel? comboMJnsclient;
		if (data['comboMJnsclient'] != null) {
			comboMJnsclient = ComboMJnsclientModel.fromJson(data['comboMJnsclient']);
		}

		ComboMJnskelModel? comboMJnskel;
		if (data['comboMJnskel'] != null) {
			comboMJnskel = ComboMJnskelModel.fromJson(data['comboMJnskel']);
		}

		ComboMPekerjaanModel? comboMPekerjaan;
		if (data['comboMPekerjaan'] != null) {
			comboMPekerjaan = ComboMPekerjaanModel.fromJson(data['comboMPekerjaan']);
		}

		ComboMTitleModel? comboMTitle;
		if (data['comboMTitle'] != null) {
			comboMTitle = ComboMTitleModel.fromJson(data['comboMTitle']);
		}

		return MRekan1CrudModel(
			mrekan1Id: data['mrekan1Id']??'',
			rekanNama: data['rekanNama']??'',
			mbentukcstId: data['mbentukcstId']??'',
			comboMBentukCst: comboMBentukCst,
			mbidangId: data['mbidangId']??'',
			comboMBidang: comboMBidang,
			mjnsclientId: data['mjnsclientId']??'',
			comboMJnsclient: comboMJnsclient,
			mjnskelId: data['mjnskelId']??'',
			comboMJnskel: comboMJnskel,
			mpekerjaanId: data['mpekerjaanId']??'',
			comboMPekerjaan: comboMPekerjaan,
			mtitleId: data['mtitleId']??'',
			comboMTitle: comboMTitle
		);

	}

	Map<String, dynamic> toJson() =>
		{'mrekan1Id': mrekan1Id,
		'rekanNama': rekanNama,
		'mbentukcstId': mbentukcstId,
		'comboMBentukCst': comboMBentukCst?.toJson(),
		'mbidangId': mbidangId,
		'comboMBidang': comboMBidang?.toJson(),
		'mjnsclientId': mjnsclientId,
		'comboMJnsclient': comboMJnsclient?.toJson(),
		'mjnskelId': mjnskelId,
		'comboMJnskel': comboMJnskel?.toJson(),
		'mpekerjaanId': mpekerjaanId,
		'comboMPekerjaan': comboMPekerjaan?.toJson(),
		'mtitleId': mtitleId,
		'comboMTitle': comboMTitle?.toJson()};

}
