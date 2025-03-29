import 'package:eassist_tools_app/models/combobox/combormatauang_model.dart';

class SimulbonCrudModel {
  double? carNilai;
  double? carPersen;
  int? coverBulan;
  bool? isCar;
  bool? isPelaksanaan;
  bool? isPemeliharaan;
  bool? isPenawaran;
  bool? isUangmuka;
  double? kontrakNilai;
  double? pelaksanaanNilai;
  double? pelaksanaanPersen;
  double? pemeliharaanNilai;
  double? pemeliharaanPersen;
  double? penawaranNilai;
  double? penawaranPersen;
  double? premiCar;
  double? premiPelaksanaan;
  double? premiPemeliharaan;
  double? premiPenawaran;
  double? premiUangmuka;
  double? premiTotal;
  double? rateBond;
  double? rateCar;
  String? simulbon1Id;
  double? uangmukaNilai;
  double? uangmukaPersen;
  String? rmatauangKode;
  ComboRMatauangModel? comboRMatauang;

  SimulbonCrudModel(
      {this.carNilai,
      this.carPersen,
      this.coverBulan,
      this.isCar,
      this.isPelaksanaan,
      this.isPemeliharaan,
      this.isPenawaran,
      this.isUangmuka,
      this.kontrakNilai,
      this.pelaksanaanNilai,
      this.pelaksanaanPersen,
      this.pemeliharaanNilai,
      this.pemeliharaanPersen,
      this.penawaranNilai,
      this.penawaranPersen,
      this.premiCar,
      this.premiPelaksanaan,
      this.premiPemeliharaan,
      this.premiPenawaran,
      this.premiUangmuka,
      this.premiTotal,
      this.rateBond,
      this.rateCar,
      this.simulbon1Id,
      this.uangmukaNilai,
      this.uangmukaPersen,
      this.rmatauangKode,
      this.comboRMatauang});

  factory SimulbonCrudModel.fromJson(Map<String, dynamic> data) {
    ComboRMatauangModel? comboRMatauang;
    if (data['comboRMatauang'] != null) {
      comboRMatauang = ComboRMatauangModel.fromJson(data['comboRMatauang']);
    }

    return SimulbonCrudModel(
        carNilai: double.tryParse(data['carNilai'].toString()) ?? 0,
        carPersen: double.tryParse(data['carPersen'].toString()) ?? 0,
        coverBulan: int.tryParse(data['coverBulan'].toString()) ?? 0,
        isCar: data['isCar'] ?? '',
        isPelaksanaan: data['isPelaksanaan'] ?? '',
        isPemeliharaan: data['isPemeliharaan'] ?? '',
        isPenawaran: data['isPenawaran'] ?? '',
        isUangmuka: data['isUangmuka'] ?? '',
        kontrakNilai: double.tryParse(data['kontrakNilai'].toString()) ?? 0,
        pelaksanaanNilai:
            double.tryParse(data['pelaksanaanNilai'].toString()) ?? 0,
        pelaksanaanPersen:
            double.tryParse(data['pelaksanaanPersen'].toString()) ?? 0,
        pemeliharaanNilai:
            double.tryParse(data['pemeliharaanNilai'].toString()) ?? 0,
        pemeliharaanPersen:
            double.tryParse(data['pemeliharaanPersen'].toString()) ?? 0,
        penawaranNilai: double.tryParse(data['penawaranNilai'].toString()) ?? 0,
        penawaranPersen:
            double.tryParse(data['penawaranPersen'].toString()) ?? 0,
        premiCar: double.tryParse(data['premiCar'].toString()) ?? 0,
        premiPelaksanaan:
            double.tryParse(data['premiPelaksanaan'].toString()) ?? 0,
        premiPemeliharaan:
            double.tryParse(data['premiPemeliharaan'].toString()) ?? 0,
        premiPenawaran: double.tryParse(data['premiPenawaran'].toString()) ?? 0,
        premiUangmuka: double.tryParse(data['premiUangmuka'].toString()) ?? 0,
        premiTotal: double.tryParse(data['premiTotal'].toString()) ?? 0,
        rateBond: double.tryParse(data['rateBond'].toString()) ?? 0,
        rateCar: double.tryParse(data['rateCar'].toString()) ?? 0,
        simulbon1Id: data['simulbon1Id'] ?? '',
        uangmukaNilai: double.tryParse(data['uangmukaNilai'].toString()) ?? 0,
        uangmukaPersen: double.tryParse(data['uangmukaPersen'].toString()) ?? 0,
        rmatauangKode: data['rmatauangKode'] ?? '',
        comboRMatauang: comboRMatauang);
  }

  Map<String, dynamic> toJson() => {
        'carNilai': carNilai.toString(),
        'carPersen': carPersen.toString(),
        'coverBulan': coverBulan.toString(),
        'isCar': isCar,
        'isPelaksanaan': isPelaksanaan,
        'isPemeliharaan': isPemeliharaan,
        'isPenawaran': isPenawaran,
        'isUangmuka': isUangmuka,
        'kontrakNilai': kontrakNilai.toString(),
        'pelaksanaanNilai': pelaksanaanNilai.toString(),
        'pelaksanaanPersen': pelaksanaanPersen.toString(),
        'pemeliharaanNilai': pemeliharaanNilai.toString(),
        'pemeliharaanPersen': pemeliharaanPersen.toString(),
        'penawaranNilai': penawaranNilai.toString(),
        'penawaranPersen': penawaranPersen.toString(),
        'premiCar': premiCar.toString(),
        'premiPelaksanaan': premiPelaksanaan.toString(),
        'premiPemeliharaan': premiPemeliharaan.toString(),
        'premiPenawaran': premiPenawaran.toString(),
        'premiUangmuka': premiUangmuka.toString(),
        'premiTotal': premiTotal.toString(),
        'rateBond': rateBond.toString(),
        'rateCar': rateCar.toString(),
        'simulbon1Id': simulbon1Id,
        'uangmukaNilai': uangmukaNilai.toString(),
        'uangmukaPersen': uangmukaPersen.toString(),
        'rmatauangKode': rmatauangKode,
        'comboRMatauang': comboRMatauang?.toJson()
      };
}
