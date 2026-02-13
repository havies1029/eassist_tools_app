
class Klaim5parListModel {
	String caption;
	String jenisDocLain;
	String klaim1Id;
	String klaim5Id;
	String mjenisdocId;
	String jenisNama;

	Klaim5parListModel({required this.caption, 
		required this.jenisDocLain, required this.klaim1Id, 
		required this.klaim5Id, required this.mjenisdocId, 
		required this.jenisNama});

	factory Klaim5parListModel.fromJson(Map<String, dynamic> data) {
		return Klaim5parListModel(
			caption: data['caption']??'',
			jenisDocLain: data['jenisDocLain']??'',
			klaim1Id: data['klaim1Id']??'',
			klaim5Id: data['klaim5Id']??'',
			mjenisdocId: data['mjenisdocId']??'',
			jenisNama: data['jenisNama']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'caption': caption,
		'jenisDocLain': jenisDocLain,
		'klaim1Id': klaim1Id,
		'klaim5Id': klaim5Id,
		'mjenisdocId': mjenisdocId,
		'jenisNama': jenisNama};

}
