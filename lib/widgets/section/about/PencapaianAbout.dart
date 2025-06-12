import 'package:flutter/material.dart';

class PencapaianSection extends StatelessWidget {
  final BoxConstraints constraints;

  const PencapaianSection({Key? key, required this.constraints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = constraints.maxWidth > 768;
    final bool isMobile = constraints.maxWidth < 768;

    // Outer Container dengan warna background full-width
    return Container(
      width: double.infinity,
      color: Colors.white, // background penuh
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            // Jika ingin padding atas/bawah tetap, bisa gunakan Padding di sini
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 40,
              vertical: isMobile ? 40 : 80,
            ),
            child: Column(
              children: [
                // Header Section
                Column(
                  children: [
                    Text(
                      'Pencapaian JPS',
                      style: TextStyle(
                        fontSize: isDesktop ? 18 : 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Text(
                        'Terpercaya sebagai broker asuransi unggulan dengan pertumbuhan dan kemitraan nasional yang konsisten.',
                        style: TextStyle(
                          fontSize: isDesktop ? 14 : 12,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Timeline Items
                if (isDesktop)
                  _buildDesktopTimeline()
                else
                  _buildMobileTimeline(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopTimeline() {
    return Column(
      children: [
        // Row 1: 2001 (Left) - 2007 (Right)
        _buildTimelineRow(
          leftItem: _buildTimelineItem('2001', Colors.green.shade600, [
            'JPS didirikan pada tahun 2001',
            'Memulai operasional dengan hanya enam karyawan',
            'Berhasil menyelesaikan klaim senilai 2 miliar IDR',
            'Mulai mendapatkan kepercayaan dari klien',
          ]),
          rightItem: _buildTimelineItem('2007', Colors.green.shade600, [
            'JPS mencatat pendapatan premi asuransi yang\nsignifikan selama periode ini',
          ]),
          connectHorizontal: true,
          connectVertical: true,
          lineColor: Colors.green.shade400,
        ),

        SizedBox(height: 56),

        // Row 2: 2019 (Left) - 2010 (Right)
        _buildTimelineRow(
          leftItem: _buildTimelineItem('2019', Colors.orange.shade400, [
            'Mengalami pertumbuhan yang pesat',
            'Berhasil menyelesaikan klaim hingga 300 miliar IDR',
            'Memulai proses digitalisasi sistem',
          ]),
          rightItem: _buildTimelineItem('2010', Colors.orange.shade400, [
            'Mengalami permasalahan internal selama periode 2008—2011',
          ]),
          connectHorizontal: true,
          connectVertical: true,
          lineColor: Colors.orange.shade400,
        ),

        SizedBox(height: 56),

        // Row 3: 2022 (Left) - 2023 (Right)
        _buildTimelineRow(
          leftItem: _buildTimelineItem('2022', Colors.green.shade600, [
            'Penurunan bisnis akibat pandemi COVID-19',
            'Memulai digitalisasi proses kerja secara menyeluruh',
          ]),
          rightItem: _buildTimelineItem('2023', Colors.green.shade600, [
            'Mendapatkan proyek dari berbagai BUMN dan BUMD',
            'Bisnis dan basis klien mulai tumbuh kembali',
            'Menerima sertifikasi ISO 27001:2022',
          ]),
          connectHorizontal: true,
          connectVertical: false,
          lineColor: Colors.green.shade400,
        ),

        SizedBox(height: 56),

        // Row 4: 2024 (Center)
        Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              child: _buildTimelineItem('2024', Colors.orange.shade400, [
                'Bekerja sama dengan bank-bank besar seperti DBS, CTBC, Mandiri, dan Bank of China',
                'Mulai menerapkan integrasi sistem antara bank dan perusahaan asuransi',
              ]),
            ),
            Expanded(child: Container()),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileTimeline() {
    return Column(
      children: [
        _buildMobileTimelineItem('2001', Colors.green.shade600, [
          'JPS didirikan pada tahun 2001',
          'Memulai operasional dengan hanya enam karyawan',
          'Berhasil menyelesaikan klaim senilai 2 miliar IDR',
          'Mulai mendapatkan kepercayaan dari klien',
        ]),

        SizedBox(height: 56),

        _buildMobileTimelineItem('2007', Colors.green.shade600, [
          'JPS mencatat pendapatan premi asuransi yang signifikan selama periode ini',
        ]),

        SizedBox(height: 56),

        _buildMobileTimelineItem('2010', Colors.orange.shade400, [
          'Mengalami permasalahan internal selama periode 2008—2011',
        ]),

        SizedBox(height: 56),

        _buildMobileTimelineItem('2019', Colors.orange.shade400, [
          'Mengalami pertumbuhan yang pesat',
          'Berhasil menyelesaikan klaim hingga 300 miliar IDR',
          'Memulai proses digitalisasi sistem',
        ]),

        SizedBox(height: 56),

        _buildMobileTimelineItem('2022', Colors.green.shade600, [
          'Penurunan bisnis akibat pandemi COVID-19',
          'Memulai digitalisasi proses kerja secara menyeluruh',
        ]),

        SizedBox(height: 56),

        _buildMobileTimelineItem('2023', Colors.green.shade600, [
          'Mendapatkan proyek dari berbagai BUMN dan BUMD',
          'Bisnis dan basis klien mulai tumbuh kembali',
          'Menerima sertifikasi ISO 27001:2022',
        ]),

        SizedBox(height: 56),

        _buildMobileTimelineItem('2024', Colors.orange.shade400, [
          'Bekerja sama dengan bank-bank besar seperti DBS, CTBC, Mandiri, dan Bank of China',
          'Mulai menerapkan integrasi sistem antara bank dan perusahaan asuransi',
        ]),
      ],
    );
  }

  Widget _buildTimelineRow({
    required Widget leftItem,
    required Widget rightItem,
    required bool connectHorizontal,
    required bool connectVertical,
    required Color lineColor,
  }) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: leftItem),
            SizedBox(width: 40),
            Expanded(child: rightItem),
          ],
        ),

        // Horizontal connecting line
        if (connectHorizontal)
          Positioned(
            left: 0,
            right: 0,
            top: 20,
            child: Row(
              children: [
                Expanded(child: Container()),
                Container(
                  width: 160,
                  height: 2,
                  child: CustomPaint(
                    painter: DottedLinePainter(color: lineColor),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),

        // Vertical connecting line
        if (connectVertical)
          Positioned(
            right: 0,
            top: 40,
            child: Container(
              width: 2,
              height: 120,
              child: CustomPaint(
                painter: DottedLinePainter(color: lineColor, isVertical: true),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTimelineItem(String year, Color dotColor, List<String> items) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: -24,
          top: 16,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: dotColor, width: 2),
              color: Colors.white,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              year,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items.map((item) => Padding(
                  padding: EdgeInsets.only(bottom: items.last == item ? 0 : 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 6, right: 8),
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileTimelineItem(String year, Color dotColor, List<String> items) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          left: -24,
          top: 16,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: dotColor, width: 2),
              color: Colors.white,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              year,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items.map((item) => Padding(
                  padding: EdgeInsets.only(bottom: items.last == item ? 0 : 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 6, right: 8),
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black87,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DottedLinePainter extends CustomPainter {
  final Color color;
  final bool isVertical;

  DottedLinePainter({required this.color, this.isVertical = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 4.0;
    const dashSpace = 4.0;

    if (isVertical) {
      double startY = 0;
      while (startY < size.height) {
        canvas.drawLine(
          Offset(size.width / 2, startY),
          Offset(size.width / 2, startY + dashWidth),
          paint,
        );
        startY += dashWidth + dashSpace;
      }
    } else {
      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(
          Offset(startX, size.height / 2),
          Offset(startX + dashWidth, size.height / 2),
          paint,
        );
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}