import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/authentication/authentication_bloc.dart';
import '../../../blocs/gen_profile/mrekan1crud_bloc.dart';

class AppTheme {
  static const String fontFamily = 'Satoshi-Regular';
  static const Color white = Colors.white;
  static const Color primaryColor = Color(0xFF79AB43);

  static double titleSize(bool isMobile) => isMobile ? 20 : 43;
  static double bodySize(bool isMobile) => isMobile ? 13 : 18;

  static EdgeInsets responsivePadding(BoxConstraints constraints) {
    final double width = constraints.maxWidth;

    final double horizontal = width > 1200
        ? 95
        : width > 992
        ? 64
        : width > 768
        ? 48
        : 24;

    if (width < 768) {
      return EdgeInsets.only(top: 20, left: horizontal, right: horizontal);
    } else {
      return EdgeInsets.symmetric(horizontal: horizontal, vertical: 40);
    }
  }

  static EdgeInsets responsiveMargin(BoxConstraints constraints, {SectionType? sectionType}) {
    final double width = constraints.maxWidth;
    final double top = width < 768 ? 30 : 60;
    final double bottom = (sectionType == SectionType.home || sectionType == SectionType.home_client) ? 0 : 30;

    return EdgeInsets.only(top: top, bottom: bottom);
  }
}

enum SectionType {
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
  final SectionType? sectionType;

  const HeroSection({
    super.key,
    required this.constraints,
    this.sectionType,
  });

  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth =>
      constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.95;

  bool get hasBackgroundColor =>
      sectionType == SectionType.home || sectionType == SectionType.home_client;

  bool get hasHumanImage =>
      sectionType == SectionType.home || sectionType == SectionType.home_client;

  @override
  Widget build(BuildContext context) {
    final titleData = _getTitleData(context);
    final descData = _getDescriptionData();

    Widget content = hasHumanImage
        ? _buildContentWithImage(titleData, descData)
        : _buildContentWithoutImage(titleData, descData);

    if (hasBackgroundColor) {
      return Padding(
        padding: AppTheme.responsivePadding(constraints),
        child: Container(
          width: maxWidth,
          margin: AppTheme.responsiveMargin(constraints, sectionType: sectionType),
          padding: EdgeInsets.all(isMobile ? 0 : 40),
          decoration: BoxDecoration(
            color: Color(0xFF79AB43),
            borderRadius: BorderRadius.circular(isMobile ? 0 : 20),
          ),

          child: content,
        ),
      );
    }

    return Padding(
      padding: AppTheme.responsivePadding(constraints),
      child: Container(
        width: maxWidth,
        margin: AppTheme.responsiveMargin(constraints, sectionType: sectionType),
        child: content,
      ),
    );
  }

  Widget _buildContentWithImage(Map<String, String> titleData, Map<String, String> descData) {
    final bool isTablet = constraints.maxWidth >= 768 && constraints.maxWidth < 1024;

    if (isMobile) {
      return SizedBox(
        height: 250,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: 0,
              top: 60,
              child: _buildHumanImage(),
            ),
            Positioned.fill(
              top: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: _buildTextContent(titleData, descData),
              ),
            ),
          ],
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: _buildTextContent(titleData, descData),
            ),
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            const SizedBox(width: 300, height: 250),
            Positioned(
              right: -40,
              bottom: isTablet ? -40 : -10,
              child: SizedBox(width: 360, child: _buildHumanImage()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContentWithoutImage(Map<String, String> titleData, Map<String, String> descData) {
    return _buildTextContent(titleData, descData);
  }

  Widget _buildTextContent(Map<String, String> titleData, Map<String, String> descData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        RichText(
          text: TextSpan(
            children: _buildTitleSpans(titleData),
          ),
        ),
        const SizedBox(height: 10),

        // Description
        Text.rich(
          TextSpan(
            children: _buildDescriptionSpans(descData),
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  List<TextSpan> _buildTitleSpans(Map<String, String> titleData) {
    List<TextSpan> spans = [];

    final keys = ['bold', 'normal', 'bold1', 'normal3', 'bold3', 'normal4', 'bold4'];

    for (String key in keys) {
      if (titleData[key] != null && titleData[key]!.isNotEmpty) {
        spans.add(
          TextSpan(
            text: titleData[key],
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: AppTheme.titleSize(isMobile),
              fontWeight: key.startsWith('bold') ? FontWeight.w700 : FontWeight.w400,
              color: AppTheme.white,
              height: 1.2,
            ),
          ),
        );
      }
    }

    return spans;
  }

  List<TextSpan> _buildDescriptionSpans(Map<String, String> descData) {
    List<TextSpan> spans = [];

    final keys = ['normal1', 'bold', 'normal2', 'bold1', 'normal3', 'bold3', 'normal4', 'bold4'];

    for (String key in keys) {
      if (descData[key] != null && descData[key]!.isNotEmpty) {
        spans.add(
          TextSpan(
            text: descData[key],
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontSize: key.startsWith('bold') ? AppTheme.bodySize(isMobile) : AppTheme.bodySize(isMobile),
              fontWeight: key.startsWith('bold') ? FontWeight.w600 : FontWeight.w400,
              color: key.startsWith('bold') ? AppTheme.white : AppTheme.white.withOpacity(0.9),
              height: 1.6,
            ),
          ),
        );
      }
    }

    return spans;
  }

  Widget _buildHumanImage() {
    return Image.asset(
      'assets/images/human.png',
      width: isMobile ? 182.37 : null,
      height: isMobile ? 197 : null,
      fit: BoxFit.contain,
    );
  }

  // ============================================
  // TITLE DATA WITH BLOC INTEGRATION
  // ============================================
  Map<String, String> _getTitleData(BuildContext context) {
    switch (sectionType) {
      case SectionType.home_client:
        final authState = context.watch<AuthenticationBloc>().state;
        final rekanState = context.watch<MRekan1CrudBloc>().state;
        String name = "[Nama User]";

        // Ambil dari Authentication jika custType C
        if (authState is AuthenticationAuthenticated && authState.user.custType == "C") {
          name = authState.user.nama ?? name;
        }

        // Override jika dari rekan 1 tersedia dan valid
        if (rekanState.isLoaded &&
            rekanState.record?.rekanNama != null &&
            rekanState.record!.rekanNama!.isNotEmpty) {
          name = rekanState.record!.rekanNama!;
        }

        return {
          'bold': 'Selamat Datang, $name !\n',
          'normal': 'Berikut ringkasan polis Anda Hari ini:',
        };
      case SectionType.about:
        return {
          'bold': 'Mengenal JPS: ',
          'normal': 'Klaim mudah, perlindungan \naman',
        };
      case SectionType.article:
        return {
          'bold': 'Selamat datang ',
          'normal': 'di pusat informasi literasi JPS!',
        };
      case SectionType.testimony:
        return {
          'bold': 'Bukti Nyata ',
          'normal': 'Pelayanan dan Kepercayaan',
        };
      case SectionType.active_asset:
        return {
          'bold': 'Aset Terlindungi\n',
          'normal': 'Hidup Lebih ',
          'bold1': 'Tenang.',
        };
      case SectionType.find_insurance:
        return {
          'bold': 'Jenis asuransi ',
          'normal': 'apa yang\nkamu butuhkan?',
        };
      case SectionType.report_claim:
        return {
          'bold': 'Proses Klaim Mudah ',
          'normal': 'dan ',
          'bold1': 'Cepat\n',
          'normal3': 'di ',
          'bold3': 'JPS'
        };
      case SectionType.home:
      default:
        return {
          'bold': 'Klien Kami, Prioritas Kami: \nMemberikan Solusi Terbaik untuk Anda!',
        };
    }
  }

  Map<String, String> _getDescriptionData() {
    switch (sectionType) {
      case SectionType.about:
        return {
          'normal1':
          'JPS hadir memberikan informasi yang jelas, layanan yang praktis, dan solusi yang tepat untuk membantu Anda memilih terbaik dengan cara paling mudah.',
        };
      case SectionType.article:
        return {
          'normal1':
          'Temukan panduan praktis, istilah-istilah penting, tips memilih produk asuransi, hingga kisah nyata manfaat asuransi mikro di tengah masyarakat.',
        };
      case SectionType.testimony:
        return {
          'normal1': 'JPS mendapatkan kepercayaan dari puluhan nasabah dan mitra melalui layanan yang ',
          'bold': 'jelas, praktis, dan solutif',
          'normal2': '. Berikut adalah pengalaman nyata dari mereka yang telah merasakan manfaatnya.',
        };
      case SectionType.active_asset:
        return {
          'bold': 'Asuransi aktif',
          'normal1': 'menjamin perlindungan saat kamu membutuhkannya.',
        };
      case SectionType.find_insurance:
        return {
          'bold': 'Pilih kategori asuransi ',
          'normal2': 'yang sesuai dengan kebutuhan Anda.',
        };
      case SectionType.home_client:
        return {
          'normal1':
          'JPS adalah platform asuransi pintar yang memudahkan kamu mencari, memilih,\ndan klaim asuransi hanya dalam hitungan menit ',
          'bold': 'cepat, aman, dan terdaftar OJK',
          'normal2': '.',
        };
      case SectionType.report_claim:
        return {
          'normal1': 'Ajukan ',
          'bold': 'klaim asuransi ',
          'normal2': 'hanya dalam beberapa langkah ',
          'bold1': 'praktis. ',
          'normal3': 'Kami bantu pastikan prosesnya ',
          'bold3': 'lancar ',
          'normal4': 'dan ',
          'bold4': 'transparan.'
        };
      case SectionType.user_jps:
      case SectionType.user_non_jps:
        return {
          'bold': 'Asuransi aktif ',
          'normal1': 'menjamin perlindungan saat kamu membutuhkannya.',
        };
      case SectionType.management_polis:
        return {
          'normal1': 'Solusi lengkap pengelolaan polis aset Anda, hadir dengan informasi yang akurat, ringkas, dan selalu terpantau.',
        };
      case SectionType.home:
        return {
          'normal1':
          'JPS adalah platform asuransi pintar yang memudahkan kamu mencari, memilih, dan klaim asuransi hanya dalam hitungan menit ',
          'bold': 'cepat, aman, dan terdaftar OJK',
          'normal2': '.',
        };
      default:
        return {};
    }
  }
}