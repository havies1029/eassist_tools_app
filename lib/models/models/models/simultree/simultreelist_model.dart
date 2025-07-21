
class SimultreeListModel {
	int coverBulan;
	double premi;
	double rate;
	String rmatauangKode;
	String simultreeId;
	double tsi;
	String rMATAUANGNAMA;

	SimultreeListModel({required this.coverBulan, required this.premi, 
		required this.rate, required this.rmatauangKode, 
		required this.simultreeId, required this.tsi, 
		required this.rMATAUANGNAMA});

	factory SimultreeListModel.fromJson(Map<String, dynamic> data) {
		return SimultreeListModel(
			coverBulan: int.tryParse(data['coverBulan'].toString())??0,
			premi: double.tryParse(data['premi'].toString())??0,
			rate: double.tryParse(data['rate'].toString())??0,
			rmatauangKode: data['rmatauangKode']??'',
			simultreeId: data['simultreeId']??'',
			tsi: double.tryParse(data['tsi'].toString())??0,
			rMATAUANGNAMA: data['rMATAUANGNAMA']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'coverBulan': coverBulan.toString(),
		'premi': premi.toString(),
		'rate': rate.toString(),
		'rmatauangKode': rmatauangKode,
		'simultreeId': simultreeId,
		'tsi': tsi.toString(),
		'rMATAUANGNAMA': rMATAUANGNAMA};

}
