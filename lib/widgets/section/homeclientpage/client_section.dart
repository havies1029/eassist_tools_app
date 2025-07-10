import 'package:eassist_tools_app/blocs/gallery/gallerymembercari_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final double titleFontSize = isMobile
        ? 15.0
        : (isTablet ? 22.0 : 24.0);

    // Tetapkan 5 kolom dan atur aspect ratio agar baris sesuai
    final int crossAxisCount = isMobile ? 3 : 5;
    final double childAspectRatio = isMobile ? 1.1 : 1.6;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40.0 : 40.0,
        horizontal: 40.0,
      ),
      child: Center(
        child: Container(
          width: maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Judul
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: titleFontSize,
                    color: Colors.black,
                    height: 1.2,
                  ),
                  children: const [
                    TextSpan(text: 'Menampilkan '),
                    TextSpan(
                      text: 'Klien',
                      style: TextStyle(
                        color: Color(0xFF79AB43),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(text: ' Terpercaya Kami'),
                  ],
                ),
              ),
              SizedBox(height: isMobile ? 30.0 : 40.0),

              // Grid Klien
              BlocBuilder<GallerymemberCariBloc, GallerymemberCariState>(
                  builder: (context, state) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: isMobile ? 8.0 : 12.0,
                        mainAxisSpacing: isMobile ? 8.0 : 12.0,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemBuilder: (context, index) {
                        return ClientLogoCard(
                          imagePath: state.items[index].image1Url,
                          isMobile: isMobile,
                        );
                      },
                    );
                  }
              ),
            ],
          ),
        ),
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
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: widget.isMobile ? 100.0 : 120.0,
          height: widget.isMobile ? 100.0 : 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: widget.isMobile ? 80.0 : 100.0,
              height: widget.isMobile ? 80.0 : 100.0,
              child: Image.network(
                widget.imagePath,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
                isAntiAlias: true,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: widget.isMobile ? 100.0 : 120.0,
                    height: widget.isMobile ? 100.0 : 120.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.business,
                        color: Colors.grey.shade400,
                        size: widget.isMobile ? 40.0 : 48.0,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}