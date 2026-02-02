
class Regpar5FormModel {
  String regpar1Id;
	double diskonNilai;
	double diskonPersen;
	double premiEqvet;
	double premiNet;
	double premiOther;
	double premiPar;
	double premiRsmdcc;
	double premiTotal;
	double premiTsfwd;
	String regpar5Id;
	double ratePar;
	double rateRsmdcc;
	double rateTsfwd;
	double rateEqvet;
	double rateOther;
  double rateTotal;

	Regpar5FormModel({required this.diskonNilai, required this.diskonPersen, 
		required this.premiEqvet, required this.premiNet, 
		required this.premiOther, required this.premiPar, 
		required this.premiRsmdcc, required this.premiTotal, 
		required this.premiTsfwd, required this.regpar5Id, required this.regpar1Id,
    this.ratePar = 0,
    this.rateRsmdcc = 0,
    this.rateTsfwd = 0,
    this.rateEqvet = 0,
    this.rateOther = 0,
    this.rateTotal = 0});

	factory Regpar5FormModel.fromJson(Map<String, dynamic> data) {
		return Regpar5FormModel(
			diskonNilai: double.tryParse(data['diskonNilai'].toString())??0,
			diskonPersen: double.tryParse(data['diskonPersen'].toString())??0,
			premiEqvet: double.tryParse(data['premiEqvet'].toString())??0,
			premiNet: double.tryParse(data['premiNet'].toString())??0,
			premiOther: double.tryParse(data['premiOther'].toString())??0,
			premiPar: double.tryParse(data['premiPar'].toString())??0,
			premiRsmdcc: double.tryParse(data['premiRsmdcc'].toString())??0,
			premiTotal: double.tryParse(data['premiTotal'].toString())??0,
			premiTsfwd: double.tryParse(data['premiTsfwd'].toString())??0,
			regpar5Id: data['regpar5Id']??'',
			regpar1Id: data['regpar1Id']??'',
      ratePar: double.tryParse(data['ratePar'].toString())??0,
      rateRsmdcc: double.tryParse(data['rateRsmdcc'].toString())??0,
      rateTsfwd: double.tryParse(data['rateTsfwd'].toString())??0,
      rateEqvet: double.tryParse(data['rateEqvet'].toString())??0,
      rateOther: double.tryParse(data['rateOther'].toString())??0,
      rateTotal: double.tryParse(data['rateTotal'].toString())??0
		);

	}

	Map<String, dynamic> toJson() =>
		{'diskonNilai': diskonNilai.toString(),
		'diskonPersen': diskonPersen.toString(),
		'premiEqvet': premiEqvet.toString(),
		'premiNet': premiNet.toString(),
		'premiOther': premiOther.toString(),
		'premiPar': premiPar.toString(),
		'premiRsmdcc': premiRsmdcc.toString(),
		'premiTotal': premiTotal.toString(),
		'premiTsfwd': premiTsfwd.toString(),
		'regpar5Id': regpar5Id,
		'regpar1Id': regpar1Id,
    'ratePar': ratePar.toString(),
    'rateRsmdcc': rateRsmdcc.toString(),
    'rateTsfwd': rateTsfwd.toString(),
    'rateEqvet': rateEqvet.toString(),
    'rateOther': rateOther.toString(),
    'rateTotal': rateTotal.toString()
    };

}
