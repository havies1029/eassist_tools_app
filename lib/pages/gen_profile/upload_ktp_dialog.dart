import 'dart:typed_data';
import 'package:eassist_tools_app/blocs/profile/profile_upload_ktp_bloc.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class UploadKtpDialog extends StatelessWidget {
  const UploadKtpDialog({super.key});

  Future<void> _pickFromGallery(BuildContext context) async {
    if (kIsWeb) {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.bytes != null) {
        if (!context.mounted) return;
        context.read<ProfileUploadKtpBloc>().add(
          UploadKtpSelected(result.files.single.bytes!, result.files.single.name),
        );
      }
    } else {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) {
        final bytes = await picked.readAsBytes();
        if (!context.mounted) return;
        context
            .read<ProfileUploadKtpBloc>()
            .add(UploadKtpSelected(bytes, picked.name));
      }
    }
  }

  Future<void> _pickFromCamera(BuildContext context) async {
    if (kIsWeb) {
      // Kamera tidak tersedia di web
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Kamera tidak tersedia di web")),
      );
      return;
    }
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      final bytes = await picked.readAsBytes();

      if (!context.mounted) return;
      context
          .read<ProfileUploadKtpBloc>()
          .add(UploadKtpSelected(bytes, picked.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileUploadKtpBloc, ProfileUploadKtpState>(
      listener: (context, state) {
        if (state is UploadKtpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("KTP berhasil diupload!")),
          );
          Navigator.pop(context);
        } else if (state is UploadKtpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Gagal mengupload KTP.")),
          );
        }
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: const Offset(0, 8),
                blurRadius: 32,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.credit_card_outlined,
                        color: Color(0xFF6366F1),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upload KTP',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                              height: 1.2,
                            ),
                          ),
                          Text(
                            'Pilih foto KTP dari galeri atau kamera',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // KONTEN BLOCBUILDER
                BlocBuilder<ProfileUploadKtpBloc, ProfileUploadKtpState>(
                  builder: (context, state) {
                    Uint8List? imageBytes;
                    if (state is UploadKtpPreview) imageBytes = state.imageBytes;

                    return Column(
                      children: [
                        if (imageBytes != null)
                          Container(
                            width: double.infinity,
                            height: 200,
                            margin: const EdgeInsets.only(bottom: 24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFE5E7EB)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.memory(imageBytes, fit: BoxFit.cover),
                            ),
                          ),
                        if (imageBytes == null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(32),
                            margin: const EdgeInsets.only(bottom: 24),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: const Color(0xFFE5E7EB)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6366F1).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  child: const Icon(
                                    Icons.image_outlined,
                                    color: Color(0xFF6366F1),
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Belum ada foto dipilih',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF374151),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Pilih foto KTP dari galeri atau ambil foto baru',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF6B7280),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                        // Tombol galeri dan kamera
                        Row(
                          children: [
                            Expanded(
                              child: _buildOptionButton(
                                onTap: () => _pickFromGallery(context),
                                icon: Icons.photo_library_outlined,
                                label: 'Galeri',
                                isSecondary: true,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildOptionButton(
                                onTap: () => _pickFromCamera(context),
                                icon: Icons.camera_alt_outlined,
                                label: 'Kamera',
                                isSecondary: false,
                              ),
                            ),
                          ],
                        ),

                        if (state is UploadKtpLoading)
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 24),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6366F1).withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF6366F1).withOpacity(0.1),
                              ),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFF6366F1),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Text(
                                  'Sedang mengupload foto...',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF6366F1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 32),

                // FOOTER
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        onPressed: () => Navigator.pop(context),
                        label: 'Batal',
                        isSecondary: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: BlocBuilder<ProfileUploadKtpBloc, ProfileUploadKtpState>(
                        builder: (context, state) {
                          final isEnabled = state is UploadKtpPreview;
                          return _buildActionButton(
                            onPressed: isEnabled
                                ? () {
                              context
                                  .read<ProfileUploadKtpBloc>()
                                  .add(UploadKtpSubmitted());
                            }
                                : null,
                            label: 'Upload KTP',
                            isSecondary: false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required VoidCallback onTap,
    required IconData icon,
    required String label,
    required bool isSecondary,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: isSecondary ? Colors.white : const Color(0xFF6366F1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSecondary ? const Color(0xFFE5E7EB) : const Color(0xFF6366F1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: isSecondary ? const Color(0xFF6B7280) : Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSecondary ? const Color(0xFF374151) : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback? onPressed,
    required String label,
    required bool isSecondary,
  }) {
    final isDisabled = onPressed == null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: isSecondary
                ? Colors.white
                : isDisabled
                ? const Color(0xFFF3F4F6)
                : const Color(0xFF6366F1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSecondary
                  ? const Color(0xFFE5E7EB)
                  : isDisabled
                  ? const Color(0xFFE5E7EB)
                  : const Color(0xFF6366F1),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSecondary
                    ? const Color(0xFF374151)
                    : isDisabled
                    ? const Color(0xFF9CA3AF)
                    : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}