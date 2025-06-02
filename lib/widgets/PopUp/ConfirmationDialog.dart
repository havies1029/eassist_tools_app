import 'package:flutter/material.dart';
import '../register/register_client/popup_client.dart'; // hanya jika butuh warna CustomPopupsClient.primaryGreen

class ConfirmationDialog extends StatefulWidget {
  /// Callback yang dijalankan jika pengguna menekan “Setuju & Lanjutkan”
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  _ConfirmationDialogState createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  bool _isHoveringConfirm = false;
  bool _isHoveringCancel = false;

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
    // Hitung lebar dialog: 90% layar jika < 450, atau 400.0 jika lebar >= 450
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 450 ? screenWidth * 0.9 : 400.0;

    return Dialog(
      backgroundColor: Colors.transparent,
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
                  _buildFooterButtons(),
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
      child: const Text(
        'Konfirmasi Persetujuan',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: const Text(
        'Dengan ini saya menyatakan bahwa seluruh data yang saya isi adalah benar, '
            'dan saya menyetujui untuk melanjutkan proses ini',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildFooterButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          // Tombol Batal
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHoveringCancel = true),
              onExit: (_) => setState(() => _isHoveringCancel = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 45,
                decoration: BoxDecoration(
                  color:
                  _isHoveringCancel ? Colors.grey.shade300 : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => Navigator.of(context).pop(),
                    child: const Center(
                      child: Text(
                        'Batal',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Tombol Setuju & Lanjutkan
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHoveringConfirm = true),
              onExit: (_) => setState(() => _isHoveringConfirm = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 45,
                decoration: BoxDecoration(
                  color: _isHoveringConfirm
                      ? const Color(0xFF6B9639)
                      : CustomPopupsClient.primaryGreen,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: _isHoveringConfirm
                      ? [
                    BoxShadow(
                      color:
                      CustomPopupsClient.primaryGreen.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ]
                      : [
                    BoxShadow(
                      color:
                      CustomPopupsClient.primaryGreen.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Navigator.of(context).pop();
                      widget.onConfirm();
                    },
                    child: const Center(
                      child: Text(
                        'Setuju & Lanjutkan',
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
          ),
        ],
      ),
    );
  }
}
