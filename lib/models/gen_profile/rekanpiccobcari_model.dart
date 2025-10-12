
class RekanPicCobCariModel {
	String mcobapp1Id;
	String mrekanpicId;
	String mrekanpiccobId;
	String cobNama;

	RekanPicCobCariModel({required this.mcobapp1Id, required this.mrekanpicId, 
		required this.mrekanpiccobId, required this.cobNama});

	factory RekanPicCobCariModel.fromJson(Map<String, dynamic> data) {
		return RekanPicCobCariModel(
			mcobapp1Id: data['mcobapp1Id']??'',
			mrekanpicId: data['mrekanpicId']??'',
			mrekanpiccobId: data['mrekanpiccobId']??'',
			cobNama: data['cobNama']??''
		);

	}

	Map<String, dynamic> toJson() =>
		{'mcobapp1Id': mcobapp1Id,
		'mrekanpicId': mrekanpicId,
		'mrekanpiccobId': mrekanpiccobId,
		'cobNama': cobNama};

}
