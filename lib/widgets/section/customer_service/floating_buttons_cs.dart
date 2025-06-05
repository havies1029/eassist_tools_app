import 'package:flutter/material.dart';

class FloatingButtonsCS extends StatelessWidget {
  final BoxConstraints constraints;

  const FloatingButtonsCS({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth => constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;
  double get sidePadding => constraints.maxWidth > 1200 ? 64.0 : 32.0;

  @override
  Widget build(BuildContext context) {
    final items = getContactItems();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sidePadding),
      child: Container(
        width: maxWidth,
        margin: const EdgeInsets.only(top: 10),
        child: isMobile
            ? Column(
          children: items
              .map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildContactCard(
              icon: item.icon,
              title: item.title,
              subtitle: item.subtitle,
            ),
          ))
              .toList(),
        )
            : IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: items
                .map((item) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: _buildContactCard(
                  icon: item.icon,
                  title: item.title,
                  subtitle: item.subtitle,
                ),
              ),
            ))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _CSStyle.buildIconCircle(icon, size: 20),
              const SizedBox(width: 8),
              Text(title, style: _CSStyle.titleMobile),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: _CSStyle.subtitleMobile,
          ),
        ],
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CSStyle.buildIconCircle(icon, size: 24),
          const SizedBox(height: 8),
          Text(title, style: _CSStyle.titleDesktop, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text(
            subtitle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: _CSStyle.subtitleDesktop,
          ),
        ],
      ),
    );
  }
}

// ======================
// STYLING & THEME SETUP
// ======================

class _CSStyle {
  static const String font = 'Satoshi-Regular';
  static const Color primary = Color(0xFF79AB43);
  static const Color darkText = Color(0xFF1C1C1C);

  static Widget buildIconCircle(IconData icon, {required double size}) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: primary, size: size),
    );
  }

  static const TextStyle titleMobile = TextStyle(
    fontFamily: font,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: darkText,
  );

  static const TextStyle titleDesktop = TextStyle(
    fontFamily: font,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: darkText,
  );

  static const TextStyle subtitleMobile = TextStyle(
    fontFamily: font,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: primary,
    height: 1.4,
  );

  static const TextStyle subtitleDesktop = TextStyle(
    fontFamily: font,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: primary,
    height: 1.4,
  );
}

// ===========================
// DATA KONTAK (SIAP API CALL)
// ===========================

class ContactItem {
  final IconData icon;
  final String title;
  final String subtitle;

  ContactItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

List<ContactItem> getContactItems() {
  // TODO: Replace with API call
  return [
    ContactItem(
      icon: Icons.location_on_outlined,
      title: 'Alamat',
      subtitle: 'PT Jaya Proteksindo Sakti\nKramat Center Blok A4 Lt.1,\nJl. Kramat Raya No. 7-9\nSenen, Jakarta Pusat 10450',
    ),
    ContactItem(
      icon: Icons.phone_outlined,
      title: 'No. Telephone',
      subtitle: '(021) 314 89 4748/51',
    ),
    ContactItem(
      icon: Icons.email_outlined,
      title: 'Email',
      subtitle: 'marcom@jayaproteksindo.co.id',
    ),
  ];
}