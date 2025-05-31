import 'package:equatable/equatable.dart';

class ComboMPropinsiModel extends Equatable {
	final String mpropinsiId;
	final String mnegaraId;
	final String refId;
	final String propinsiNama;
	final String mwilayahId;

	const ComboMPropinsiModel({this.mpropinsiId='', this.mnegaraId='', this.refId='', this.propinsiNama='', this.mwilayahId=''});

	factory ComboMPropinsiModel.fromJson(Map<String, dynamic> data) =>
		ComboMPropinsiModel(
			mpropinsiId: data['mpropinsiId'],
			mnegaraId: data['mnegaraId'],
			refId: data['refId'],
			propinsiNama: data['propinsiNama'],
			mwilayahId: data['mwilayahId']
		);

	Map<String, dynamic> toJson() =>
		{'mpropinsiId': mpropinsiId,
		'mnegaraId': mnegaraId,
		'refId': refId,
		'propinsiNama': propinsiNama,
		'mwilayahId': mwilayahId};

	@override
	List<Object> get props => [mpropinsiId, mnegaraId, refId, propinsiNama, mwilayahId];
}
