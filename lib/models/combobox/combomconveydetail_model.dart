import 'package:equatable/equatable.dart';

class ComboMConveyDetailModel extends Equatable {
	final String mconveydetailId;
	final String mmopId;
	final String mconveybyId;
	final String detailDesc;

	const ComboMConveyDetailModel({this.mconveydetailId='', this.mmopId='', this.mconveybyId='', this.detailDesc=''});

	factory ComboMConveyDetailModel.fromJson(Map<String, dynamic> data) =>
		ComboMConveyDetailModel(
			mconveydetailId: data['mconveydetailId'],
			mmopId: data['mmopId'],
			mconveybyId: data['mconveybyId'],
			detailDesc: data['detailDesc']
		);

	Map<String, dynamic> toJson() =>
		{'mconveydetailId': mconveydetailId,
		'mmopId': mmopId,
		'mconveybyId': mconveybyId,
		'detailDesc': detailDesc};

	@override
	List<Object> get props => [mconveydetailId, mmopId, mconveybyId, detailDesc];
}
