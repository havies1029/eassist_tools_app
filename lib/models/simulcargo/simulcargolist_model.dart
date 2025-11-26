
class SimulcargoListModel {
	String mconveybyId;
	String mconveydetailId;
	String mmopId;
	double premi;
	double rate;
	String simulcargoId;
	double tsi;
	double upliftPersen;
	String conveybyNama;
	String mopName;

	SimulcargoListModel({required this.mconveybyId, required this.mconveydetailId, 
		required this.mmopId, required this.premi, 
		required this.rate, required this.simulcargoId, 
		required this.tsi, required this.upliftPersen, 
		required this.conveybyNama, required this.mopName});

	factory SimulcargoListModel.fromJson(Map<String, dynamic> data) {
		return SimulcargoListModel(
			mconveybyId: data['mconveybyId']??'',
			mconveydetailId: data['mconveydetailId']??'',
			mmopId: data['mmopId']??'',
			premi: double.tryParse(data['premi'].toString())??0,
			rate: double.tryParse(data['rate'].toString())??0,
			simulcargoId: data['simulcargoId']??'',
			tsi: double.tryParse(data['tsi'].toString())??0,
			upliftPersen: double.tryParse(data['upliftPersen'].toString())??0,
			conveybyNama: data['conveybyNama']??'',
			mopName: data['mopName']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'mconveybyId': mconveybyId,
		'mconveydetailId': mconveydetailId,
		'mmopId': mmopId,
		'premi': premi.toString(),
		'rate': rate.toString(),
		'simulcargoId': simulcargoId,
		'tsi': tsi.toString(),
		'upliftPersen': upliftPersen.toString(),
		'conveybyNama': conveybyNama,
		'mopName': mopName};

}
