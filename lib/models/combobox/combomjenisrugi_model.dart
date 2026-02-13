import 'package:equatable/equatable.dart';

class ComboMJenisrugiModel extends Equatable {
	final String mjenisrugiId;
	final String rugiDesc;
	final String minsuranceId;
	final String insuranceName;

	const ComboMJenisrugiModel({this.mjenisrugiId='', this.rugiDesc='', this.minsuranceId='', this.insuranceName=''});

	factory ComboMJenisrugiModel.fromJson(Map<String, dynamic> data) =>
		ComboMJenisrugiModel(
			mjenisrugiId: data['mjenisrugiId'],
			rugiDesc: data['rugiDesc'],
			minsuranceId: data['minsuranceId'],
			insuranceName: data['insuranceName']
		);

	Map<String, dynamic> toJson() =>
		{'mjenisrugiId': mjenisrugiId,
		'rugiDesc': rugiDesc,
		'minsuranceId': minsuranceId,
		'insuranceName': insuranceName};

	@override
	List<Object> get props => [mjenisrugiId, rugiDesc, minsuranceId, insuranceName];
}
