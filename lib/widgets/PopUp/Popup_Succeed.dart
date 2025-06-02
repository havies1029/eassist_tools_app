import 'package:flutter/material.dart';
import '../register/register_client/popup_client.dart';

class PopupSuceedPage extends StatefulWidget {
  /// Pesan yang ingin ditampilkan di bagian body popup
  final String message;

  /// Callback yang dipanggil ketika tombol OK ditekan.
  final VoidCallback onOk;

  const PopupSuceedPage({
    Key? key,
    required this.message,
    required this.onOk,
  }) : super(key: key);

  @override
  _PopupSuceedPageState createState() => _PopupSuceedPageState();
}

class _PopupSuceedPageState extends State<PopupSuceedPage>
    with TickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Hitung lebar dialog, misalnya 90% layar jika < 450, atau 400
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 450 ? screenWidth * 0.9 : 400.0;

    return Dialog(
      backgroundColor: Colors.transparent, // agar bentuk kotaknya custom
      insetPadding: const EdgeInsets.all(32),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: dialogWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  _buildBody(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: CustomPopupsClient.primaryGreen,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              'Berhasil!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Tampilkan pesan dinamis
          Text(
            widget.message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 30),
          // Tombol "OK" dengan callback onOk
          MouseRegion(
            onEnter: (_) => setState(() => _isHovering = true),
            onExit: (_) => setState(() => _isHovering = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: _isHovering
                    ? const Color(0xFF6B9639)
                    : CustomPopupsClient.primaryGreen,
                borderRadius: BorderRadius.circular(10),
                boxShadow: _isHovering
                    ? [
                  BoxShadow(
                    color: CustomPopupsClient.primaryGreen.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ]
                    : [
                  BoxShadow(
                    color: CustomPopupsClient.primaryGreen.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Navigator.of(context).pop(); // tutup dialog
                    widget.onOk(); // panggil callback
                  },
                  child: const Center(
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
