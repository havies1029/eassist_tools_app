import 'package:eassist_tools_app/apis/payment/paymentmethodcari_api.dart';
import 'package:eassist_tools_app/models/payment/paymentmethodcategory_model.dart';

class PaymentMethodCariRepository {
  final PaymentMethodCariAPI api;

  PaymentMethodCariRepository({required this.api});

  Future<List<PaymentCategory>> fetchPaymentMethods() async {
    return await api.getPaymentMethods();
  }
}