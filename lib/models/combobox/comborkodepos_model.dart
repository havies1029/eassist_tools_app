import 'package:equatable/equatable.dart';

class ComboRKodeposModel extends Equatable {
	final String rkodeposId;
	final String kodeposNo;
	final String wilayah;
	final String mkotaId;
	final String mpropinsiId;

	const ComboRKodeposModel({this.rkodeposId='', this.kodeposNo='', this.wilayah='', this.mkotaId='', this.mpropinsiId=''});

	factory ComboRKodeposModel.fromJson(Map<String, dynamic> data) =>
		ComboRKodeposModel(
			rkodeposId: data['rkodeposId'],
			kodeposNo: data['kodeposNo'],
			wilayah: data['wilayah'],
			mkotaId: data['mkotaId'],
			mpropinsiId: data['mpropinsiId']
		);

	Map<String, dynamic> toJson() =>
		{'rkodeposId': rkodeposId,
		'kodeposNo': kodeposNo,
		'wilayah': wilayah,
		'mkotaId': mkotaId,
		'mpropinsiId': mpropinsiId};

	@override
	List<Object> get props => [rkodeposId, kodeposNo, wilayah, mkotaId, mpropinsiId];
}
