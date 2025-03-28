
class SimulgitListModel {
	int coverBulan;
	double premi;
	double rate;
	String rmatauangKode;
	String simulgitId;
	double tsi;
	String rMATAUANGNAMA;

	SimulgitListModel({required this.coverBulan, required this.premi, 
		required this.rate, required this.rmatauangKode, 
		required this.simulgitId, required this.tsi, 
		required this.rMATAUANGNAMA});

	factory SimulgitListModel.fromJson(Map<String, dynamic> data) {
		return SimulgitListModel(
			coverBulan: int.tryParse(data['coverBulan'].toString())??0,
			premi: double.tryParse(data['premi'].toString())??0,
			rate: double.tryParse(data['rate'].toString())??0,
			rmatauangKode: data['rmatauangKode']??'',
			simulgitId: data['simulgitId']??'',
			tsi: double.tryParse(data['tsi'].toString())??0,
			rMATAUANGNAMA: data['rMATAUANGNAMA']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'coverBulan': coverBulan.toString(),
		'premi': premi.toString(),
		'rate': rate.toString(),
		'rmatauangKode': rmatauangKode,
		'simulgitId': simulgitId,
		'tsi': tsi.toString(),
		'rMATAUANGNAMA': rMATAUANGNAMA};

}
