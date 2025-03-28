import 'package:equatable/equatable.dart';

class ComboMMopModel extends Equatable {
	final String mmopId;
	final String mopName;
	final String pmcvid;
	final String jpsmapId;
	final String imcvid;
	final String asuransiId;

	const ComboMMopModel({this.mmopId='', this.mopName='', this.pmcvid='', this.jpsmapId='', this.imcvid='', this.asuransiId=''});

	factory ComboMMopModel.fromJson(Map<String, dynamic> data) =>
		ComboMMopModel(
			mmopId: data['mmopId'],
			mopName: data['mopName'],
			pmcvid: data['pmcvid'],
			jpsmapId: data['jpsmapId'],
			imcvid: data['imcvid'],
			asuransiId: data['asuransiId']
		);

	Map<String, dynamic> toJson() =>
		{'mmopId': mmopId,
		'mopName': mopName,
		'pmcvid': pmcvid,
		'jpsmapId': jpsmapId,
		'imcvid': imcvid,
		'asuransiId': asuransiId};

	@override
	List<Object> get props => [mmopId, mopName, pmcvid, jpsmapId, imcvid, asuransiId];
}
