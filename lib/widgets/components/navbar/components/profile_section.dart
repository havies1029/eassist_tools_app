import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/authentication/authentication_bloc.dart';
import '../../../../blocs/profile/profile_download_foto_bloc.dart';

class ProfileSection extends StatelessWidget {
  final GlobalKey profileButtonKey;
  final bool isProfileMenuOpen;
  final VoidCallback onToggleProfileMenu;

  const ProfileSection({
    Key? key,
    required this.profileButtonKey,
    required this.isProfileMenuOpen,
    required this.onToggleProfileMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthenticationBloc>().state;

    // Cek apakah nama user tersedia
    String? name;
    if (authState is AuthenticationAuthenticated &&
        authState.user.custType == "C") {
      name = authState.user.nama;
    }

    // Jika nama kosong/null, jangan tampilkan apapun
    if (name == null || name.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      key: profileButtonKey,
      decoration: BoxDecoration(
        color: isProfileMenuOpen
            ? const Color(0xFF79AB43).withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onToggleProfileMenu,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Avatar + status
              BlocBuilder<ProfileDownloadFotoBloc, ProfileDownloadFotoState>(
                builder: (context, imageState) {
                  Uint8List? imageBytes;
                  if (imageState is ProfileDownloadFotoLoaded) {
                    imageBytes = imageState.imageBytes;
                  }

                  return Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF79AB43),
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: imageBytes != null
                              ? Image.memory(
                            imageBytes,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, st) => _defaultIcon(),
                          )
                              : Image.asset(
                            'assets/images/profile_placeholder.jpg',
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, st) => _defaultIcon(),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(width: 12),
              // Nama User
              Text(
                name!,
                style: const TextStyle(
                  color: Color(0xFF2D5016),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Satoshi-Regular',
                ),
              ),
              const SizedBox(width: 8),
              // Panah dropdown
              AnimatedRotation(
                turns: isProfileMenuOpen ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFF79AB43),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _defaultIcon() => Container(
    color: const Color(0xFF79AB43).withOpacity(0.2),
    child: const Icon(
      Icons.person,
      color: Color(0xFF79AB43),
      size: 24,
    ),
  );
}
