import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/authentication/authentication_bloc.dart';
import '../../../../blocs/gen_profile/mrekan1crud_bloc.dart';
import '../../../../blocs/local_prefs/auth_local_cubit.dart';
import '../../../../blocs/profile/profile_download_foto_bloc.dart';
import '../../../../common/app_data.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;

    double dropdownWidth;
    if (screenWidth < 360) {
      // 📱 Mobile sangat kecil (misal Galaxy Mini)
      dropdownWidth = screenWidth - 32;
    } else if (screenWidth < 480) {
      // 📱 Mobile normal
      dropdownWidth = screenWidth - 78;
    } else if (screenWidth < 768) {
      // 📱 Mobile besar / Tablet potrait
      dropdownWidth = 240;
    } else if (screenWidth < 1024) {
      // 📲 Tablet landscape
      dropdownWidth = 280;
    } else {
      // 💻 Desktop
      dropdownWidth = 300;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshRekanIfNeeded(context);
      _loadFotoIfNeeded(context);
    });
    return Container(
      width: dropdownWidth,
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

                // Nama Rekan dan status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<MRekan1CrudBloc, MRekan1CrudState>(
                        buildWhen: (prev, curr) =>
                        prev.record?.rekanNama != curr.record?.rekanNama,
                        builder: (context, rekanState) {
                          String displayName = "(belum diupdate di profile)";
                          final authState = context.read<AuthenticationBloc>().state;

                          if (authState is AuthenticationAuthenticated) {
                            // Coba dari user.nama terlebih dahulu
                            displayName = authState.user.nama?.trim() ?? "(belum diupdate di profile)";

                            final authLocal = context.read<AuthLocalCubit>().state;
                            final googleName = authLocal.googleDisplayName?.trim();
                            final lastEmail = authLocal.lastLoginEmail?.trim();

                            if (displayName.isEmpty || displayName == "(belum diupdate di profile)") {
                              if (googleName?.isNotEmpty == true) {
                                displayName = googleName!;
                              } else if (lastEmail?.isNotEmpty == true) {
                                displayName = lastEmail!;
                              }
                            }

                          }

                          // Jika rekanNama tersedia, override semuanya
                          final rekanNama = rekanState.record?.rekanNama?.trim();
                          if (rekanState.isLoaded && rekanNama != null && rekanNama.isNotEmpty) {
                            displayName = rekanNama;
                          }

                          return Text(
                            displayName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Satoshi-Regular',
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),

                // Tombol close
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
          // Daftar menu
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                bool isClientLogin = false;

                if (state is AuthenticationAuthenticated) {
                  final from = state.authenticatedFrom;
                  final custType = state.user.custType;
                  isClientLogin = (from == 'login_client' || from == 'login_token') && custType == 'C';
                }


                return Column(
                  children: [
                    if (isClientLogin)
                      ProfileMenuItem(
                        icon: Icons.person_outline,
                        title: 'Profil',
                        onTap: () => onMenuTap('Profil'),
                      ),
                    if (isClientLogin)
                      ProfileMenuItem(
                        icon: Icons.lock_reset,
                        title: 'Reset Password',
                        onTap: () => onMenuTap('Reset Password'),
                      ),
                    if (isClientLogin)
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
                );
              },
            ),
          ),

        ],
      ),
    );
  }

  void _loadFotoIfNeeded(BuildContext context) {
    final fotoState = context.read<ProfileDownloadFotoBloc>().state;

    if (fotoState is! ProfileDownloadFotoLoaded &&
        fotoState is! ProfileDownloadFotoLoading) {
      context.read<ProfileDownloadFotoBloc>().add(LoadSecureImage());
    }
  }

  void _refreshRekanIfNeeded(BuildContext context) {
    final rekanState = context.read<MRekan1CrudBloc>().state;
    final authState = context.read<AuthenticationBloc>().state;

    final isClient = authState is AuthenticationAuthenticated &&
        authState.user.custType == 'C';

    if (isClient && !rekanState.isLoaded) {
      context.read<MRekan1CrudBloc>().add(MRekan1CrudLihatEvent());
    }
  }

  Widget _defaultIcon() => Container(
    color: Colors.white.withOpacity(0.3),
    child: const Icon(Icons.person, color: Colors.white, size: 20),
  );
}

