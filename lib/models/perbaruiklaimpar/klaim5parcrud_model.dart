
class Klaim5parCrudModel {
	String caption;
	String jenisDocLain;
	String klaim5Id;

	Klaim5parCrudModel({required this.caption, 
		required this.jenisDocLain, required this.klaim5Id});

	factory Klaim5parCrudModel.fromJson(Map<String, dynamic> data) {
		return Klaim5parCrudModel(
			caption: data['caption']??'',
			jenisDocLain: data['jenisDocLain']??'',
			klaim5Id: data['klaim5Id']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'caption': caption,
		'jenisDocLain': jenisDocLain,
		'klaim5Id': klaim5Id};

}
