import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/authentication/authentication_bloc.dart';
import '../../../../blocs/local_prefs/auth_local_cubit.dart';
import '../../../../blocs/profile/profile_download_foto_bloc.dart';
import '../../../../blocs/gen_profile/mrekan1crud_bloc.dart';
import '../../../../common/app_data.dart';

class ProfileSection extends StatefulWidget {
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
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  void initState() {
    super.initState();
    // Pastikan request load jalan setelah frame pertama
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ensureRekanLoaded(context);
      _ensureFotoLoaded(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    final authState = context.select<AuthenticationBloc, AuthenticationState>((b) => b.state);
    final isMobile = MediaQuery.of(context).size.width < 768;
    final authLocal = context.read<AuthLocalCubit>().state;
    final lastEmail = authLocal.lastLoginEmail?.trim();
    final rekanState = context.watch<MRekan1CrudBloc>().state;
    final fotoState  = context.watch<ProfileDownloadFotoBloc>().state;
    final fotoLoaded  = fotoState is ProfileDownloadFotoLoaded;
    final Uint8List? imageBytes = fotoLoaded ? (fotoState as ProfileDownloadFotoLoaded).imageBytes : null;

    String displayName = "(memuat profil...)";

// Fallback prioritas pengambilan nama
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
      }

      if (displayName == "(memuat profil...)") {
        final googleName = authLocal.googleDisplayName?.trim();
        if (googleName != null && googleName.isNotEmpty) {
          displayName = googleName;
        } else if (lastEmail != null && lastEmail.isNotEmpty) {
          displayName = lastEmail;
        }
      }
    }
    //
    // debugPrint('📛 Display Name: $displayName');
    //
    //
    // debugPrint('📧 Last Login Email: $lastEmail');
    //
    // debugPrint('[PS] isLoaded=${rekanState.isLoaded} '
    //     'nama="${(rekanState.record?.rekanNama ?? '').trim()}" '
    //     'fotoLoaded=${fotoState is ProfileDownloadFotoLoaded}');

    return Container(
      key: widget.profileButtonKey,
      decoration: BoxDecoration(
        color: widget.isProfileMenuOpen
            ? const Color(0xFF79AB43).withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: widget.onToggleProfileMenu,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAvatar(imageBytes),
              const SizedBox(width: 12),
              if (!isMobile)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: Text(
                    displayName,
                    key: ValueKey(displayName),
                    style: const TextStyle(
                      color: Color(0xFF2D5016),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Satoshi-Regular',
                    ),
                  ),
                ),
              if (!isMobile) const SizedBox(width: 8),
              AnimatedRotation(
                turns: widget.isProfileMenuOpen ? 0.5 : 0,
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

  // --- Helpers ---

  void _ensureRekanLoaded(BuildContext context) {
    final auth = context.read<AuthenticationBloc>().state;
    if (auth is! AuthenticationAuthenticated) return; // hanya bila sudah login

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

  Widget _buildAvatar(Uint8List? imageBytes) {
    return Stack(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF79AB43), width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: imageBytes != null
                ? Image.memory(
              imageBytes,
              fit: BoxFit.cover,
              errorBuilder: (c, e, st) => _defaultIcon(),
            )
                : _defaultIcon(), // ← pakai default saat foto belum ready
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
