import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';

class SimuleeiCrudModel {
  int? coverBulan;
  double? rate;
  String? simuleei1Id;
  double? tsi;
  String? rmatauangKode;
  double? premi;
  String? currDesc;
  int? thnBuat;
  ComboRMatauangModel? comboRMatauang;

  SimuleeiCrudModel(
      {this.coverBulan,
      this.rate,
      this.simuleei1Id,
      this.tsi,
      this.rmatauangKode,
      this.premi,
      this.currDesc,
      this.thnBuat,
      this.comboRMatauang});

  factory SimuleeiCrudModel.fromJson(Map<String, dynamic> data) {
    ComboRMatauangModel? comboRMatauang;
    if (data['comboRMatauang'] != null) {
      comboRMatauang = ComboRMatauangModel.fromJson(data['comboRMatauang']);
    }

    return SimuleeiCrudModel(
        coverBulan: int.tryParse(data['coverBulan'].toString()) ?? 0,
        rate: double.tryParse(data['rate'].toString()) ?? 0,
        simuleei1Id: data['simuleei1Id'] ?? '',
        tsi: double.tryParse(data['tsi'].toString()) ?? 0,
        rmatauangKode: data['rmatauangKode'] ?? '',
        premi: double.tryParse(data['premi'].toString()) ?? 0,
        comboRMatauang: comboRMatauang,
        currDesc: data['currDesc'] ?? 'IDR',
        thnBuat: int.tryParse(data['thnBuat'].toString()) ?? 0,);
  }

  Map<String, dynamic> toJson() => {
        'coverBulan': coverBulan.toString(),
        'rate': rate.toString(),
        'simuleei1Id': simuleei1Id,
        'tsi': tsi.toString(),
        'rmatauangKode': rmatauangKode,
        'premi': premi.toString(),
        'comboRMatauang': comboRMatauang?.toJson(),
        'currDesc': currDesc,
        'thnBuat': thnBuat
      };
}
