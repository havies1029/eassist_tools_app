import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/authentication/authentication_bloc.dart';
import '../../../../blocs/profile/profile_download_foto_bloc.dart';
import 'profile_menu_item.dart';

class ProfileDropdownContent extends StatelessWidget {
  final VoidCallback onClose;
  final void Function(String menu) onMenuTap;

  const ProfileDropdownContent({
    Key? key,
    required this.onClose,
    required this.onMenuTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header gradien
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF79AB43), Color(0xFF8BBD54)],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
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
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(17.5),
                            child: imageBytes != null
                                ? Image.memory(
                              imageBytes,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => _defaultIcon(),
                            )
                                : Image.asset(
                              'assets/images/profile_placeholder.jpg',
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, s) => _defaultIcon(),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Color(0xFF4CAF50),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1.5),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Builder(
                        builder: (context) {
                          final state = context.read<AuthenticationBloc>().state;
                          String name = "[Nama User]";
                          if (state is AuthenticationAuthenticated &&
                              state.user.custType == "C") {
                            name = state.user.nama ?? "[Nama User]";
                          }

                          return Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Satoshi-Regular',
                            ),
                          );
                        },
                      ),
                      Text(
                        'Online',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                          fontFamily: 'Satoshi-Regular',
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white, size: 20),
                  onPressed: onClose,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
              ],
            ),
          ),

          // Daftar menu
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                ProfileMenuItem(
                  icon: Icons.person_outline,
                  title: 'Profil',
                  onTap: () => onMenuTap('Profil'),
                ),
                ProfileMenuItem(
                  icon: Icons.lock_reset,
                  title: 'Reset Password',
                  onTap: () => onMenuTap('Reset Password'),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFE5E5E5),
                  indent: 16,
                  endIndent: 16,
                ),
                ProfileMenuItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () => onMenuTap('Logout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _defaultIcon() => Container(
    color: Colors.white.withOpacity(0.3),
    child: const Icon(Icons.person, color: Colors.white, size: 20),
  );
}
