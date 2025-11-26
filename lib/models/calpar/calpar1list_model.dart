
class Calpar1ListModel {
	String calpar1Id;
	int coverBulan;
	String rkonstruksiojkId;
	String rokupasiId;
	String kelasNama;
	String okupasiDesc;

	Calpar1ListModel({required this.calpar1Id, required this.coverBulan, 
		required this.rkonstruksiojkId, required this.rokupasiId, 
		required this.kelasNama, required this.okupasiDesc});

	factory Calpar1ListModel.fromJson(Map<String, dynamic> data) {
		return Calpar1ListModel(
			calpar1Id: data['calpar1Id']??'',
			coverBulan: int.tryParse(data['coverBulan'].toString())??0,
			rkonstruksiojkId: data['rkonstruksiojkId']??'',
			rokupasiId: data['rokupasiId']??'',
			kelasNama: data['kelasNama']??'',
			okupasiDesc: data['okupasiDesc']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'calpar1Id': calpar1Id,
		'coverBulan': coverBulan.toString(),
		'rkonstruksiojkId': rkonstruksiojkId,
		'rokupasiId': rokupasiId,
		'kelasNama': kelasNama,
		'okupasiDesc': okupasiDesc};

}
