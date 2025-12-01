import 'package:equatable/equatable.dart';

class ComboMMvmodelModel extends Equatable {
	final String mmvmodelId;
	final String nmModel;

	const ComboMMvmodelModel({this.mmvmodelId='', this.nmModel=''});

	factory ComboMMvmodelModel.fromJson(Map<String, dynamic> data) =>
		ComboMMvmodelModel(
			mmvmodelId: data['mmvmodelId'],
			nmModel: data['nmModel'],
		);

	Map<String, dynamic> toJson() =>
		{'mmvmodelId': mmvmodelId,
		'nmModel': nmModel};

	@override
	List<Object> get props => [mmvmodelId, nmModel];
}
