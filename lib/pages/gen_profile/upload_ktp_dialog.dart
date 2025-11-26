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
    return AlertDialog(
      title: const Text("Upload Foto KTP"),
      content: BlocBuilder<ProfileUploadKtpBloc, ProfileUploadKtpState>(
        builder: (context, state) {
          Uint8List? imageBytes;
          if (state is UploadKtpPreview) imageBytes = state.imageBytes;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imageBytes != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Image.memory(imageBytes, height: 150),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _pickFromGallery(context),
                    icon: const Icon(Icons.photo),
                    label: const Text("Galeri"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _pickFromCamera(context),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Kamera"),
                  ),
                ],
              ),
              if (state is UploadKtpLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Batal"),
        ),
        BlocBuilder<ProfileUploadKtpBloc, ProfileUploadKtpState>(
          builder: (context, state) {
            final isEnabled = state is UploadKtpPreview;
            return ElevatedButton(
              onPressed: isEnabled
                  ? () {
                      context
                          .read<ProfileUploadKtpBloc>()
                          .add(UploadKtpSubmitted());
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text("Upload"),
            );
          },
        ),
      ],
    );
  }
}
