
class Regklaim1ListModel {
	String insuredNama;
	bool isPolisJps;
	String minsuranceId;
	String mrekan1Id;
	DateTime polisAkhir;
	DateTime polisMulai;
	String polisNo;
	DateTime regTgl;
	String regklaim1Id;
	String insuranceName;

	Regklaim1ListModel({required this.insuredNama, required this.isPolisJps, 
		required this.minsuranceId, required this.mrekan1Id, 
		required this.polisAkhir, required this.polisMulai, 
		required this.polisNo, required this.regTgl, 
		required this.regklaim1Id, required this.insuranceName});

	factory Regklaim1ListModel.fromJson(Map<String, dynamic> data) {
		return Regklaim1ListModel(
			insuredNama: data['insuredNama']??'',
			isPolisJps: data['isPolisJps']??'',
			minsuranceId: data['minsuranceId']??'',
			mrekan1Id: data['mrekan1Id']??'',
			polisAkhir: DateTime.tryParse(data['polisAkhir'].toString())??DateTime.now(),
			polisMulai: DateTime.tryParse(data['polisMulai'].toString())??DateTime.now(),
			polisNo: data['polisNo']??'',
			regTgl: DateTime.tryParse(data['regTgl'].toString())??DateTime.now(),
			regklaim1Id: data['regklaim1Id']??'',
			insuranceName: data['insuranceName']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'insuredNama': insuredNama,
		'isPolisJps': isPolisJps,
		'minsuranceId': minsuranceId,
		'mrekan1Id': mrekan1Id,
		'polisAkhir': polisAkhir.toIso8601String(),
		'polisMulai': polisMulai.toIso8601String(),
		'polisNo': polisNo,
		'regTgl': regTgl.toIso8601String(),
		'regklaim1Id': regklaim1Id,
		'insuranceName': insuranceName};

}
