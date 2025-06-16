
class MRekanBankListModel {
	String mbankId;
	String mrekan1Id;
	String mrekanbankId;
	String rekNama;
	String rekNo;

	MRekanBankListModel({required this.mbankId, required this.mrekan1Id, 
		required this.mrekanbankId, required this.rekNama, 
		required this.rekNo});

	factory MRekanBankListModel.fromJson(Map<String, dynamic> data) {
		return MRekanBankListModel(
			mbankId: data['mbankId']??'',
			mrekan1Id: data['mrekan1Id']??'',
			mrekanbankId: data['mrekanbankId']??'',
			rekNama: data['rekNama']??'',
			rekNo: data['rekNo']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'mbankId': mbankId,
		'mrekan1Id': mrekan1Id,
		'mrekanbankId': mrekanbankId,
		'rekNama': rekNama,
		'rekNo': rekNo};

}
