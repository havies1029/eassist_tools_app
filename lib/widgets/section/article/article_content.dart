// ========================
// 🎯 Artikel Utama Metadata
// ========================

final String articleTitle =
    'Apa Itu JPS? Mengenal Jenis Perlindungan Mikro yang Ramah Masyarakat';

final String articleAuthor = 'Ryan Basudara';
final String articleDate = 'May 22, 2025';
final String articleImagePath = 'assets/images/article_2.png';

// ========================
// 📌 Daftar Isi (TOC Items)
// ========================

final List<Map<String, String>> tocItems = [
  {'title': 'Apa Itu JPS?', 'id': 'apa-itu-jps'},
  {'title': 'Jenis Perlindungan Mikro yang Ditawarkan JPS', 'id': 'jenis-perlindungan'},
  {'title': 'Mengapa JPS Penting?', 'id': 'mengapa-penting'},
  {'title': 'Siapa yang Bisa Menjadi Peserta JPS?', 'id': 'siapa-peserta'},
  {'title': 'JPS bukan sekadar program asuransi mikro.', 'id': 'kesimpulan'},
];

// ========================
// 📚 Konten Setiap Section
// ========================

final Map<String, Map<String, dynamic>> sectionContents = {
  'apa-itu-jps': {
    'title': 'Apa Itu JPS?',
    'paragraphs': [
      'JPS (Jaminan Perlindungan Sosial) adalah program layanan asuransi mikro yang dirancang khusus untuk melindungi masyarakat dari berbagai risiko finansial. Program ini menawarkan solusi perlindungan yang mudah, murah, dan bermanfaat.',
      'JPS merupakan bagian dari program nasional yang bertujuan meningkatkan ketahanan sosial masyarakat, khususnya yang berpenghasilan rendah dan rentan terhadap risiko ekonomi konvensional.',
    ],
  },
  'jenis-perlindungan': {
    'title': 'Jenis Perlindungan Mikro yang Ditawarkan JPS',
    'paragraphs': [
      'JPS menyediakan beragam jenis perlindungan yang dirancang untuk kebutuhan spesifik masyarakat. Berikut adalah jenis-jenis perlindungan utama:',
    ],
    'bullets': [
      'Asuransi Mikro Jiwa: Memberikan santunan apabila keluarga atau peserta meninggal dunia, membantu meringankan beban ekonomi saat kehilangan pencari nafkah.',
      'Asuransi Mikro Kecelakaan: Melindungi peserta dari kerugian biaya akibat kecelakaan yang mengakibatkan luka yang memerlukan pengobatan, rawat inap, atau perawatan terkait.',
      'Bantuan Mikro Bencana: Memberikan bantuan bagi peserta untuk dapat mengirimkan diri atau keberatan, juga memberikan dukungan pembiayaan dalam situasi.',
      'Asuransi Mikro Pendidikan: Cocok untuk memberikan yang ingin mengatur kecelakannya bagi anak masalahnya bisa tetap demi bersama sehat hari.',
    ],
  },
  'mengapa-penting': {
    'title': 'Mengapa JPS Penting?',
    'paragraphs': [
      'Dalam kondisi ekonomi yang tidak stabil dan harga yang sangat tinggi, agar tidak membebankan keuangan keluarga:',
    ],
    'bullets': [
      'Premi Murah Terjangkau — Mengurangi masyarakat kebutuhan; pekerja informal hingga petani UMKM.',
      'Akses ke Layanan Nasional — Sejalan dengan visi inklusi keuangan dan meningkatkan kepentingan perseroannya.',
    ],
  },
  'siapa-peserta': {
    'title': 'Siapa yang Bisa Menjadi Peserta JPS?',
    'paragraphs': [
      'Program JPS terbuka untuk berbagai kalangan masyarakat, khususnya:',
    ],
    'bullets': [
      'Pekerja informal (buruh harian, sopir, ojek, nelayan)',
      'Petani dan pekebun',
      'UMKM dan usaha kecil menengah',
      'Ibu rumah tangga',
      'Siswa dan pelajar',
      'Siapa pun yang ingin memiliki proteksi dasar untuk keluarga',
    ],
  },
  'kesimpulan': {
    'title': 'JPS bukan sekadar program asuransi mikro.',
    'paragraphs': [
      'Ia adalah bentuk nyata dari upaya memperkuas perlindungan sosial di Indonesia— agar tidak ada lagi keluarga yang kehilangan arah karena musibah tak terduga. Melalui JPS, perlindungan menjadi sesuatu yang mudah, murah, dan menjangkau semua.',
      'Kini, siapa pun bisa melindungi diri dan orang tercinta, tanpa harus merogoh kocek dalam.',
    ],
  },
};

// ========================
// 📰 Artikel Sampingan (Sidebar)
// ========================

final List<Map<String, String>> sidebarArticles = [
  {
    'title': '5 Jenis Perlindungan JPS yang Wajib Diketahui Masyarakat',
    'category': 'Asuransi',
    'readTime': '5 Menit',
  },
  {
    'title': 'Bagaimana Cara Klaim Asuransi JPS dengan Mudah dan Cepat?',
    'category': 'Asuransi',
    'readTime': '5 Menit',
  },
  {
    'title': 'Kisah Nyata: JPS Membantu Saat Musibah Menimpa',
    'category': 'Asuransi',
    'readTime': '5 Menit',
  },
  {
    'title': 'Program Edukasi JPS: Literasi Asuransi untuk Semua Lapisan Masyarakat',
    'category': 'Asuransi',
    'readTime': '5 Menit',
  },
  {
    'title': 'Peran JPS dalam Meningkatkan Inklusi Keuangan di Indonesia',
    'category': 'Asuransi',
    'readTime': '5 Menit',
  },
  {
    'title': 'Perbandingan Asuransi Konvensional vs. Asuransi Mikro',
    'category': 'Asuransi',
    'readTime': '5 Menit',
  },
];



// ========================
// 📰 CERITA BESAR
// ========================


// Data untuk cerita besar (main articles)
final List<Map<String, String>> mainArticles = [
  {
    'title': 'Selasa, 16 Januari 2018 "SMART INSURANCE", Gebrakan AWAL TAHUN PT. Jaya Proteksindo Sakti',
    'image': 'assets/images/article1.png',
    'date': '16 Januari 2018'
  },
  {
    'title': 'Revolusi Teknologi Digital dalam Industri Asuransi Modern',
    'image': 'assets/images/article2.png',
    'date': '18 Jun 2025'
  },
  {
    'title': 'Inovasi Produk Asuransi untuk Generasi Milenial',
    'image': 'assets/images/article3.png',
    'date': '17 Jun 2025'
  },
  {
    'title': 'Strategi Pemasaran Digital dalam Era New Normal',
    'image': 'assets/images/article4.png',
    'date': '16 Jun 2025'
  },
];


// ========================
// 📰 CERITA SAMPINGAN
// ========================

// Data untuk cerita sampingan (side articles)
final List<Map<String, String>> sideArticles = [
  {
    'title': 'Smart Insurance, Solusi Lindungi Properti Pencurian Dari Risiko Tak Terduga',
    'source': 'TribunBisnis/TribunNews.Com',
    'image': 'assets/images/article1.png',
  },
  {
    'title': 'Jaya Proteksindo Sakti Persembahan Smart Insurance, Solusi Asuransi Untuk Pelaku Industri',
    'source': 'LipurankCom',
    'image': 'assets/images/article2.png',
  },
  {
    'title': 'Teknologi Blockchain dalam Asuransi Kesehatan',
    'source': 'TechNews.Com',
    'image': 'assets/images/article3.png',
  },
  {
    'title': 'Perkembangan Asuransi Syariah di Indonesia',
    'source': 'IslamicFinance.Com',
    'image': 'assets/images/article4.png',
  },
  {
    'title': 'Digitalisasi Klaim Asuransi Mempercepat Proses',
    'source': 'FinancialTech.Com',
    'image': 'assets/images/article1.png',
  },
  {
    'title': 'Asuransi Mikro untuk UMKM Indonesia',
    'source': 'BusinessDaily.Com',
    'image': 'assets/images/article2.png',
  },
];

