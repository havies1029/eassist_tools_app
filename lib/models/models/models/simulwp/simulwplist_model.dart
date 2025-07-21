
class SimulwpListModel {
	int coverBulan;
	double plafond;
	double premi;
	double rate;
	String rmatauangKode;
	String simulwp1Id;
	int usia;
	String rMATAUANGNAMA;

	SimulwpListModel({required this.coverBulan, required this.plafond, 
		required this.premi, required this.rate, 
		required this.rmatauangKode, required this.simulwp1Id, 
		required this.usia, required this.rMATAUANGNAMA});

	factory SimulwpListModel.fromJson(Map<String, dynamic> data) {
		return SimulwpListModel(
			coverBulan: int.tryParse(data['coverBulan'].toString())??0,
			plafond: double.tryParse(data['plafond'].toString())??0,
			premi: double.tryParse(data['premi'].toString())??0,
			rate: double.tryParse(data['rate'].toString())??0,
			rmatauangKode: data['rmatauangKode']??'',
			simulwp1Id: data['simulwp1Id']??'',
			usia: int.tryParse(data['usia'].toString())??0,
			rMATAUANGNAMA: data['rMATAUANGNAMA']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'coverBulan': coverBulan.toString(),
		'plafond': plafond.toString(),
		'premi': premi.toString(),
		'rate': rate.toString(),
		'rmatauangKode': rmatauangKode,
		'simulwp1Id': simulwp1Id,
		'usia': usia.toString(),
		'rMATAUANGNAMA': rMATAUANGNAMA};

}
