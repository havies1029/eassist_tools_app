import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/authentication/authentication_bloc.dart';

class AppTheme {
  static const String fontFamily = 'Satoshi-Regular';
  static const Color white = Colors.white;

  static double titleSize(bool isMobile) => isMobile ? 25 : 45;
  static double bodySize(bool isMobile) => isMobile ? 15 : 18;
  static double smallSize(bool isMobile) => isMobile ? 14 : 16;

  static EdgeInsets responsivePadding(BoxConstraints constraints) {
    final double width = constraints.maxWidth;
    final double horizontal = width > 1200
        ? 95
        : width > 992
        ? 64
        : width > 768
        ? 48
        : 24;
    final double vertical = width < 768 ? 24 : 40;
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  static EdgeInsets responsiveMargin(BoxConstraints constraints) {
    final double width = constraints.maxWidth;
    final double top = width < 768 ? 30 : 60;
    return EdgeInsets.only(top: top, bottom: 30);
  }
}

enum PageType {
  home,
  about,
  article,
  testimony,
  active_asset,
  find_insurance,
  home_client,
  management_polis,
  report_claim,
  user_jps,
  user_non_jps,
}

class HeroSection extends StatelessWidget {
  final BoxConstraints constraints;
  final PageType? pageType;

  const HeroSection({
    super.key,
    required this.constraints,
    this.pageType,
  });

  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth =>
      constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.95;

  @override
  Widget build(BuildContext context) {
    final titleData = _getTitleData(context);
    final descData = _getDescriptionData();

    return Padding(
      padding: AppTheme.responsivePadding(constraints),
      child: Container(
        width: maxWidth,
        margin: AppTheme.responsiveMargin(constraints),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: titleData['bold'],
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: AppTheme.titleSize(isMobile),
                      fontWeight: FontWeight.w700,
                      color: AppTheme.white,
                      height: 1.2,
                    ),
                  ),
                  if (titleData['normal'] != null)
                    TextSpan(
                      text: titleData['normal'],
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: AppTheme.titleSize(isMobile),
                        fontWeight: FontWeight.w400,
                        color: AppTheme.white,
                        height: 1.2,
                      ),
                    ),
                  if (titleData['bold1'] != null)
                    TextSpan(
                      text: titleData['bold1'],
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: AppTheme.titleSize(isMobile),
                        fontWeight: FontWeight.w700,
                        color: AppTheme.white,
                        height: 1.2,
                      ),
                    ),
                  if (titleData['normal3'] != null)
                    TextSpan(
                      text: titleData['normal3'],
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: AppTheme.titleSize(isMobile),
                        fontWeight: FontWeight.w400,
                        color: AppTheme.white,
                        height: 1.2,
                      ),
                    ),
                  if (titleData['bold3'] != null)
                    TextSpan(
                      text: titleData['bold3'],
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: AppTheme.titleSize(isMobile),
                        fontWeight: FontWeight.w700,
                        color: AppTheme.white,
                        height: 1.2,
                      ),
                    ),
                  if (titleData['normal4'] != null)
                    TextSpan(
                      text: titleData['normal4'],
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: AppTheme.titleSize(isMobile),
                        fontWeight: FontWeight.w400,
                        color: AppTheme.white,
                        height: 1.2,
                      ),
                    ),
                  if (titleData['bold4'] != null)
                    TextSpan(
                      text: titleData['bold4'],
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: AppTheme.titleSize(isMobile),
                        fontWeight: FontWeight.w700,
                        color: AppTheme.white,
                        height: 1.2,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Description
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: descData['normal1'],
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontSize: AppTheme.bodySize(isMobile),
                      color: AppTheme.white.withOpacity(0.9),
                      height: 1.6,
                    ),
                  ),
                  if (descData['bold'] != null)
                    TextSpan(
                      text: descData['bold'],
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: AppTheme.smallSize(isMobile),
                        fontWeight: FontWeight.w600,
                        color: AppTheme.white,
                        height: 1.6,
                      ),
                    ),
                  if (descData['normal2'] != null)
                    TextSpan(
                      text: descData['normal2'],
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontSize: AppTheme.smallSize(isMobile),
                        color: AppTheme.white.withOpacity(0.9),
                        height: 1.6,
                      ),
                    ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // TITLE DATA WITH BLOC INTEGRATION
  // ============================================
  Map<String, String> _getTitleData(BuildContext context) {
    switch (pageType) {
      case PageType.home_client:
        final state = context.read<AuthenticationBloc>().state;
        String name = "[Nama User]";
        if (state is AuthenticationAuthenticated &&
            state.user.custType == "C") {
          name = state.user.nama ?? "[Nama User]";
        }
        return {
          'bold': 'Selamat Datang, $name !\n',
          'normal': 'Berikut ringkasan polis Anda Hari ini:',
        };
      case PageType.about:
        return {
          'bold': 'Mengenal JPS: ',
          'normal': 'Klaim mudah, perlindungan \naman',
        };
      case PageType.article:
        return {
          'bold': 'Selamat datang ',
          'normal': 'di pusat informasi literasi JPS!',
        };
      case PageType.testimony:
        return {
          'bold': 'Bukti Nyata ',
          'normal': 'Pelayanan dan Kepercayaan',
        };
      case PageType.active_asset:
        return {
          'bold': 'Aset Terlindungi\n',
          'normal': 'Hidup Lebih ',
          'bold1': 'Tenang.',
        };
      case PageType.find_insurance:
        return {
          'bold': 'Jenis asuransi ',
          'normal': 'apa yang\nkamu butuhkan?',
        };
      case PageType.report_claim:
        return {
          'bold': 'Proses Klaim Mudah ',
          'normal': 'dan ',
          'bold1': 'Cepat\n',
          'normal3': 'di ',
          'bold3': 'JPS'
        };
      case PageType.home:
      default:
        return {
          'bold': 'Klien Kami, Prioritas Kami: \nMemberikan Solusi Terbaik untuk Anda!\n',
          'normal': 'Berikut ringkasan polis Anda Hari ini:',
        };
    }
  }

  Map<String, String> _getDescriptionData() {
    switch (pageType) {
      case PageType.about:
        return {
          'normal1':
          'JPS hadir memberikan informasi yang jelas, layanan yang praktis, dan solusi yang tepat untuk membantu Anda memilih terbaik dengan cara paling ',
          'bold': 'mudah',
          'normal2': '.',
        };
      case PageType.article:
        return {
          'normal1':
          'Temukan panduan praktis, istilah-istilah penting, tips memilih produk asuransi, hingga kisah nyata manfaat asuransi mikro di tengah masyarakat.',
        };
      case PageType.testimony:
        return {
          'normal1': 'JPS mendapatkan kepercayaan dari puluhan nasabah dan mitra melalui layanan yang ',
          'bold': 'jelas, praktis, dan solutif',
          'normal2': '. Berikut adalah pengalaman nyata dari mereka yang telah merasakan manfaatnya.',
        };
      case PageType.active_asset:
        return {
          'bold': 'Asuransi aktif',
          'normal1': 'menjamin perlindungan saat kamu membutuhkannya.',
        };
      case PageType.find_insurance:
        return {
          'bold': 'Pilih kategori asuransi ',
          'normal2': 'yang sesuai dengan kebutuhan Anda.',
        };
      case PageType.home_client:
        return {
          'normal1':
          'JPS adalah platform asuransi pintar yang memudahkan kamu mencari, memilih,\ndan klaim asuransi hanya dalam hitungan menit ',
          'bold': 'cepat, aman, dan terdaftar OJK',
          'normal2': '.',
        };
      case PageType.report_claim:
        return {
          'normal1': 'Ajukan ',
          'bold': 'klaim asuransi ',
          'normal2': 'hanya dalam beberapa langkah ',
          'bold1': 'pratiks. ',
          'normal3': 'Kami bantu pastikan prosesnya ',
          'bold3': 'lancar ',
          'normal4': 'dan ',
          'bold4': 'transparan.'
        };
      case PageType.user_jps:
      case PageType.user_non_jps:
        return {
          'bold': 'Asuransi aktif ',
          'normal': 'menjamin perlindungan saat kamu membutuhkannya.',
        };
      case PageType.management_polis:
        return {
          'normal1': 'Solusi lengkap pengelolaan polis aset Anda, hadir dengan informasi yang akurat, ringkas, dan selalu terpantau.',
        };
      case PageType.home:
      default:
        return {};
    }
  }
}
