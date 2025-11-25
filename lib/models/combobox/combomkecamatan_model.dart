import 'package:equatable/equatable.dart';

class ComboMKecamatanModel extends Equatable {
	final String mkecamatanId;
	final String kecamatanNama;
	final String mkotaId;
	final String mpropinsiId;

	const ComboMKecamatanModel({this.mkecamatanId='', this.kecamatanNama='', this.mkotaId='', this.mpropinsiId=''});

	factory ComboMKecamatanModel.fromJson(Map<String, dynamic> data) =>
		ComboMKecamatanModel(
			mkecamatanId: data['mkecamatanId'],
			kecamatanNama: data['kecamatanNama'],
			mkotaId: data['mkotaId'],
			mpropinsiId: data['mpropinsiId']
		);

	Map<String, dynamic> toJson() =>
		{'mkecamatanId': mkecamatanId,
		'kecamatanNama': kecamatanNama,
		'mkotaId': mkotaId,
		'mpropinsiId': mpropinsiId};

	@override
	List<Object> get props => [mkecamatanId, kecamatanNama, mkotaId, mpropinsiId];
}
