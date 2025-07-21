
class SimulmbListModel {
	int coverBulan;
	double premi;
	double rate;
	String rmatauangKode;
	String simulmbId;
	double tsi;
	String rMATAUANGNAMA;

	SimulmbListModel({required this.coverBulan, required this.premi, 
		required this.rate, required this.rmatauangKode, 
		required this.simulmbId, required this.tsi, 
		required this.rMATAUANGNAMA});

	factory SimulmbListModel.fromJson(Map<String, dynamic> data) {
		return SimulmbListModel(
			coverBulan: int.tryParse(data['coverBulan'].toString())??0,
			premi: double.tryParse(data['premi'].toString())??0,
			rate: double.tryParse(data['rate'].toString())??0,
			rmatauangKode: data['rmatauangKode']??'',
			simulmbId: data['simulmbId']??'',
			tsi: double.tryParse(data['tsi'].toString())??0,
			rMATAUANGNAMA: data['rMATAUANGNAMA']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'coverBulan': coverBulan.toString(),
		'premi': premi.toString(),
		'rate': rate.toString(),
		'rmatauangKode': rmatauangKode,
		'simulmbId': simulmbId,
		'tsi': tsi.toString(),
		'rMATAUANGNAMA': rMATAUANGNAMA};

}
