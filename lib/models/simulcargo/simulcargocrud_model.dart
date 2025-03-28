import 'package:eassist_tools_app/models/combobox/combommop_model.dart';
import 'package:eassist_tools_app/models/combobox/combomconveydetail_model.dart';
import 'package:eassist_tools_app/models/combobox/combommop_model.dart';

class SimulcargoCrudModel {
	double premi;
	double rate;
	String simulcargoId;
	double tsi;
	double upliftPersen;
	String? mconveybyId;
	ComboMMopModel? comboMMop;
	String? mconveydetailId;
	ComboMConveyDetailModel? comboMConveyDetail;
	String? mmopId;

	SimulcargoCrudModel({required this.premi, required this.rate, 
		required this.simulcargoId, required this.tsi, 
		required this.upliftPersen, this.mconveybyId, this.comboMMop, 
		this.mconveydetailId, this.comboMConveyDetail, this.mmopId});

	factory SimulcargoCrudModel.fromJson(Map<String, dynamic> data) {
		ComboMMopModel? comboMMop;
		if (data['comboMMop'] != null) {
			comboMMop = ComboMMopModel.fromJson(data['comboMMop']);
		}

		ComboMConveyDetailModel? comboMConveyDetail;
		if (data['comboMConveyDetail'] != null) {
			comboMConveyDetail = ComboMConveyDetailModel.fromJson(data['comboMConveyDetail']);
		}


		return SimulcargoCrudModel(
			premi: double.tryParse(data['premi'].toString())??0,
			rate: double.tryParse(data['rate'].toString())??0,
			simulcargoId: data['simulcargoId']??'',
			tsi: double.tryParse(data['tsi'].toString())??0,
			upliftPersen: double.tryParse(data['upliftPersen'].toString())??0,
			mconveybyId: data['mconveybyId']??'',
			comboMMop: comboMMop,
			mconveydetailId: data['mconveydetailId']??'',
			comboMConveyDetail: comboMConveyDetail,
			mmopId: data['mmopId']??'',
		);

	}

	Map<String, dynamic> toJson() =>
		{'premi': premi.toString(),
		'rate': rate.toString(),
		'simulcargoId': simulcargoId,
		'tsi': tsi.toString(),
		'upliftPersen': upliftPersen.toString(),
		'mconveybyId': mconveybyId,
		'comboMMop': comboMMop?.toJson(),
		'mconveydetailId': mconveydetailId,
		'comboMConveyDetail': comboMConveyDetail?.toJson(),
		'mmopId': mmopId
    };

}
