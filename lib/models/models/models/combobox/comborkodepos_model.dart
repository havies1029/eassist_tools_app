import 'package:equatable/equatable.dart';

class ComboRKodeposModel extends Equatable {
	final String rkodeposId;
	final String kodeposNo;

	const ComboRKodeposModel({this.rkodeposId='', this.kodeposNo=''});

	factory ComboRKodeposModel.fromJson(Map<String, dynamic> data) =>
		ComboRKodeposModel(
			rkodeposId: data['rkodeposId'],
			kodeposNo: data['kodeposNo'],
		);

	Map<String, dynamic> toJson() =>
		{'rkodeposId': rkodeposId,
		'kodeposNo': kodeposNo,};

	@override
	List<Object> get props => [rkodeposId, kodeposNo];
}
