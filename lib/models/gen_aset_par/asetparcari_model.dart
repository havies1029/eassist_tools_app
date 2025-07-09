
class AsetParCariModel {
	String alamat;
	String asetParId;
	String curr;
	String jenisAset;
	double klausulaBank;
	int noUrut;
	int nomor;
	String polisNo;
	String status;
	double sumInsured;

	AsetParCariModel({required this.alamat, required this.asetParId, 
		required this.curr, required this.jenisAset, 
		required this.klausulaBank, required this.noUrut, 
		required this.nomor, required this.polisNo, 
		required this.status, required this.sumInsured});

	factory AsetParCariModel.fromJson(Map<String, dynamic> data) {
		return AsetParCariModel(
			alamat: data['alamat']??'',
			asetParId: data['asetParId']??'',
			curr: data['curr']??'',
			jenisAset: data['jenisAset']??'',
			klausulaBank: double.tryParse(data['klausulaBank'].toString())??0,
			noUrut: int.tryParse(data['noUrut'].toString())??0,
			nomor: int.tryParse(data['nomor'].toString())??0,
			polisNo: data['polisNo']??'',
			status: data['status']??'',
			sumInsured: double.tryParse(data['sumInsured'].toString())??0
		);

	}

	Map<String, dynamic> toJson() =>
		{'alamat': alamat,
		'asetParId': asetParId,
		'curr': curr,
		'jenisAset': jenisAset,
		'klausulaBank': klausulaBank.toString(),
		'noUrut': noUrut.toString(),
		'nomor': nomor.toString(),
		'polisNo': polisNo,
		'status': status,
		'sumInsured': sumInsured.toString()};

}
