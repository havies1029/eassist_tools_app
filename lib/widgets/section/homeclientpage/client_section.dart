import 'package:eassist_tools_app/blocs/gallery/gallerymembercari_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClientSection extends StatefulWidget {
  final BoxConstraints constraints;

  const ClientSection({super.key, required this.constraints});

  @override
  State<ClientSection> createState() => ClientSectionState();
}

class ClientSectionState extends State<ClientSection> {

  @override
  void initState() {
    super.initState();

    context.read<GallerymemberCariBloc>().add(RefreshGallerymemberCariEvent());
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = widget.constraints.maxWidth < 768;
    final bool isTablet =
        widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;
    final double maxWidth = widget.constraints.maxWidth > 1200
        ? 1200
        : widget.constraints.maxWidth * 0.9;

    // Hitung ukuran font untuk judul:
    final double titleFontSize = isMobile ? 20 : isTablet ? 24 : 27;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 5.0 : 20.0,
        horizontal: 40.0,
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/icons/shield.svg',
            width: isMobile ? 35 : 50.0,
            height: isMobile ? 35 : 50.0,
          ),

          SizedBox(height: 15),

          // Judul
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'Satoshi-Regular',
                fontSize: titleFontSize,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: const [
                TextSpan(text: 'Dipercaya '),
                TextSpan(text: 'Lembaga '),
                TextSpan(
                  text: 'Ternama',
                  style: TextStyle(
                    color: Color(0xFF91C050),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          // Subtitle
          Text(
            'Kami dipercaya oleh berbagai institusi dan regulator di Indonesia untuk solusi asuransi yang aman dan profesional.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: isMobile ? 12.0 : 15.0,
              color: const Color(0xFF6B7280),
            ),
          ),

          SizedBox(height: 15.0),

          // Grid Klien - Menggunakan Wrap untuk layout yang lebih fleksibel
          BlocBuilder<GallerymemberCariBloc, GallerymemberCariState>(
              builder: (context, state) {
                return Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: isMobile ? 20.0 : 40.0, // Jarak horizontal antar logo
                    runSpacing: isMobile ? 15.0 : 20.0, // Jarak vertical antar baris
                    children: state.items.map((item) {
                      return ClientLogoCard(
                        imagePath: item.image1Url,
                        isMobile: isMobile,
                      );
                    }).toList(),
                  ),
                );
              }
          ),

          SizedBox(height: isMobile ? 16.0 : 10.0),

          // Footer text
          Text(
            'Terdaftar dan diawasi oleh OJK',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Satoshi-Regular',
              fontSize: 15.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ClientLogoCard extends StatefulWidget {
  final String imagePath;
  final bool isMobile;

  const ClientLogoCard({
    super.key,
    required this.imagePath,
    this.isMobile = false,
  });

  @override
  State<ClientLogoCard> createState() => _ClientLogoCardState();
}

class _ClientLogoCardState extends State<ClientLogoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.isMobile ? 100.0 : 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: SizedBox(
          width: widget.isMobile ? 94 : 206,
          height: widget.isMobile ? 62.89 : 109,
          child: Image.network(
            widget.imagePath,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
            isAntiAlias: true,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: widget.isMobile ? 94 : 100.0,
                height: widget.isMobile ? 62.89 : 60.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(
                  child: Icon(
                    Icons.business,
                    color: Colors.grey.shade400,
                    size: widget.isMobile ? 20.0 : 24.0,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}