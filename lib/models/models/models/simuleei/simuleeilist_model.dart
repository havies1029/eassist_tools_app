
class SimuleeiListModel {
	int coverBulan;
	double rate;
	String rmatauangKode;
	String simuleei1Id;
	double tsi;
	String rMATAUANGNAMA;

	SimuleeiListModel({required this.coverBulan, required this.rate, 
		required this.rmatauangKode, required this.simuleei1Id, 
		required this.tsi, required this.rMATAUANGNAMA});

	factory SimuleeiListModel.fromJson(Map<String, dynamic> data) {
		return SimuleeiListModel(
			coverBulan: int.tryParse(data['coverBulan'].toString())??0,
			rate: double.tryParse(data['rate'].toString())??0,
			rmatauangKode: data['rmatauangKode']??'',
			simuleei1Id: data['simuleei1Id']??'',
			tsi: double.tryParse(data['tsi'].toString())??0,
			rMATAUANGNAMA: data['rMATAUANGNAMA']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'coverBulan': coverBulan.toString(),
		'rate': rate.toString(),
		'rmatauangKode': rmatauangKode,
		'simuleei1Id': simuleei1Id,
		'tsi': tsi.toString(),
		'rMATAUANGNAMA': rMATAUANGNAMA};

}
