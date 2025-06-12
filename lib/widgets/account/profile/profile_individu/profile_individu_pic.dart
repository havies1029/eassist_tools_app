import 'package:flutter/material.dart';

class ProfileIndividuPicSection extends StatelessWidget {
  final TextEditingController namaUserController;
  final bool isEditing;
  final VoidCallback onToggleEdit;
  final VoidCallback onUploadPhoto;

  const ProfileIndividuPicSection({
    super.key,
    required this.namaUserController,
    required this.isEditing,
    required this.onToggleEdit,
    required this.onUploadPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
            image: const DecorationImage(
              image: AssetImage('assets/profile_placeholder.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNameEditor(),
              const SizedBox(height: 5),
              _buildUploadButton(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUploadButton() {
    return InkWell(
      onTap: onUploadPhoto,
      borderRadius: BorderRadius.circular(110),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        width: 130,
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xDFFFC6).withOpacity(1),
          borderRadius: BorderRadius.circular(110),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Upload Photo',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontFamily: 'Satoshi',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildNameEditor() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: isEditing
              ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF8BC34A), width: 1.5),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8BC34A).withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: namaUserController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
                fontFamily: 'Satoshi',
              ),
            ),
          )
              : Text(
            namaUserController.text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Satoshi',
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        const SizedBox(width: 12),
        _buildEditButton(),
      ],
    );
  }

  Widget _buildEditButton() {
    return InkWell(
      onTap: onToggleEdit,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Icon(
          isEditing ? Icons.check : Icons.edit,
          size: 25,
          color: isEditing ? const Color(0xFF8BC34A) : Colors.grey[600],
        ),
      ),
    );
  }
}