import 'package:equatable/equatable.dart';

class ComboMKelurahanModel extends Equatable {
	final String mkelurahanId;
	final String kelurahanNama;
	final String mkecamatanId;
	final String kecamatanNama;

	const ComboMKelurahanModel({this.mkelurahanId='', this.kelurahanNama='', this.mkecamatanId='', this.kecamatanNama=''});

	factory ComboMKelurahanModel.fromJson(Map<String, dynamic> data) =>
		ComboMKelurahanModel(
			mkelurahanId: data['mkelurahanId'],
			kelurahanNama: data['kelurahanNama'],
			mkecamatanId: data['mkecamatanId'],
			kecamatanNama: data['kecamatanNama']
		);

	Map<String, dynamic> toJson() =>
		{'mkelurahanId': mkelurahanId,
		'kelurahanNama': kelurahanNama,
		'mkecamatanId': mkecamatanId,
		'kecamatanNama': kecamatanNama};

	@override
	List<Object> get props => [mkelurahanId, kelurahanNama, mkecamatanId, kecamatanNama];
}
