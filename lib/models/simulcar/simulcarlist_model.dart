
class SimulcarListModel {
	int coverBulan;
	double premi;
	double rate;
	String rmatauangKode;
	String simulcarId;
	double tsi;
	String rMATAUANGNAMA;

	SimulcarListModel({required this.coverBulan, required this.premi, 
		required this.rate, required this.rmatauangKode, 
		required this.simulcarId, required this.tsi, 
		required this.rMATAUANGNAMA});

	factory SimulcarListModel.fromJson(Map<String, dynamic> data) {
		return SimulcarListModel(
			coverBulan: int.tryParse(data['coverBulan'].toString())??0,
			premi: double.tryParse(data['premi'].toString())??0,
			rate: double.tryParse(data['rate'].toString())??0,
			rmatauangKode: data['rmatauangKode']??'',
			simulcarId: data['simulcarId']??'',
			tsi: double.tryParse(data['tsi'].toString())??0,
			rMATAUANGNAMA: data['rMATAUANGNAMA']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'coverBulan': coverBulan.toString(),
		'premi': premi.toString(),
		'rate': rate.toString(),
		'rmatauangKode': rmatauangKode,
		'simulcarId': simulcarId,
		'tsi': tsi.toString(),
		'rMATAUANGNAMA': rMATAUANGNAMA};

}
