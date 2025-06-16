import 'package:eassist_tools_app/models/combobox/combombentukcst_model.dart';
import 'package:eassist_tools_app/models/combobox/combombidang_model.dart';

class MRekanGeneralCmpCrudModel {
	String mrekan1Id;
	String rekanNama;
	String? mbentukcstId;
	ComboMBentukCstModel? comboMBentukCst;
	String? mbidangId;
	ComboMBidangModel? comboMBidang;

	MRekanGeneralCmpCrudModel({required this.mrekan1Id, required this.rekanNama, 
		this.mbentukcstId, this.comboMBentukCst, this.mbidangId, this.comboMBidang});

	factory MRekanGeneralCmpCrudModel.fromJson(Map<String, dynamic> data) {
		ComboMBentukCstModel? comboMBentukCst;
		if (data['comboMBentukCst'] != null) {
			comboMBentukCst = ComboMBentukCstModel.fromJson(data['comboMBentukCst']);
		}

		ComboMBidangModel? comboMBidang;
		if (data['comboMBidang'] != null) {
			comboMBidang = ComboMBidangModel.fromJson(data['comboMBidang']);
		}

		return MRekanGeneralCmpCrudModel(
			mrekan1Id: data['mrekan1Id']??'',
			rekanNama: data['rekanNama']??'',
			mbentukcstId: data['mbentukcstId']??'',
			comboMBentukCst: comboMBentukCst,
			mbidangId: data['mbidangId']??'',
			comboMBidang: comboMBidang
		);

	}

	Map<String, dynamic> toJson() =>
		{'mrekan1Id': mrekan1Id,
		'rekanNama': rekanNama,
		'mbentukcstId': mbentukcstId,
		'comboMBentukCst': comboMBentukCst?.toJson(),
		'mbidangId': mbidangId,
		'comboMBidang': comboMBidang?.toJson()};

}
