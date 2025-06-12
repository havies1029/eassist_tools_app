import 'package:flutter/material.dart';

class PeranJpsSection extends StatelessWidget {
  final BoxConstraints constraints;

  const PeranJpsSection({Key? key, required this.constraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isMobile = constraints.maxWidth < 768;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 40 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // ===== HEADER =====
              _buildHeader(isMobile),
              const SizedBox(height: 6),
              Text(
                'Menjadi mitra strategis dalam setiap proses asuransi Anda.',
                style: AppStyles.subtitleStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isMobile ? 40 : 60),

              // ===== BROKER =====
              _buildBrokerSection(),

              // ===== CONNECTOR SECTION =====
              const SizedBox(height: 20),

              if (isMobile)
                _buildMobileConnectorAndItems()
              else
                _buildDesktopConnectorAndItems(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppStyles.headerStyle.copyWith(fontSize: isMobile ? 20 : 27),
        children: [
          const TextSpan(text: 'Peran '),
          TextSpan(
            text: 'J',
            style: AppStyles.headerStyle.copyWith(
              color: AppColors.primaryGreen,
              fontSize: isMobile ? 20 : 27,
            ),
          ),
          TextSpan(
            text: 'P',
            style: AppStyles.headerStyle.copyWith(
              color: AppColors.primaryOrange,
              fontSize: isMobile ? 20 : 27,
            ),
          ),
          TextSpan(
            text: 'S',
            style: AppStyles.headerStyle.copyWith(
              color: AppColors.primaryGreen,
              fontSize: isMobile ? 20 : 27,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrokerSection() {
    return Column(
      children: [
        Container(
          width: 63,
          height: 63,
          decoration: BoxDecoration(
            color: AppColors.brokerBg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.textColor.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_outline,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Broker',
          style: AppStyles.titleStyle.copyWith(
            color: AppColors.brokerBg,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopConnectorAndItems() {
    return LayoutBuilder(builder: (context, boxConstraints) {
      final maxWidth = boxConstraints.maxWidth;
      const spacing = 48.0;
      final itemWidth = (maxWidth - spacing * 3) / 4;

      // Calculate positions for arrows
      final positions = <double>[];
      for (int i = 0; i < 4; i++) {
        final itemCenter = (itemWidth * i) + (spacing * i) + (itemWidth / 2);
        positions.add(itemCenter);
      }

      return Column(
        children: [
          // Custom connector with accurate positioning
          SizedBox(
            width: maxWidth,
            height: 60,
            child: CustomPaint(
              painter: ConnectorPainter(
                arrowPositions: positions,
                totalWidth: maxWidth,
                isMobile: false,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Role items
          _buildRoleItems(false, spacing, itemWidth),
        ],
      );
    });
  }

  Widget _buildMobileConnectorAndItems() {
    const double itemWidth = 260.0;
    const double spacing = 24.0;
    const double horizontalPadding = 16.0;

    final double totalScrollWidth = (itemWidth * 4) + (spacing * 3);
    final positions = List.generate(4, (i) {
      return (itemWidth * i) + (spacing * i) + (itemWidth / 2);
    });

    return SizedBox(
      height: 420,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: SizedBox(
          width: totalScrollWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Connector garis
              SizedBox(
                height: 60,
                width: totalScrollWidth,
                child: CustomPaint(
                  painter: ConnectorPainter(
                    arrowPositions: positions,
                    totalWidth: totalScrollWidth,
                    isMobile: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Role items
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(roleItems.length, (i) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: i == roleItems.length - 1 ? 0 : spacing,
                    ),
                    child: SizedBox(
                      width: itemWidth,
                      child: _buildRoleItem(roleItems[i]),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleItems(bool isMobile, double spacing, double itemWidth) {
    if (isMobile) {
      return SizedBox(
        height: 360,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: roleItems.map((roleData) {
              return Padding(
                padding: const EdgeInsets.only(right: 24),
                child: SizedBox(
                  width: 260,
                  child: _buildRoleItem(roleData),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: spacing,
      runSpacing: 40,
      children: roleItems.map((roleData) {
        return SizedBox(
          width: itemWidth,
          child: _buildRoleItem(roleData),
        );
      }).toList(),
    );
  }

  Widget _buildRoleItem(RoleData roleData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 63,
          height: 63,
          decoration: BoxDecoration(
            color: roleData.bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(roleData.icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          roleData.title,
          style: AppStyles.titleStyle.copyWith(color: roleData.bgColor),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: roleData.descriptions.map((desc) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 8),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.textColorMuted,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 240),
                    child: Text(
                      desc,
                      style: AppStyles.descriptionStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ConnectorPainter extends CustomPainter {
  final List<double> arrowPositions;
  final double totalWidth;
  final bool isMobile;

  ConnectorPainter({
    required this.arrowPositions,
    required this.totalWidth,
    required this.isMobile,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double lineThickness = 3.0;
    final double arrowSize = 8.0;
    final double verticalLineLength = 25.0;
    final double horizontalLineY = 15.0;
    final double brokerLineLength = 20.0;

    // === Adjusted start & end positions ===
    final double startX = arrowPositions.first;
    final double endX = arrowPositions.last;

    final Paint horizontalPaint = Paint()
      ..strokeWidth = lineThickness
      ..shader = LinearGradient(
        colors: AppColors.roleColors,
        stops: [0.0, 0.33, 0.66, 1.0],
      ).createShader(Rect.fromLTWH(startX, horizontalLineY, endX - startX, lineThickness));

    // ✅ Draw horizontal line between connectors only
    canvas.drawLine(
      Offset(startX, horizontalLineY),
      Offset(endX, horizontalLineY),
      horizontalPaint,
    );

    // === Draw center broker vertical line ===
    final double brokerX = totalWidth / 2;
    final Paint brokerPaint = Paint()
      ..color = AppColors.brokerBg
      ..strokeWidth = lineThickness
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(brokerX, horizontalLineY - brokerLineLength),
      Offset(brokerX, horizontalLineY),
      brokerPaint,
    );

    // === Draw vertical lines & arrows ===
    for (int i = 0; i < arrowPositions.length; i++) {
      final double x = arrowPositions[i];
      final Color color = AppColors.roleColors[i];

      final Paint verticalPaint = Paint()
        ..color = color
        ..strokeWidth = lineThickness
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        Offset(x, horizontalLineY),
        Offset(x, horizontalLineY + verticalLineLength),
        verticalPaint,
      );

      final Path arrowPath = Path();
      final double arrowY = horizontalLineY + verticalLineLength + arrowSize;

      arrowPath.moveTo(x, arrowY);
      arrowPath.lineTo(x - arrowSize, arrowY - arrowSize);
      arrowPath.lineTo(x + arrowSize, arrowY - arrowSize);
      arrowPath.close();

      canvas.drawPath(arrowPath, Paint()..color = color..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(ConnectorPainter oldDelegate) {
    return oldDelegate.arrowPositions != arrowPositions ||
        oldDelegate.totalWidth != totalWidth ||
        oldDelegate.isMobile != isMobile;
  }
}

// =================== STYLES & CONSTANTS ===================

class AppStyles {
  static const String fontFamily = 'Satoshi';

  static const TextStyle headerStyle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    color: AppColors.textColor,
  );

  static const TextStyle titleStyle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  static const TextStyle descriptionStyle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    color: AppColors.textColorMuted,
    height: 1.3,
  );
}

class AppColors {
  static const Color primaryGreen = Color(0xFF79AB43);
  static const Color primaryOrange = Color(0xFFFAA232);
  static const Color textColor = Colors.black;
  static const Color textColorMuted = Color(0xFF585858);

  static const Color brokerBg = Color(0xFF78AB41);
  static const Color assessmentBg = Color(0xFF507528);
  static const Color architectBg = Color(0xFF638E34);
  static const Color consultantBg = Color(0xFF76A83F);
  static const Color lawyerBg = Color(0xFF9FE059);

  static const List<Color> roleColors = [
    assessmentBg,
    architectBg,
    consultantBg,
    lawyerBg,
  ];
}

// =================== DATA MODELS & API INTEGRATION ===================

class RoleData {
  final Color bgColor;
  final IconData icon;
  final String title;
  final List<String> descriptions;

  const RoleData({
    required this.bgColor,
    required this.icon,
    required this.title,
    required this.descriptions,
  });

  // Factory method untuk parsing dari API response
  factory RoleData.fromJson(Map<String, dynamic> json) {
    return RoleData(
      bgColor: _getColorFromString(json['bgColor']),
      icon: _getIconFromString(json['icon']),
      title: json['title'],
      descriptions: List<String>.from(json['descriptions']),
    );
  }

  // Helper method untuk convert string ke Color
  static Color _getColorFromString(String colorStr) {
    switch (colorStr) {
      case 'assessment':
        return AppColors.assessmentBg;
      case 'architect':
        return AppColors.architectBg;
      case 'consultant':
        return AppColors.consultantBg;
      case 'lawyer':
        return AppColors.lawyerBg;
      default:
        return AppColors.assessmentBg;
    }
  }

  // Helper method untuk convert string ke IconData
  static IconData _getIconFromString(String iconStr) {
    switch (iconStr) {
      case 'bar_chart':
        return Icons.bar_chart;
      case 'architecture':
        return Icons.architecture;
      case 'headset_mic':
        return Icons.headset_mic;
      case 'balance':
        return Icons.balance;
      default:
        return Icons.bar_chart;
    }
  }
}

// =================== HARDCODED DATA (SEMENTARA - AKAN DIGANTI API) ===================

// Data ini akan diganti dengan API call
final List<RoleData> roleItems = [
  const RoleData(
    bgColor: AppColors.assessmentBg,
    icon: Icons.bar_chart,
    title: 'Assessment',
    descriptions: ['Mengumpulkan informasi'],
  ),
  const RoleData(
    bgColor: AppColors.architectBg,
    icon: Icons.architecture,
    title: 'Architect',
    descriptions: [
      'Merancang Syarat & Ketentuan',
      'Menyusun program asuransi',
      'Penempatan polis asuransi',
      'Memberikan saran opsi terbaik',
      'Pengelolaan asuransi',
    ],
  ),
  const RoleData(
    bgColor: AppColors.consultantBg,
    icon: Icons.headset_mic,
    title: 'Consultant',
    descriptions: [
      'Memberikan rekomendasi',
      'Memfasilitasi diskusi dua arah',
    ],
  ),
  const RoleData(
    bgColor: AppColors.lawyerBg,
    icon: Icons.balance,
    title: 'Lawyer',
    descriptions: [
      'Memberikan masukan demi hasil terbaik',
      'Membantu proses klaim agar berjalan lancar dan efektif',
    ],
  ),
];