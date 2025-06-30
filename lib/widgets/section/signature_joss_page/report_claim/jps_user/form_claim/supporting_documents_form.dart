import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../form_step_container.dart';

class SupportingDocumentsForm extends StatelessWidget {
  const SupportingDocumentsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: FormStepContainer(
        children: [
          const _SectionTitle(
            icon: Icons.attachment_outlined,
            title: 'Unggah Dokumen Pendukung',
          ),
          const SizedBox(height: 24),
          _buildDocumentFields(),
        ],
      ),
    );
  }

  Widget _buildDocumentFields() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile = screenWidth <= 600;
        final isTablet = screenWidth > 600 && screenWidth <= 900;

        // Calculate responsive spacing and padding
        final horizontalPadding = isMobile ? 12.0 : (isTablet ? 20.0 : 24.0);
        final fieldSpacing = isMobile ? 12.0 : (isTablet ? 16.0 : 20.0);

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              // Upload Fields
              _UploadField(label: 'KTP (Wajib)'),
              SizedBox(height: fieldSpacing),

              _UploadField(label: 'Dokumen Polis (Opsional)'),
              SizedBox(height: fieldSpacing),

              _UploadField(label: 'Bukti Kejadian atau Kerugian (Opsional)'),
              SizedBox(height: fieldSpacing),

              // Catatan Tambahan
              _InputField(
                label: 'Catatan Tambahan (Opsional)',
                maxLines: 3,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _UploadField extends StatefulWidget {
  final String label;

  const _UploadField({required this.label});

  @override
  State<_UploadField> createState() => _UploadFieldState();
}

class _UploadFieldState extends State<_UploadField> {
  bool _isHovered = false;
  bool _isButtonHovered = false;
  List<PlatformFile> _selectedFiles = [];

  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
        allowMultiple: true,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFiles.addAll(result.files);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error memilih file: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  void _viewFile(PlatformFile file) {
    showDialog(
      context: context,
      builder: (context) => _FilePreviewDialog(file: file),
    );
  }

  IconData _getFileIconData(PlatformFile file) {
    final extension = file.extension?.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'doc':
      case 'docx':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;
    final isTablet = screenWidth > 600 && screenWidth <= 900;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.all(isMobile ? 12 : 16),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.grey.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered
                ? Theme.of(context).primaryColor.withOpacity(0.3)
                : Colors.grey.shade300,
          ),
          boxShadow: _isHovered
              ? [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with responsive layout
            isMobile
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 14,
                      color: _isHovered
                          ? Theme.of(context).primaryColor.withOpacity(0.9)
                          : Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: _buildUploadButton(),
                ),
              ],
            )
                : Row(
              children: [
                Expanded(
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      fontSize: 14,
                      color: _isHovered
                          ? Theme.of(context).primaryColor.withOpacity(0.9)
                          : Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                _buildUploadButton(),
              ],
            ),

            // Files preview section
            if (_selectedFiles.isNotEmpty) ...[
              SizedBox(height: isMobile ? 12 : 16),
              ...List.generate(_selectedFiles.length, (index) {
                final file = _selectedFiles[index];
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: index < _selectedFiles.length - 1 ? 8 : 0),
                  child: _buildFilePreview(file, index, isMobile),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _isButtonHovered = true),
      onExit: (_) => setState(() => _isButtonHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: ElevatedButton.icon(
          onPressed: _pickFiles,
          icon: Icon(
            Icons.upload_file,
            size: isMobile ? 16 : 18,
            color: _isButtonHovered
                ? Colors.white
                : Colors.white.withOpacity(0.9),
          ),
          label: Text(
            "Pilih File",
            style: TextStyle(
              fontSize: isMobile ? 13 : 14,
              fontWeight: FontWeight.w500,
              color: _isButtonHovered
                  ? Colors.white
                  : Colors.white.withOpacity(0.9),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: _isButtonHovered
                ? Theme.of(context).primaryColor.withOpacity(0.9)
                : Theme.of(context).primaryColor,
            elevation: _isButtonHovered ? 4 : 2,
            shadowColor: Theme.of(context).primaryColor.withOpacity(0.3),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 20,
              vertical: isMobile ? 10 : 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: isMobile ? const Size.fromHeight(44) : null,
          ),
        ),
      ),
    );
  }

  Widget _buildFilePreview(PlatformFile file, int index, bool isMobile) {
    return InkWell(
      onTap: () => _viewFile(file),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isMobile ? 10 : 12),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(
              _getFileIconData(file),
              size: isMobile ? 20 : 24,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(width: isMobile ? 8 : 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    file.name,
                    style: TextStyle(
                      fontSize: isMobile ? 12 : 13,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: isMobile ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatFileSize(file.size),
                    style: TextStyle(
                      fontSize: isMobile ? 10 : 11,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Remove button
            InkWell(
              onTap: () => _removeFile(index),
              borderRadius: BorderRadius.circular(4),
              child: Container(
                padding: EdgeInsets.all(isMobile ? 4 : 6),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.close,
                  size: isMobile ? 14 : 16,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dialog untuk preview file
class _FilePreviewDialog extends StatelessWidget {
  final PlatformFile file;

  const _FilePreviewDialog({required this.file});

  bool get _isImage {
    final extension = file.extension?.toLowerCase();
    return ['jpg', 'jpeg', 'png'].contains(extension);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width <= 600;
    final dialogWidth = isMobile ? screenSize.width * 0.95 : screenSize.width * 0.8;
    final dialogHeight = isMobile ? screenSize.height * 0.85 : screenSize.height * 0.8;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(isMobile ? 8 : 16),
      child: Container(
        width: dialogWidth,
        height: dialogHeight,
        constraints: BoxConstraints(
          maxWidth: isMobile ? double.infinity : 800,
          maxHeight: isMobile ? double.infinity : 600,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(isMobile ? 12 : 16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      file.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: isMobile ? 14 : 16,
                      ),
                      maxLines: isMobile ? 2 : 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      size: isMobile ? 20 : 24,
                    ),
                    padding: EdgeInsets.all(isMobile ? 4 : 8),
                    constraints: BoxConstraints(
                      minWidth: isMobile ? 32 : 40,
                      minHeight: isMobile ? 32 : 40,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 12 : 16),
                child: _isImage ? _buildImagePreview() : _buildFileInfo(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    if (kIsWeb) {
      if (file.bytes != null) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.memory(
            file.bytes!,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => _buildFileInfo(),
          ),
        );
      }
    } else {
      if (file.path != null) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(file.path!),
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => _buildFileInfo(),
          ),
        );
      }
    }

    return _buildFileInfo();
  }

  Widget _buildFileInfo() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getFileIconData(),
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              file.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _formatFileSize(file.size),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          if (!_isImage)
            Text(
              'Preview tidak tersedia untuk file ini',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  IconData _getFileIconData() {
    final extension = file.extension?.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'doc':
      case 'docx':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

class _InputField extends StatefulWidget {
  final String label;
  final int maxLines;

  const _InputField({
    required this.label,
    this.maxLines = 1,
  });

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isHovered || _isFocused
              ? [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ]
              : null,
        ),
        child: Focus(
          onFocusChange: (focused) => setState(() => _isFocused = focused),
          child: TextField(
            maxLines: widget.maxLines,
            style: TextStyle(fontSize: isMobile ? 13 : 14),
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: TextStyle(
                fontSize: isMobile ? 13 : 14,
                color: _isFocused
                    ? Theme.of(context).primaryColor
                    : Colors.grey[600],
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: _isFocused
                  ? Theme.of(context).primaryColor.withOpacity(0.05)
                  : _isHovered
                  ? Colors.grey.shade50
                  : Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 16,
                vertical: widget.maxLines > 1 ? (isMobile ? 12 : 16) : (isMobile ? 12 : 14),
              ),
              alignLabelWithHint: widget.maxLines > 1,
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 600;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : (screenWidth <= 900 ? 20 : 24),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 20,
        vertical: isMobile ? 12 : 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: isMobile ? 18 : 20,
            color: Theme.of(context).primaryColor.withOpacity(0.8),
          ),
          SizedBox(width: isMobile ? 8 : 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: isMobile ? 14 : 16,
                color: Theme.of(context).primaryColor.withOpacity(0.9),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}