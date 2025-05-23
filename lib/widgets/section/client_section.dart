import 'package:flutter/material.dart';
import 'dart:math' show pi;

class ClientSection extends StatelessWidget {
  final BoxConstraints constraints;
  const ClientSection({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = constraints.maxWidth < 768;
    final double maxWidth = constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;

    final List<String> clientLogos = List.generate(
      20,
          (index) => 'assets/images/client_${index + 1}.png',
    );

    int crossAxisCount = 2;
    if (constraints.maxWidth >= 1024) {
      crossAxisCount = 5;
    } else if (constraints.maxWidth >= 768) {
      crossAxisCount = 3;
    }

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Center(
        child: Container(
          width: maxWidth,
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Judul
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'Satoshi-Regular',
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: 'Menampilkan '),
                    TextSpan(
                      text: 'Klien',
                      style: TextStyle(color: Color(0xFF79AB43)),
                    ),
                    TextSpan(text: ' Terpercaya Kami'),
                  ],
                ),
              ),
              const SizedBox(height: 40.0),

              // Grid Logo Klien
              LayoutBuilder(
                builder: (context, box) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: clientLogos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 1.5,
                    ),
                    itemBuilder: (context, index) {
                      return ClientLogoCard(imagePath: clientLogos[index]);
                    },
                  );
                },
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
  const ClientLogoCard({super.key, required this.imagePath});

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
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.08),
                blurRadius: _isHovered ? 10.0 : 5.0,
                offset: Offset(0, _isHovered ? 4 : 2),
              ),
            ],
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high, // ✅ Anti-blur
            ),
          ),
        ),
      ),
    );
  }
}
