import 'package:equatable/equatable.dart';

class ComboMMvmodelModel extends Equatable {
	final String mmvmodelId;
	final String mmvtipeId;
	final String nmModel;
	final String nmTipe;

	const ComboMMvmodelModel({this.mmvmodelId='', this.mmvtipeId='', this.nmModel='', this.nmTipe=''});

	factory ComboMMvmodelModel.fromJson(Map<String, dynamic> data) =>
		ComboMMvmodelModel(
			mmvmodelId: data['mmvmodelId'],
			mmvtipeId: data['mmvtipeId'],
			nmModel: data['nmModel'],
			nmTipe: data['nmTipe']
		);

	Map<String, dynamic> toJson() =>
		{'mmvmodelId': mmvmodelId,
		'mmvtipeId': mmvtipeId,
		'nmModel': nmModel,
		'nmTipe': nmTipe};

	@override
	List<Object> get props => [mmvmodelId, mmvtipeId, nmModel, nmTipe];
}
