import 'package:equatable/equatable.dart';

class ComboMKotaModel extends Equatable {
	final String mkotaId;
	final String mpropinsiId;
	final String kotaRefid;
	final String kotaDesc;
	final String mnegaraId;

	const ComboMKotaModel({this.mkotaId='', this.mpropinsiId='', this.kotaRefid='', this.kotaDesc='', this.mnegaraId=''});

	factory ComboMKotaModel.fromJson(Map<String, dynamic> data) =>
		ComboMKotaModel(
			mkotaId: data['mkotaId'],
			mpropinsiId: data['mpropinsiId'],
			kotaRefid: data['kotaRefid'],
			kotaDesc: data['kotaDesc'],
			mnegaraId: data['mnegaraId']
		);

	Map<String, dynamic> toJson() =>
		{'mkotaId': mkotaId,
		'mpropinsiId': mpropinsiId,
		'kotaRefid': kotaRefid,
		'kotaDesc': kotaDesc,
		'mnegaraId': mnegaraId};

	@override
	List<Object> get props => [mkotaId, mpropinsiId, kotaRefid, kotaDesc, mnegaraId];
}
