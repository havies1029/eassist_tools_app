
class SimulgisListModel {
	int coverBulan;
	double premi;
	double rate;
	String rmatauangKode;
	String simulgisId;
	double tsi;
	String rMATAUANGNAMA;

	SimulgisListModel({required this.coverBulan, required this.premi, 
		required this.rate, required this.rmatauangKode, 
		required this.simulgisId, required this.tsi, 
		required this.rMATAUANGNAMA});

	factory SimulgisListModel.fromJson(Map<String, dynamic> data) {
		return SimulgisListModel(
			coverBulan: int.tryParse(data['coverBulan'].toString())??0,
			premi: double.tryParse(data['premi'].toString())??0,
			rate: double.tryParse(data['rate'].toString())??0,
			rmatauangKode: data['rmatauangKode']??'',
			simulgisId: data['simulgisId']??'',
			tsi: double.tryParse(data['tsi'].toString())??0,
			rMATAUANGNAMA: data['rMATAUANGNAMA']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'coverBulan': coverBulan.toString(),
		'premi': premi.toString(),
		'rate': rate.toString(),
		'rmatauangKode': rmatauangKode,
		'simulgisId': simulgisId,
		'tsi': tsi.toString(),
		'rMATAUANGNAMA': rMATAUANGNAMA};

}
