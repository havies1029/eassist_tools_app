
class Regklaim1CrudModel {
	String insuredNama;
	bool isPolisJps;
	DateTime polisAkhir;
	DateTime polisMulai;
	String polisNo;
	DateTime regTgl;
	String regklaim1Id;

	Regklaim1CrudModel({required this.insuredNama, required this.isPolisJps, 
		required this.polisAkhir, required this.polisMulai, 
		required this.polisNo, required this.regTgl, 
		required this.regklaim1Id});

	factory Regklaim1CrudModel.fromJson(Map<String, dynamic> data) {
		return Regklaim1CrudModel(
			insuredNama: data['insuredNama']??'',
			isPolisJps: data['isPolisJps']??'',
			polisAkhir: DateTime.tryParse(data['polisAkhir'].toString())??DateTime.now(),
			polisMulai: DateTime.tryParse(data['polisMulai'].toString())??DateTime.now(),
			polisNo: data['polisNo']??'',
			regTgl: DateTime.tryParse(data['regTgl'].toString())??DateTime.now(),
			regklaim1Id: data['regklaim1Id']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'insuredNama': insuredNama,
		'isPolisJps': isPolisJps,
		'polisAkhir': polisAkhir.toIso8601String(),
		'polisMulai': polisMulai.toIso8601String(),
		'polisNo': polisNo,
		'regTgl': regTgl.toIso8601String(),
		'regklaim1Id': regklaim1Id};

}
