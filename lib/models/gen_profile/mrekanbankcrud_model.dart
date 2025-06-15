
class MRekanBankCrudModel {
	String mrekan1Id;
	String mrekanbankId;
	String rekNama;
	String rekNo;

	MRekanBankCrudModel({required this.mrekan1Id, required this.mrekanbankId, 
		required this.rekNama, required this.rekNo});

	factory MRekanBankCrudModel.fromJson(Map<String, dynamic> data) {
		return MRekanBankCrudModel(
			mrekan1Id: data['mrekan1Id']??'',
			mrekanbankId: data['mrekanbankId']??'',
			rekNama: data['rekNama']??'',
			rekNo: data['rekNo']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'mrekan1Id': mrekan1Id,
		'mrekanbankId': mrekanbankId,
		'rekNama': rekNama,
		'rekNo': rekNo};

}
