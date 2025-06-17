class MRekan1CrudModel {
  String mrekan1Id;
  String rekanNama;
  int polisCount;
  double polisAmount;
  String mjnsclientId;

  MRekan1CrudModel(
      {required this.mrekan1Id,
      required this.rekanNama,
      required this.polisCount,
      required this.polisAmount,
      required this.mjnsclientId});

  factory MRekan1CrudModel.fromJson(Map<String, dynamic> data) {
    return MRekan1CrudModel(
      mrekan1Id: data['mrekan1Id'] ?? '',
      rekanNama: data['rekanNama'] ?? '',
      polisCount: int.tryParse(data['polisCount'].toString()) ?? 0,
      polisAmount: double.tryParse(data['polisAmount'].toString()) ?? 0,
      mjnsclientId: data['mjnsclientId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'mrekan1Id': mrekan1Id,
        'rekanNama': rekanNama,
        'polisCount': polisCount.toString(),
        'polisAmount': polisAmount.toString(),
        'mjnsclientId': mjnsclientId
      };
}
