import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/authentication/authentication_bloc.dart';
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

    // Pastikan refresh dipanggil sekali setelah build pertama selesai
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshRekanIfNeeded(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MRekan1CrudBloc, MRekan1CrudState>(
      buildWhen: (prev, curr) => prev.record?.rekanNama != curr.record?.rekanNama,
      builder: (context, state) {
        String displayName = "(belum diupdate di profile)";
        final authState = context.select<AuthenticationBloc, AuthenticationState>(
              (bloc) => bloc.state,
        );
        final isMobile = MediaQuery.of(context).size.width < 768;

        if (authState is AuthenticationAuthenticated) {
          displayName = authState.user.nama?.trim() ?? displayName;
          debugPrint('[DEBUG] Display name from authState: $displayName');
        }


        final rekanNama = state.record?.rekanNama?.trim();
        if (state.isLoaded && rekanNama != null && rekanNama.isNotEmpty) {
          displayName = rekanNama;
          debugPrint('[DEBUG] Display name from MRekan1CrudBloc: $displayName');
        } else if (AppData.googleDisplayName != null && AppData.googleDisplayName!.isNotEmpty) {
          displayName = AppData.googleDisplayName!;
          debugPrint('[DEBUG] Display name from Google Account: $displayName');
        } else if (AppData.lastLoginEmail != null && AppData.lastLoginEmail!.isNotEmpty) {
          displayName = AppData.lastLoginEmail!;
          debugPrint('[DEBUG] Display name from Last Login Email: $displayName');
        }
        // debugPrint('[DEBUG] FULL RECORD: ${state.record}');
        // debugPrint('[DEBUG] rekanNama value: $rekanNama');
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
                  if (!isMobile)
                    Text(
                      displayName,
                      style: const TextStyle(
                        color: Color(0xFF2D5016),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Satoshi-Regular',
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
      },
    );
  }

  // void _refreshRekanIfNeeded(BuildContext context) {
  //   final rekanState = context.read<MRekan1CrudBloc>().state;
  //   final authState = context.read<AuthenticationBloc>().state;
  //
  //   final isClient = authState is AuthenticationAuthenticated &&
  //       authState.user.custType == 'C';
  //
  //   if (isClient && !rekanState.isLoaded) {
  //     debugPrint("🔁 Refreshing MRekan1CrudBloc (profile header)");
  //     context.read<MRekan1CrudBloc>().add(MRekan1CrudLihatEvent());
  //   }
  // }

  void _refreshRekanIfNeeded(BuildContext context) {
    final rekanState = context.read<MRekan1CrudBloc>().state;
    final authState = context.read<AuthenticationBloc>().state;

    final isAuthenticated = authState is AuthenticationAuthenticated;

    if (isAuthenticated && !rekanState.isLoaded) {
      debugPrint("🔁 Refreshing MRekan1CrudBloc (profile header)");
      context.read<MRekan1CrudBloc>().add(MRekan1CrudLihatEvent());
    }
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
