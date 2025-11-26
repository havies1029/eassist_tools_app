
class Regmv4FormModel {
	String caption;
	String regmv4Id;

	Regmv4FormModel({required this.caption, required this.regmv4Id});

	factory Regmv4FormModel.fromJson(Map<String, dynamic> data) {
		return Regmv4FormModel(
			caption: data['caption']??'',
			regmv4Id: data['regmv4Id']??'',
		);

	}

	Map<String, dynamic> toJson() =>
		{'caption': caption,
		'regmv4Id': regmv4Id,};

}
