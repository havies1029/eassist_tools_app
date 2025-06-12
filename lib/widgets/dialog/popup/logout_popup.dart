import 'package:flutter/material.dart';

class LogoutPopup extends StatefulWidget {
  /// Callback yang dipanggil ketika tombol "Iya, Keluar" ditekan.
  final VoidCallback onConfirm;

  /// Callback yang dipanggil ketika tombol "Batal" ditekan atau popup ditutup.
  final VoidCallback? onCancel;

  const LogoutPopup({
    Key? key,
    required this.onConfirm,
    this.onCancel,
  }) : super(key: key);

  @override
  _LogoutPopupState createState() => _LogoutPopupState();
}

class _LogoutPopupState extends State<LogoutPopup>
    with TickerProviderStateMixin {
  bool _isHoveringConfirm = false;
  bool _isHoveringCancel = false;
  late AnimationController _animationController;
  late AnimationController _overlayController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _overlayAnimation;

  @override
  void initState() {
    super.initState();

    // Controller untuk animasi popup
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Controller untuk animasi overlay
    _overlayController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // Animasi skala popup
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    // Animasi fade in untuk konten
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Animasi overlay background
    _overlayAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _overlayController,
        curve: Curves.easeInOut,
      ),
    );

    // Mulai animasi
    _overlayController.forward();
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _overlayController.dispose();
    super.dispose();
  }

  void _closePopup() {
    _animationController.reverse().then((_) {
      _overlayController.reverse().then((_) {
        if (mounted) {
          Navigator.of(context).pop();
          if (widget.onCancel != null) {
            widget.onCancel!();
          }
        }
      });
    });
  }

  void _confirmLogout() {
    _animationController.reverse().then((_) {
      _overlayController.reverse().then((_) {
        if (mounted) {
          Navigator.of(context).pop();
          widget.onConfirm();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 450 ? screenWidth * 0.9 : 380.0;

    return AnimatedBuilder(
      animation: _overlayAnimation,
      builder: (context, child) {
        return Material(
          color: Colors.black.withOpacity(0.5 * _overlayAnimation.value),
          child: GestureDetector(
            onTap: _closePopup,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: GestureDetector(
                  onTap: () {}, // Prevent closing when tapping on dialog
                  child: AnimatedBuilder(
                    animation: Listenable.merge([_scaleAnimation, _fadeInAnimation]),
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Opacity(
                          opacity: _fadeInAnimation.value,
                          child: Container(
                            width: dialogWidth,
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildContent(),
                                _buildButtons(),
                              ],
                            ),
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
      },
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 20),
      child: Column(
        children: [
          // Icon logout
          Container(
            width: 80,
            height: 80,
            margin: const EdgeInsets.only(bottom: 25),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.logout,
              color: Colors.red.shade400,
              size: 40,
            ),
          ),

          // Title
          const Text(
            'Keluar dari Akun',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 15),

          // Subtitle
          const Text(
            'Apakah Anda yakin ingin melanjutkan?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      child: Row(
        children: [
          // Tombol Batal
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHoveringCancel = true),
              onExit: (_) => setState(() => _isHoveringCancel = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 50,
                decoration: BoxDecoration(
                  color: _isHoveringCancel
                      ? Colors.grey.shade200
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isHoveringCancel
                        ? Colors.grey.shade300
                        : Colors.grey.shade200,
                    width: 1,
                  ),
                  boxShadow: _isHoveringCancel
                      ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                      : [],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _closePopup,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.close,
                            color: Colors.grey.shade600,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Batal',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 15),

          // Tombol Iya, Keluar
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHoveringConfirm = true),
              onExit: (_) => setState(() => _isHoveringConfirm = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 50,
                decoration: BoxDecoration(
                  color: _isHoveringConfirm
                      ? Colors.red.shade600
                      : Colors.red.shade500,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _isHoveringConfirm
                      ? [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ]
                      : [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: _confirmLogout,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Iya, Keluar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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

// Helper class untuk menampilkan popup
class LogoutPopupHelper {
  static void show(
      BuildContext context, {
        required VoidCallback onConfirm,
        VoidCallback? onCancel,
      }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return LogoutPopup(
          onConfirm: onConfirm,
          onCancel: onCancel,
        );
      },
    );
  }
}

// Contoh penggunaan:
/*
LogoutPopupHelper.show(
  context,
  onConfirm: () {
    // Handle logout logic
    print('User confirmed logout');
    // Implement your logout logic here
  },
  onCancel: () {
    // Handle cancel logic (optional)
    print('User cancelled logout');
  },
);
*/