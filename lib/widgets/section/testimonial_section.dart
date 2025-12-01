import 'dart:math' show pi;
import 'package:flutter/material.dart';
import '../../pages/testimony_page/testimony_main.dart'; // Untuk navigasi "Tampilkan semua"

class TestimonialSection extends StatelessWidget {
  final BoxConstraints constraints;

  const TestimonialSection({super.key, required this.constraints});

  // Daftar testimoni statis (gambar asset, nama, quote)
  final List<Map<String, String>> _testimonials = const [
    {
      'image': 'assets/images/t1.png',
      'name': 'Putri Ariana',
      'quote': '“Proses klaim cepat dan tanpa ribet. Terima kasih JPS!”',
    },
    {
      'image': 'assets/images/t2.png',
      'name': 'Brian Domani',
      'quote': '“Sudah coba beberapa asuransi, tapi JPS paling transparan.”',
    },
    {
      'image': 'assets/images/t3.png',
      'name': 'Monita Vonita',
      'quote': '“Klaim saya diproses dengan cepat tanpa drama.”',
    },
    {
      'image': 'assets/images/t4.png',
      'name': 'Rian Pramaja',
      'quote': '“Prosesnya mudah dan jelas. Recommended banget!”',
    },
    {
      'image': 'assets/images/t5.png',
      'name': 'Novia Wijaya',
      'quote': '“Pelayanan ramah dan sangat membantu saat pengajuan klaim !”',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = constraints.maxWidth < 768;
    final double maxWidth = constraints.maxWidth > 1200
        ? 1200
        : constraints.maxWidth * 0.9;

    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth > 1200 ? 40.0 : 40.0,
        ),
        child: Center(
          child: SizedBox(
            width: maxWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: isMobile ? 25.0 : 70.0),
            RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontFamily: 'Satoshi-Regular',
                      fontSize: isMobile ? 18.0 : 25.0, // Judul: 15 mobile
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(text: 'Testimoni Nasabah '),
                      const TextSpan(
                        text: 'JPS',
                        style: TextStyle(
                          color: Color(0xFF79AB43),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 35.0 : 50.0),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _testimonials.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 2 : 5,
                    crossAxisSpacing: isMobile ? 8.0 : 32.0,
                    mainAxisSpacing: isMobile ? 16.0 : 40.0,
                    childAspectRatio: isMobile ? 0.7 : 0.7,
                  ),
                  itemBuilder: (context, idx) {
                    final item = _testimonials[idx];
                    return _buildTestimonialItem(item, constraints, isMobile);
                  },
                ),

                const SizedBox(height: 20.0),

                // Tombol “Tampilkan semua”
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TestimonyMain(),
                        ),
                      );
                    },
                    child: Text(
                      'Tampilkan semua',
                      style: TextStyle(
                        fontFamily: 'Satoshi-Regular',
                        fontSize: isMobile ? 12.0 : 16.0,
                        color: const Color(0xFF79AB43),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Widget untuk menampilkan baris 5 bintang
  Widget _buildStarRating(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
            (index) => Icon(
          Icons.star,
          color: Colors.amber,
          size: isMobile ? 16.0 : 20.0,
        ),
      ),
    );
  }

  /// Membangun setiap item testimoni: lingkaran + asset image + nama + quote + bintang
  Widget _buildTestimonialItem(
      Map<String, String> testimonial, BoxConstraints constraints, bool isMobile) {
    // Menghitung lebar item responsif
    final double itemWidth = isMobile
        ? (constraints.maxWidth / 2) - 28
        : constraints.maxWidth > 1200
        ? 200
        : constraints.maxWidth > 1024
        ? 170
        : 150;

    final double imageSize = isMobile ? 120 : 150;

    return SizedBox(
      width: itemWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Lingkaran dengan border custom
              Container(
                width: imageSize + 10,
                height: imageSize + 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: CustomPaint(
                  painter: CircularBorderPainter(
                    strokeWidthBase: 1.5,
                    strokeWidthAccent: 6.0,
                    baseColor: const Color(0xFFB9E2A1),
                    accentColor: const Color(0xFF79AB43),
                    accentLengthAngle: pi * 0.8,
                  ),
                ),
              ),

              // Gambar testimoni (asset lokal)
              Positioned(
                bottom: 6,
                child: ClipOval(
                  child: Image.asset(
                    testimonial['image']!,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF79AB43).withOpacity(0.1),
                        width: imageSize,
                        height: imageSize,
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 48),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: isMobile ? 8.0 : 16.0),

          // Nama dan kutipan testimoni
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'Satoshi-Regular',
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: '${testimonial['name']!}\n',
                  style: TextStyle(
                    fontSize: isMobile ? 12.0 : 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: testimonial['quote']!,
                  style: TextStyle(
                    fontSize: isMobile ? 10.0 : 16.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: isMobile ? 8.0 : 12.0),

          // Baris 5 bintang
          _buildStarRating(isMobile),
        ],
      ),
    );
  }
}

/// Painter untuk lingkaran dengan arc accent di bagian bawah
class CircularBorderPainter extends CustomPainter {
  final double strokeWidthBase;
  final double strokeWidthAccent;
  final Color baseColor;
  final Color accentColor;
  final double accentLengthAngle;

  CircularBorderPainter({
    required this.strokeWidthBase,
    required this.strokeWidthAccent,
    required this.baseColor,
    required this.accentColor,
    required this.accentLengthAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    // Lingkaran dasar (warna base)
    final Paint basePaint = Paint()
      ..color = baseColor
      ..strokeWidth = strokeWidthBase
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius - strokeWidthBase / 2, basePaint);

    // Arc accent di bagian bawah lingkaran
    final Paint accentPaint = Paint()
      ..color = accentColor
      ..strokeWidth = strokeWidthAccent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Mulai di sudut (π/2 - setengah panjang arc) supaya arc-nya di bawah
    final double startAngle = pi / 2 - (accentLengthAngle / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidthAccent / 2),
      startAngle,
      accentLengthAngle,
      false,
      accentPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


// import 'package:eassist_tools_app/blocs/gallery/gallerytestimonycari_bloc.dart';
// import 'package:eassist_tools_app/common/constants.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' show pi;
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../pages/testimony_page/testimony_main.dart';
//
// class TestimonialSection extends StatefulWidget {
//   final BoxConstraints constraints;
//
//   const TestimonialSection({super.key, required this.constraints});
//
//   @override
//   State<TestimonialSection> createState() => TestimonialSectionState();
// }
//
// class TestimonialSectionState extends State<TestimonialSection> {
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<GallerytestimonyCariBloc>().add(RefreshGallerytestimonyCariEvent());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isMobile = widget.constraints.maxWidth < 768;
//     final double maxWidth = widget.constraints.maxWidth > 1200 ? 1200 : widget.constraints.maxWidth * 0.9;
//
//     return Container(
//       width: double.infinity,
//       color: Colors.white,
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: widget.constraints.maxWidth > 1200 ? 40.0 : 40.0,
//         ),
//         child: Center(
//           child: Container(
//             width: maxWidth,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: isMobile ? 25 : 70),
//                 // Judul responsif
//                 RichText(
//                   textAlign: TextAlign.center,
//                   text: TextSpan(
//                     style: TextStyle(
//                       fontFamily: 'Satoshi-Regular',
//                       fontSize: isMobile ? 18.0 : 25.0, // Judul: 15 mobile
//                       color: Colors.black,
//                     ),
//                     children: [
//                       const TextSpan(text: 'Testimoni Nasabah '),
//                       const TextSpan(
//                         text: 'JPS',
//                         style: TextStyle(
//                           color: Color(0xFF79AB43),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: isMobile ? 35.0 : 50.0),
//                 BlocBuilder<GallerytestimonyCariBloc, GallerytestimonyCariState>(
//                     builder: (context, state) {
//                       if (state.status == ListStatus.initial) {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       } else if (state.status == ListStatus.failure) {
//                         return const Center(
//                           child: Text('Failed to load images'),
//                         );
//                       } else if (state.items.isEmpty) {
//                         return const Center(
//                           child: Text('No images available'),
//                         );
//                       }
//
//                       final crossAxisCount = isMobile ? 2 : 5;
//                       final childAspectRatio = isMobile ? 0.7 : 0.7;
//
//                       return GridView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: state.items.take(5).length,
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: crossAxisCount,
//                           crossAxisSpacing: isMobile ? 8.0 : 32.0,
//                           mainAxisSpacing: isMobile ? 16.0 : 40.0,
//                           childAspectRatio: childAspectRatio,
//                         ),
//                         itemBuilder: (context, idx) =>
//                             _buildTestimonialItem(state.items[idx].toMap(), widget.constraints, isMobile),
//                       );
//                     }
//                 ),
//                 const SizedBox(height: 20.0),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const TestimonyMain()),
//                       );
//                     },
//                     child: Text(
//                       'Tampilkan semua',
//                       style: TextStyle(
//                         fontFamily: 'Satoshi-Regular',
//                         fontSize: isMobile ? 12.0 : 16.0, // Responsive!
//                         color: const Color(0xFF79AB43),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget untuk menampilkan bintang rating
//   Widget _buildStarRating(bool isMobile) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(5, (index) => Icon(
//         Icons.star,
//         color: Colors.amber,
//         size: isMobile ? 16.0 : 20.0,
//       )),
//     );
//   }
//
//   // Tambahkan isMobile ke parameter
//   Widget _buildTestimonialItem(Map<String, String> testimonial, BoxConstraints constraints, bool isMobile) {
//     // Atur width responsif: 2 kolom mobile, default desktop
//     final double itemWidth = isMobile
//         ? (constraints.maxWidth / 2) - 28 // 2 kolom, padding kanan-kiri
//         : constraints.maxWidth > 1200
//         ? 200
//         : constraints.maxWidth > 1024
//         ? 170
//         : 150;
//
//     final double imageSize = isMobile ? 120 : 150;
//
//     return SizedBox(
//       width: itemWidth,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               Container(
//                 width: imageSize + 10,
//                 height: imageSize + 10,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                 ),
//                 child: CustomPaint(
//                   painter: CircularBorderPainter(
//                     strokeWidthBase: 1.5,
//                     strokeWidthAccent: 6.0,
//                     baseColor: const Color(0xFFB9E2A1),
//                     accentColor: const Color(0xFF79AB43),
//                     accentLengthAngle: pi * 0.8,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 6,
//                 child: ClipOval(
//                   child: Image.network(
//                     testimonial['image']!,
//                     width: imageSize,
//                     height: imageSize,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: isMobile ? 8.0 : 16.0),
//           // RichText untuk nama (bold) dan quote (normal)
//           RichText(
//             textAlign: TextAlign.center,
//             text: TextSpan(
//               style: const TextStyle(
//                 fontFamily: 'Satoshi-Regular',
//                 height: 1.4,
//               ),
//               children: [
//                 TextSpan(
//                   text: testimonial['name']! + '\n',
//                   style: TextStyle(
//                     fontSize: isMobile ? 12.0 : 18.0, // Nama: 12 mobile, 18 desktop
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 TextSpan(
//                   text: testimonial['quote']!,
//                   style: TextStyle(
//                     fontSize: isMobile ? 10.0 : 16.0, // Deskripsi: 10 mobile, 16 desktop
//                     color: Colors.black54,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: isMobile ? 8.0 : 12.0),
//           // Tambahkan 5 bintang di sini
//           _buildStarRating(isMobile),
//         ],
//       ),
//     );
//   }
// }
//
// class CircularBorderPainter extends CustomPainter {
//   final double strokeWidthBase;
//   final double strokeWidthAccent;
//   final Color baseColor;
//   final Color accentColor;
//   final double accentLengthAngle;
//
//   CircularBorderPainter({
//     required this.strokeWidthBase,
//     required this.strokeWidthAccent,
//     required this.baseColor,
//     required this.accentColor,
//     required this.accentLengthAngle,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Offset center = Offset(size.width / 2, size.height / 2);
//     final double radius = size.width / 2;
//
//     // Lingkaran dasar (hijau muda)
//     final Paint basePaint = Paint()
//       ..color = baseColor
//       ..strokeWidth = strokeWidthBase
//       ..style = PaintingStyle.stroke;
//     canvas.drawCircle(center, radius - strokeWidthBase / 2, basePaint);
//
//     // Arc bawah (hijau tebal)
//     final Paint accentPaint = Paint()
//       ..color = accentColor
//       ..strokeWidth = strokeWidthAccent
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;
//
//     // ⬇️ START dari 90° - separuh panjang arc
//     final double startAngle = pi / 2 - (accentLengthAngle / 2);
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius - strokeWidthAccent / 2),
//       startAngle,
//       accentLengthAngle,
//       false,
//       accentPaint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }