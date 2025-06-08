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
        ? 18.0
        : (isTablet ? 22.0 : 24.0);

    /*
    final List<String> clientLogos = List.generate(
      20,
          (index) => 'assets/images/client_${index + 1}.png',
    );
    */

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
                      //itemCount: clientLogos.length,
                      itemCount: state.items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: isMobile ? 8.0 : 12.0,
                        mainAxisSpacing: isMobile ? 8.0 : 12.0,
                        childAspectRatio: childAspectRatio,
                      ),
                      itemBuilder: (context, index) {
                        return ClientLogoCard(
                          //imagePath: clientLogos[index],
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
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isHovered ? 0.12 : 0.06),
                blurRadius: _isHovered ? 8.0 : 4.0,
                offset: Offset(0, _isHovered ? 3 : 1),
              ),
            ],
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFF79AB43)
                  : Colors.grey.shade200,
              width: _isHovered ? 2.0 : 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(widget.isMobile ? 6.0 : 16.0), // Padding kecil untuk mobile
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.network(
                widget.imagePath,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
                isAntiAlias: true,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Icon(
                      Icons.business,
                      color: Colors.grey.shade400,
                      size: widget.isMobile ? 24.0 : 32.0,
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
