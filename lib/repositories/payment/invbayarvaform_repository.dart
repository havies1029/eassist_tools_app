import 'package:eassist_tools_app/apis/payment/invbayarvaform_api.dart';
import 'package:eassist_tools_app/models/payment/invbayarvaform_model.dart';

class InvbayarvaFormRepository {

	InvbayarvaFormAPI api = InvbayarvaFormAPI();
	
	Future<InvbayarvaFormModel> invbayarvaFormLihat(String invoiceId) async {
		return await api.invbayarvaFormLihatAPI(invoiceId);
	}
}
