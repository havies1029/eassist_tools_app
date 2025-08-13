import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../blocs/authentication/authentication_bloc.dart';
import '../../../../blocs/local_prefs/auth_local_cubit.dart';
import '../../../../blocs/profile/profile_download_foto_bloc.dart';
import '../../../../blocs/gen_profile/mrekan1crud_bloc.dart';
import '../../dialog/popup/logout_popup.dart';

class TopNav extends StatefulWidget {
  const TopNav({super.key});

  @override
  State<TopNav> createState() => _TopNavState();
}

class _TopNavState extends State<TopNav> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ensureRekanLoaded(context);
      _ensureFotoLoaded(context);
    });
  }

  void _ensureRekanLoaded(BuildContext context) {
    final auth = context.read<AuthenticationBloc>().state;
    if (auth is! AuthenticationAuthenticated) return;

    final rekanState = context.read<MRekan1CrudBloc>().state;
    if (!rekanState.isLoaded) {
      context.read<MRekan1CrudBloc>().add(MRekan1CrudLihatEvent());
    }
  }

  void _ensureFotoLoaded(BuildContext context) {
    final fotoState = context.read<ProfileDownloadFotoBloc>().state;
    if (fotoState is! ProfileDownloadFotoLoaded &&
        fotoState is! ProfileDownloadFotoLoading) {
      context.read<ProfileDownloadFotoBloc>().add(LoadSecureImage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.select<AuthenticationBloc, AuthenticationState>((b) => b.state);
    final isMobile = MediaQuery.of(context).size.width < 768;
    final authLocal = context.read<AuthLocalCubit>().state;
    final lastEmail = authLocal.lastLoginEmail?.trim();
    final rekanState = context.watch<MRekan1CrudBloc>().state;
    final fotoState = context.watch<ProfileDownloadFotoBloc>().state;
    final fotoLoaded = fotoState is ProfileDownloadFotoLoaded;
    final isFotoLoading = fotoState is ProfileDownloadFotoLoading;
    final Uint8List? imageBytes = fotoLoaded ? (fotoState as ProfileDownloadFotoLoaded).imageBytes : null;

    String displayName = "(memuat profil...)";
    if (rekanState.isLoaded) {
      final rekanNama = rekanState.record?.rekanNama?.trim();
      if (rekanNama != null && rekanNama.isNotEmpty) {
        displayName = rekanNama;
      }
    }

    if (displayName == "(memuat profil...)" && authState is AuthenticationAuthenticated) {
      final namaUser = authState.user.nama?.trim();
      if (namaUser != null && namaUser.isNotEmpty) {
        displayName = namaUser;
      } else if ((authLocal.googleDisplayName ?? "").isNotEmpty) {
        displayName = authLocal.googleDisplayName!;
      } else if ((lastEmail ?? "").isNotEmpty) {
        displayName = lastEmail!;
      }
    }

    final isLoadingNama = !rekanState.isLoaded && authState is! AuthenticationAuthenticated;

    return Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [
      //       Color(0xFF8BC34A), // Light green
      //       Color(0xFF4CAF50), // Darker green
      //     ],
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //   ),
      // ),
      color: Colors.transparent,
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 8.0,
        bottom: 12.0,
      ),
      child: Column(
        children: [
          // Top row with logo and icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/ya(1).png',
                height: 32.0,
                fit: BoxFit.contain,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Settings diklik!'),
                          backgroundColor: Colors.orange,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: SvgPicture.asset(
                        'assets/icons/lsicon_setting-outline.svg',
                        height: 24,
                        width: 24,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logout diklik!'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: SvgPicture.asset(
                        'assets/icons/tabler_logout.svg',
                        height: 24,
                        width: 24,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    isFotoLoading
                        ? const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: imageBytes != null
                          ? Image.memory(
                        imageBytes,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        isLoadingNama ? "Memuat..." : "Hi, $displayName 👋",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                child: Stack(
                  children: [
                    const Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                      size: 28,
                    ),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(Uint8List? imageBytes) {
    return Stack(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: imageBytes != null
                ? Image.memory(
              imageBytes,
              fit: BoxFit.cover,
              errorBuilder: (c, e, st) => _defaultIcon(),
            )
                : _defaultIcon(),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
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
  }

  Widget _defaultIcon() => Container(
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      shape: BoxShape.circle,
    ),
    alignment: Alignment.center,
    child: const Icon(
      Icons.person,
      color: Colors.white,
      size: 20,
    ),
  );
}
