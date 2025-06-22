import 'package:flutter/foundation.dart'; // untuk kIsWeb
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ProfilePicture extends StatefulWidget {
  final String imageUrl;
  final double radius;
  final Future<void> Function(Uint8List bytes, String fileName)? onImageSelected;
  final Uint8List? blocImageBytes;

  const ProfilePicture({
    super.key,
    required this.imageUrl,
    this.radius = 50, this.onImageSelected,
    this.blocImageBytes
  });

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? _imageFile;
  Uint8List? _webImageBytes;

  void _showImageSourceSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            if (!kIsWeb) // Hanya untuk mobile
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Ambil dari Kamera'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImageMobile(ImageSource.camera);
                },
              ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Ambil dari Galeri'),
              onTap: () async {
                Navigator.pop(context);
                if (kIsWeb) {
                  await _pickImageWeb();
                } else {
                  await _pickImageMobile(ImageSource.gallery);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageWeb() async {
  final result = await FilePicker.platform.pickFiles(type: FileType.image);
  if (result != null && result.files.single.bytes != null) {
    final bytes = result.files.single.bytes!;
    final fileName = result.files.single.name;

    setState(() {
      _webImageBytes = bytes;
      _imageFile = null;
    });

    if (widget.onImageSelected != null) {
      await widget.onImageSelected!(bytes, fileName);
    }
  }
}

Future<void> _pickImageMobile(ImageSource source) async {
  final picker = ImagePicker();
  final picked = await picker.pickImage(source: source);
  if (picked != null) {
    final bytes = await picked.readAsBytes();

    setState(() {
      _imageFile = File(picked.path);
      _webImageBytes = null;
    });

    if (widget.onImageSelected != null) {
      await widget.onImageSelected!(bytes, picked.name);
    }
  }
}


  @override
  Widget build(BuildContext context) {
    ImageProvider backgroundImage;
    if (_webImageBytes != null) {
      backgroundImage = MemoryImage(_webImageBytes!);
    } else if (_imageFile != null) {
      backgroundImage = FileImage(_imageFile!);
    } else if (widget.blocImageBytes != null) { 
      backgroundImage = MemoryImage(widget.blocImageBytes!);
    } else {
      backgroundImage = NetworkImage(widget.imageUrl);
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: widget.radius,
          backgroundImage: backgroundImage,
          backgroundColor: Colors.grey.shade200,
        ),
        Positioned(
          bottom: 0,
          right: 4,
          child: GestureDetector(
            onTap: _showImageSourceSelector,
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
              ),
              child: Icon(
                Icons.camera_alt,
                size: 20,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
