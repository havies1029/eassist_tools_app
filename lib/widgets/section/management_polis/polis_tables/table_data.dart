import 'polis_category_type.dart';

class TableData {
  static List<List<String>> getData(CategoryType type) {
    switch (type) {
      case CategoryType.properti:
        return List.generate(50, (i) {
          final no = (i + 1).toString();
          return [
            no,
            'Jl. Contoh Alamat Yang Sangat Panjang Sekali No $no, RT 001 RW 002, Kelurahan Contoh Panjang Sekali, Kecamatan Test Yang Sangat Panjang, Jakarta Selatan 12345',
            '${100 + i}m²',
            '${2000 + (i % 20)}',
            '${1000000 + i * 10000}',
          ];
        });

      case CategoryType.kendaraan:
        return List.generate(30, (i) {
          return [
            '${i + 1}',
            'B ${(1000 + i)} ABC',
            'Toyota',
            'Avanza G ${(i % 3) + 1.3} MT Manual Transmission dengan Fitur Lengkap dan Nyaman untuk Keluarga Indonesia',
            '${2010 + (i % 15)}',
            '${2000000 + i * 15000}',
          ];
        });

      case CategoryType.kesehatan:
        return List.generate(20, (i) {
          return [
            '${i + 1}',
            'Peserta Nama Lengkap Yang Sangat Panjang Sekali Untuk Testing ${i + 1}',
            '${25 + (i % 40)}',
            i % 2 == 0 ? 'Laki-laki' : 'Perempuan',
            '${500000 + i * 5000}',
          ];
        });

      case CategoryType.marineKargo:
        return List.generate(10, (i) {
          return [
            '${i + 1}',
            'Pelabuhan A${i + 1}',
            'Pelabuhan B${i + 1}',
            'Barang ${[
              'Elektronik Canggih dan Peralatan Rumah Tangga Modern Berkualitas Tinggi',
              'Pakaian Jadi dan Tekstil Berkualitas Tinggi untuk Export',
              'Furniture Kayu Jati dan Perabotan Rumah Tangga Mewah'
            ][i % 3]}',
            '${800000 + i * 10000}',
          ];
        });

      case CategoryType.sdm:
        return List.generate(15, (i) {
          return [
            '${i + 1}',
            'Pegawai dengan Nama Lengkap Yang Sangat Panjang Untuk Testing ${i + 1}',
            ['Staf', 'Manajer', 'Direktur'][i % 3],
            ['IT', 'HRD', 'Marketing'][i % 3],
            '${700000 + i * 8000}',
          ];
        });

      case CategoryType.lain_lain:
        return List.generate(8, (i) {
          return [
            '${i + 1}',
            'Polis Tambahan ${i + 1}',
            'Keterangan tambahan no ${i + 1} yang sangat panjang dan berisi informasi detail mengenai polis asuransi ini beserta syarat dan ketentuan yang berlaku serta benefit yang didapatkan',
            '${400000 + i * 6000}',
          ];
        });

      default:
        return [
          ['1', 'Data tidak tersedia']
        ];
    }
  }
}