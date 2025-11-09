
class Regmv5FormModel {
	String fotoCaption;
	Int32 fotoStreamId;
	String regmv5Id;

	Regmv5FormModel({required this.fotoCaption, required this.fotoStreamId, 
		required this.regmv5Id});

	factory Regmv5FormModel.fromJson(Map<String, dynamic> data) {
		return Regmv5FormModel(
			fotoCaption: data['fotoCaption']??'',
			fotoStreamId: data['fotoStreamId']??'',
			regmv5Id: data['regmv5Id']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'fotoCaption': fotoCaption,
		'fotoStreamId': fotoStreamId,
		'regmv5Id': regmv5Id};

}
