// floating_chat_wrapper.dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_chat_flutter/presentation/mobile_chat_initialization.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../../blocs/gen_profile/mrekan1crud_bloc.dart';
import '../../common/app_data.dart';

class FloatingChatWrapper extends StatefulWidget {
  final Widget child;
  const FloatingChatWrapper({super.key, required this.child});

  @override
  State<FloatingChatWrapper> createState() => _FloatingChatWrapperState();
}

class _FloatingChatWrapperState extends State<FloatingChatWrapper> {
  String? _lastUserId;
  String? _lastDisplayName;

  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initChatIfNeeded();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    final viewPadding = MediaQuery.of(context).viewPadding;
    final keyboardVisible = viewInsets.bottom > 0;
    final systemBottomPadding = viewPadding.bottom;

    final double bottomOffset = keyboardVisible
        ? viewInsets.bottom + 16
        : systemBottomPadding > 0
        ? systemBottomPadding + 16
        : 16;

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (_, __) => _initChatIfNeeded(),
        ),
        BlocListener<MRekan1CrudBloc, MRekan1CrudState>(
          listenWhen: (prev, curr) =>
          prev.record?.rekanNama != curr.record?.rekanNama,
          listener: (_, __) => _initChatIfNeeded(),
        ),
      ],
      child: Stack(
        children: [
          widget.child,
          if (isMobile)
            Positioned(
              right: 16,
              bottom: bottomOffset,
              child: FloatingActionButton(
                onPressed: () => Navigator.pushNamed(context, 'chat'),
                child: const Icon(Icons.chat),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _initChatIfNeeded() async {
    if (!isMobile) return;

    final displayName = await _getDisplayName(context);
    final userId = _getUserId(context);

    if (_lastUserId != userId || _lastDisplayName != displayName) {
      debugPrint('[FloatingChat] Init: userId=$userId, name=$displayName');

      // Optional: If available, call reset/disconnect first
      // await MobileChatInitialization.reset();

      MobileChatInitialization.init(
        "_zGBGl1xg9V1ZQJVZNyFJg",
        "-8riuV9imwrYLkoV89aerSoTYsxiEAG-fPplAUw3dsc",
        "n_pujcjS8Dg7kd-AWjnDKSIPDL0gQhflerRNPhm5XAE",
        userId,
        displayName,
      );

      _lastUserId = userId;
      _lastDisplayName = displayName;
    }
  }

  Future<String> _getDisplayName(BuildContext context) async {
    final authState = context.read<AuthenticationBloc>().state;
    String displayName = "Guest";

    if (authState is AuthenticationAuthenticated) {
      displayName = authState.user.nama?.trim() ?? displayName;

      if (displayName.isEmpty || displayName == "Guest") {
        displayName = AppData.googleDisplayName?.trim().isNotEmpty == true
            ? AppData.googleDisplayName!.trim()
            : AppData.lastLoginEmail?.trim() ?? displayName;
      }
    }

    try {
      final rekanState = context.read<MRekan1CrudBloc>().state;
      final rekanNama = rekanState.record?.rekanNama?.trim();
      if (rekanState.isLoaded && rekanNama?.isNotEmpty == true) {
        displayName = rekanNama!;
      }
    } catch (_) {
      debugPrint('[GuestName] MRekan1CrudBloc not available');
    }

    return displayName;
  }

  String _getUserId(BuildContext context) {
    final authState = context.read<AuthenticationBloc>().state;
    if (authState is AuthenticationAuthenticated && authState.user.id != null) {
      return authState.user.id.toString();
    }
    return 'guest-${DateTime.now().millisecondsSinceEpoch}';
  }
}
