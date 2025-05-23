import 'package:flutter/material.dart';
import '../../pages/heropage/hero_main.dart';

class FloatingButtons extends StatelessWidget {
  final BoxConstraints constraints;
  const FloatingButtons({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;
  double get maxWidth => constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;
  double get sidePadding => constraints.maxWidth > 1200 ? 64.0 : 32.0;
  double get innerPadding => isMobile ? 16.0 : 40.0;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -70), // ⬅️ Geser sedikit ke atas (misal -10 px)
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sidePadding),
        child: Center(
          child: Container(
            width: maxWidth,
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: innerPadding, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  HoverButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Row(
                        children: const [
                          Icon(Icons.login, color: Color(0xFF79AB43)),
                          SizedBox(width: 8.0),
                          Text(
                            'Masuk',
                            style: TextStyle(
                              fontFamily: 'Satoshi-Regular',
                              color: Color(0xFF79AB43),
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  HoverButton(
                    onPressed: () {},
                    color: Color(0xFF79AB43),
                    textColor: Colors.white,
                    isRounded: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 4.0),
                      child: Row(
                        children: const [
                          Icon(Icons.person_add, color: Colors.white),
                          SizedBox(width: 8.0),
                          Text(
                            'Daftar Klien',
                            style: TextStyle(
                              fontFamily: 'Satoshi-Regular',
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import '../../pages/heropage/hero_main.dart';
//
// class FloatingButtons extends StatelessWidget {
//   final BoxConstraints constraints;
//   const FloatingButtons({super.key, required this.constraints});
//
//   bool get isMobile => constraints.maxWidth < 768;
//   double get maxWidth => constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth * 0.9;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: maxWidth,
//       height: 0,
//       child: OverflowBox(
//         maxHeight: double.infinity,
//         alignment: Alignment.topCenter,
//         child: Transform.translate(
//           offset: const Offset(0, -50),
//           child: Material(
//             elevation: 20,
//             borderRadius: BorderRadius.circular(24),
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 19.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(24.0),
//               ),
//               child: _buildActionButtons(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildActionButtons() {
//     return Container(
//       width: isMobile ? double.infinity : null,
//       padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30.0),
//       ),
//       child: Row(
//         mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
//         children: [
//           HoverButton(
//             onPressed: () {},
//             child: Row(
//               children: const [
//                 Icon(Icons.login, color: Color(0xFF79AB43)),
//                 SizedBox(width: 8.0),
//                 Text(
//                   'Masuk',
//                   style: TextStyle(
//                     fontFamily: 'Satoshi-Regular',
//                     color: Color(0xFF79AB43),
//                     fontWeight: FontWeight.w500,
//                     fontSize: 16.0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 16.0),
//           HoverButton(
//             onPressed: () {},
//             color: const Color(0xFF79AB43),
//             textColor: Colors.white,
//             isRounded: true,
//             child: Row(
//               children: const [
//                 Icon(Icons.person_add, color: Colors.white),
//                 SizedBox(width: 8.0),
//                 Text(
//                   'Daftar Klien',
//                   style: TextStyle(
//                     fontFamily: 'Satoshi-Regular',
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 16.0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
