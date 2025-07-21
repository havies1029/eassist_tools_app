import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';

class DownloadPopup extends StatefulWidget {
  final String? fileName;
  final String? fileSize;
  final String? documentType;
  final void Function(String format)? onExportSelected;

  const DownloadPopup({
    Key? key,
    this.fileName,
    this.fileSize,
    this.documentType,
    this.onExportSelected, // ✅
  }) : super(key: key);

  @override
  State<DownloadPopup> createState() => _DownloadPopupState();
}

class _DownloadPopupState extends State<DownloadPopup>
    with TickerProviderStateMixin {
  int _selectedFormat = 0; // 0: Excel, 1: PDF, 2: Word
  bool _isHoveringDownload = false;
  bool _isHoveringCancel = false;
  bool _isDownloading = false;
  double _downloadProgress = 0.0;

  late AnimationController _animationController;
  late AnimationController _overlayController;
  late AnimationController _progressController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _overlayAnimation;
  late Animation<double> _progressAnimation;

  final List<Map<String, dynamic>> _formats = [
    {
      'name': 'Excel',
      'extension': '.xlsx',
      'icon': Icons.table_chart,
      'color': Colors.green,
      'bgColor': Colors.green.shade50,
    },
    {
      'name': 'PDF',
      'extension': '.pdf',
      'icon': Icons.picture_as_pdf,
      'color': Colors.red,
      'bgColor': Colors.red.shade50,
    },
    //
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _overlayController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _overlayAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _overlayController, curve: Curves.easeInOut),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _overlayController.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _overlayController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  Future<void> _closePopup() async {
    if (_isDownloading) return;

    await _animationController.reverse();
    await _overlayController.reverse();

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _startDownload() async {
    // Ambil format yang dipilih
    final selectedFormatName = _formats[_selectedFormat]['name']?.toString().toLowerCase();

    // Jalankan callback jika tersedia
    if (widget.onExportSelected != null && selectedFormatName != null) {
      widget.onExportSelected!(selectedFormatName); // Kirim 'excel', 'pdf', atau 'word'
    }
    // Langsung tutup popup
    _closePopup();
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 500 ? screenWidth * 0.9 : 450.0;
    return AnimatedBuilder(
      animation: _overlayAnimation,
      builder: (context, child) {
        return Material(
          color: Colors.black.withOpacity(0.5 * _overlayAnimation.value),
          child: Center(
            child: GestureDetector(
              onTap: () {}, // Mencegah klik dalam popup menutup dialog
              child: _buildPopupAnimatedContent(dialogWidth),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPopupAnimatedContent(double dialogWidth) {
    return AnimatedBuilder(
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
                  _buildHeader(),
                  _buildFormatSelector(),
                  if (_isDownloading) _buildProgressIndicator(),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.download,
              color: Colors.blue.shade500,
              size: 35,
            ),
          ),
          const Text(
            'Pilih Format File untuk Diunduh',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            widget.fileName ?? 'Dokumen_Data',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          if (widget.fileSize != null) ...[
            const SizedBox(height: 4),
            Text(
              'Ukuran: ${widget.fileSize}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFormatSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_formats.length, (index) {
          final format = _formats[index];
          final isSelected = _selectedFormat == index;

          return Expanded(
            child: GestureDetector(
              onTap: _isDownloading ? null : () {
                setState(() => _selectedFormat = index);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: isSelected ? format['color'].withOpacity(0.1) : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? format['color'] : Colors.grey.shade200,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: format['bgColor'],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        format['icon'],
                        color: format['color'],
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      format['name'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? format['color'] : Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      format['extension'],
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mengunduh...',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                '${(_downloadProgress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _downloadProgress,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade500),
            minHeight: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        children: [
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHoveringCancel = true),
              onExit: (_) => setState(() => _isHoveringCancel = false),
              child: _buildCancelButton(),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHoveringDownload = true),
              onExit: (_) => setState(() => _isHoveringDownload = false),
              child: _buildDownloadButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 50,
      decoration: BoxDecoration(
        color: _isHoveringCancel ? Colors.grey.shade200 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isHoveringCancel ? Colors.grey.shade300 : Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: _isHoveringCancel
            ? [BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 4),
        )]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _isDownloading ? null : _closePopup,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.close,
                color: _isDownloading ? Colors.grey.shade400 : Colors.grey.shade600,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Batal',
                style: TextStyle(
                  color: _isDownloading ? Colors.grey.shade400 : Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadButton() {
    final selectedFormat = _formats[_selectedFormat];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 50,
      decoration: BoxDecoration(
        color: _isHoveringDownload
            ? selectedFormat['color'].withOpacity(0.8)
            : selectedFormat['color'],
        borderRadius: BorderRadius.circular(12),
        boxShadow: _isHoveringDownload
            ? [BoxShadow(
          color: selectedFormat['color'].withOpacity(0.4),
          blurRadius: 15,
          offset: const Offset(0, 8),
        )]
            : [BoxShadow(
          color: selectedFormat['color'].withOpacity(0.2),
          blurRadius: 5,
          offset: const Offset(0, 3),
        )],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _startDownload, // Langsung jalankan
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                selectedFormat['icon'],
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Unduh ${selectedFormat['name']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example usage widget
class DownloadPopupDemo extends StatelessWidget {
  const DownloadPopupDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Popup Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: true, // ✅ INI KUNCINYA
              builder: (context) => const DownloadPopup(
                fileName: 'Data_Laporan_2024.xlsx',
                fileSize: '2.5 MB',
                documentType: 'Excel',
              ),
            );
          },
          child: const Text('Show Download Popup'),
        ),
      ),
    );
  }
}
