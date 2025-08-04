import 'dart:io';
// import 'dart:ui' as html;

import 'package:eassist_tools_app/blocs/authentication/authentication_bloc.dart';
import 'package:eassist_tools_app/blocs/chatting/guestscrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gallery/galleryeventcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gallery/gallerymembercari_bloc.dart';
import 'package:eassist_tools_app/blocs/gallery/gallerytestimonycari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_aset_mv/asetmvcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_aset_par/asetparcari_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekan1list_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanbankcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekangeneralcmpcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpajakcrud_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_profile/mrekanpiclist_bloc.dart';
import 'package:eassist_tools_app/blocs/klaim/klaim1list_bloc.dart';
import 'package:eassist_tools_app/blocs/klaim/klaim2list_bloc.dart';
import 'package:eassist_tools_app/blocs/login/change_password_bloc.dart';
import 'package:eassist_tools_app/blocs/login/emailverification_bloc.dart';
import 'package:eassist_tools_app/blocs/login/login_bloc.dart';
import 'package:eassist_tools_app/blocs/networkconnection/network_bloc.dart';
import 'package:eassist_tools_app/blocs/onboardmenu/onboardmenucari_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/mrekangeneral_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/rekancontact_bloc.dart';
import 'package:eassist_tools_app/blocs/progressindicator/progressindicator_bloc.dart';
import 'package:eassist_tools_app/blocs/reguser/reguser_bloc.dart';
import 'package:eassist_tools_app/blocs/takeimage/takeimage_cubit.dart';
import 'package:eassist_tools_app/common/app_data.dart';
import 'package:eassist_tools_app/pages/base/base_page.dart';
import 'package:eassist_tools_app/pages/hero_client_page/hero_user_main.dart';
import 'package:eassist_tools_app/pages/heropage/hero_main.dart';
import 'package:eassist_tools_app/pages/home/home_page.dart';
import 'package:eassist_tools_app/repositories/chatting/guestscrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_aset_par/asetparcari_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekan1crud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekan1list_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekanbankcrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekancontactcrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekangeneralcmpcrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekangeneralidvcrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekanpajakcrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekanpiccrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_profile/mrekanpiclist_repository.dart';
import 'package:eassist_tools_app/repositories/gen_sppamv/sppamvcrud_repository.dart';
import 'package:eassist_tools_app/repositories/gen_sppapar/sppaparcrud_repository.dart';
import 'package:eassist_tools_app/repositories/login/change_password_repository.dart';
import 'package:eassist_tools_app/repositories/login/emailverification_repository.dart';
import 'package:eassist_tools_app/repositories/profile/rekanbank_repository.dart';
import 'package:eassist_tools_app/repositories/profile/rekancontact_repository.dart';
import 'package:eassist_tools_app/repositories/profile/rekangeneral_repository.dart';
import 'package:eassist_tools_app/repositories/profile/rekanpajak_repository.dart';
import 'package:eassist_tools_app/repositories/profile/userfoto_repository.dart';
import 'package:eassist_tools_app/repositories/reguser/reguser_repository.dart';
import 'package:eassist_tools_app/repositories/simulmv/simulmvcrud_repository.dart';
import 'package:eassist_tools_app/repositories/simulpar/simulparcrud_repository.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';
import 'package:eassist_tools_app/widgets/account/login/login_gmail/popup_dialog_login.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:js/js_util.dart' as js_util;
import 'blocs/gen_aset_dashboard/asetdashboardcari_bloc.dart';
import 'blocs/gen_aset_health/asethealthcari_bloc.dart';
import 'blocs/gen_aset_ringkasan/asetringkasancari_bloc.dart';
import 'blocs/gen_berita/berita1cari_bloc.dart';
import 'blocs/gen_berita/berita2cari_bloc.dart';
import 'blocs/gen_berita/berita3cari_bloc.dart';
import 'blocs/gen_berita/beritakecilcari_bloc.dart';
import 'blocs/gen_berita/beritalaincari_bloc.dart';
import 'blocs/gen_cob_app/cobcari_bloc.dart';
import 'blocs/gen_profile/mrekan1crud_bloc.dart';
import 'blocs/gen_profile/mrekancontactcrud_bloc.dart';
import 'blocs/gen_profile/mrekangeneralidvcrud_bloc.dart';
import 'blocs/gen_profile/mrekanpiccrud_bloc.dart';
import 'blocs/gen_promo/promo1cari_bloc.dart';
import 'blocs/gen_promo/promo2cari_bloc.dart';
import 'blocs/gen_review/reviewcari_bloc.dart';
import 'blocs/gen_sppamv/sppamvcrud_bloc.dart';
import 'blocs/gen_sppamv/sppamvlist_bloc.dart';
import 'blocs/gen_sppapar/sppaparcrud_bloc.dart';
import 'blocs/gen_sppapar/sppaparlist_bloc.dart';
import 'blocs/gen_status_aset/statusasetcari_bloc.dart';
import 'blocs/home/home_bloc.dart';
import 'blocs/profile/profile_download_foto_bloc.dart';
import 'blocs/profile/profile_upload_foto_bloc.dart';
import 'blocs/profile/rekanbank_bloc.dart';
import 'blocs/profile/rekangeneral_bloc.dart';
import 'blocs/profile/rekanpajak_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:mobile_chat_flutter/mobile_chat_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/simulmv/simulmvcrud_bloc.dart';
import 'blocs/simulpar/simulparcrud_bloc.dart';

// NONAKTIFKAN DEBUG PRINT & ERROR MERAH

// auth_handler.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool _loginDialogOpen = false;                 // cegah dialog dobel
AuthenticationState? _lastAuthStateGlobal;     // last state global
bool _sudahTerdaftarSebagaiClient = false;     // jadikan flag global (bukan setState)

Future<void> handleAuthenticationStateGlobal({
  required NavigatorState? rootNav,  // navigatorKey.currentState
  required BuildContext context,     // fallback jika rootNav null
  required AuthenticationState state,
}) async {
  final nav = rootNav ?? Navigator.of(context, rootNavigator: true);

  // Helper: pop ke root (tanpa mem-pop listener sendiri)
  void popToRoot() {
    if (nav.canPop()) {
      nav.popUntil((r) => r.isFirst);
    }
  }

  // ========== UNA UTH ==========
  if (state is AuthenticationUnauthenticated) {
    // Skip kalau masih di step verifikasi/OTP
    if (_lastAuthStateGlobal is AuthenticationRequirePinEmailVerification ||
        _lastAuthStateGlobal is AuthenticationRequirePinHPVerification ||
        _lastAuthStateGlobal is AuthenticationRequireRegisterClient ||
        AppData.isInOtpProcess == true) {
      _lastAuthStateGlobal = state;
      return;
    }

    popToRoot();

    // Guard agar tidak munculin dialog dua kali
    if (_loginDialogOpen) {
      _lastAuthStateGlobal = state;
      return;
    }
    _loginDialogOpen = true;

    // Tunda ke frame berikutnya agar tree stabil
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!context.mounted) { _loginDialogOpen = false; return; }
      await Future.delayed(const Duration(milliseconds: 50));
      await CustomPopupsLoginUser.showLoginUserDialog(
        nav.context, // pastikan showDialog() pakai useRootNavigator: true
      );
    });

    _lastAuthStateGlobal = state;
    return;
  }

  // ========== REQUIRE LOGIN CLIENT ==========
  if (state is AuthenticationRequireLoginClient) {
    popToRoot();

    if (state.requiredFrom == "bloc_email_verification") {
      _sudahTerdaftarSebagaiClient = true; // ganti setState → flag global
      await Future.delayed(const Duration(milliseconds: 150));
    }

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      CustomPopupsLoginUser.showLoginClientDialog(nav.context);
    });

    _lastAuthStateGlobal = state;
    return;
  }

  // ========== FORGOT PASSWORD ==========
  if (state is AuthenticationForgotPassword) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      CustomPopupsLoginUser.showForgotPasswordDialog(nav.context);
    });
    _lastAuthStateGlobal = state;
    return;
  }

  // ========== REGISTER CLIENT ==========
  if (state is AuthenticationRequireRegisterClient) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      CustomPopupsLoginUser.showRegisterClientDialog(nav.context);
    });
    _lastAuthStateGlobal = state;
    return;
  }

  // ========== OTP HP ==========
  if (state is AuthenticationRequirePinHPVerification) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      CustomPopupsLoginUser.showRequestOTPHPDialog(nav.context, state.hpno);
    });
    _lastAuthStateGlobal = state;
    return;
  }

  // ========== OTP EMAIL ==========
  if (state is AuthenticationRequirePinEmailVerification) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      CustomPopupsLoginUser.showRequestOTPEmailDialog(nav.context, state.email);
    });
    _lastAuthStateGlobal = state;
    return;
  }

  // ========== PHONE PIN VERIFIED → LOGOUT MANDATORY ==========
  if (state is AuthenticationPhonePinVerified) {
    context.read<AuthenticationBloc>().add(
      LoggedOut(homeBloc: context.read<HomeBloc>()),
    );
    _lastAuthStateGlobal = state;
    return;
  }

  // ========== AUTHENTICATED ==========
  if (state is AuthenticationAuthenticated) {
    // Tutup dialog jika masih terbuka
    popToRoot();
    _loginDialogOpen = false;

    // Muat data client bila perlu
    if (state.user.custType == "C") {
      context.read<MRekan1CrudBloc>().add(MRekan1CrudLihatEvent());
    }

    // Opsional: sinkron ke home bila bukan home
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;
      final homeBloc = context.read<HomeBloc>();
      if (homeBloc.currentPage != PageType.home) {
        homeBloc.add(PushPageEvent(PageType.home));
      }
    });

    _lastAuthStateGlobal = state;
    return;
  }

  // Simpan last state
  _lastAuthStateGlobal = state;
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userRepository = UserRepository();
  AppData.kIsWeb = kIsWeb;

  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }

  // Inisialisasi hydrated_bloc
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  HydratedBloc.storage = storage;

  // Ambil lastPage dari SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final lastPage = prefs.getString('lastPageType');
  final initialPageType = PageType.values.firstWhere(
        (e) => e.name == lastPage,
    orElse: () => PageType.home,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (_) => AuthenticationBloc(userRepository: userRepository)
            ..add(AppStarted()),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(initialPage: PageType.home), // ← jangan emit langsung di sini
        ),
      ],
      child: App(
        userRepository: userRepository,
        navigatorKey: navigatorKey, // ⬅️ ditambahkan di sini
        key: null,
      ),
    ),
  );

  // ✅ Setelah runApp selesai
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      final homeBloc = BlocProvider.of<HomeBloc>(context);
      if (initialPageType != PageType.home) {
        // debugPrint("🧠 PostFrame: Push page from SharedPreferences: $initialPageType");
        homeBloc.add(PushPageEvent(initialPageType));
      }
    }
  });
}
class App extends StatelessWidget {
  final UserRepository userRepository;
  final GlobalKey<NavigatorState> navigatorKey;

  const App({
    super.key,
    required this.userRepository,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authenticationBloc: context.read<AuthenticationBloc>(),
            userRepository: userRepository,
            homeBloc: context.read<HomeBloc>(), // ✅ Tambahkan ini
          ),
        ),
        BlocProvider<EmailVerificationBloc>(
            create: (context) =>
                EmailVerificationBloc(
                    repository: EmailVerificationRepository(),
                    authenticationBloc: BlocProvider.of<AuthenticationBloc>(context))),
        BlocProvider<ChangePasswordBloc>(
            create: (context) =>
                ChangePasswordBloc(repository: ChangePasswordRepository())),
        BlocProvider<TakeImageCubit>(
          create: (context) => TakeImageCubit(),
        ),
        BlocProvider<ProgressIndicatorBloc>(
            create: (context) => ProgressIndicatorBloc()),
        BlocProvider<NetworkBloc>(
            create: (context) => NetworkBloc()..add(NetworkObserve())),
        BlocProvider<OnBoardMenuCariBloc>(
            create: (context) => OnBoardMenuCariBloc()),
        BlocProvider<Klaim1ListBloc>(
            create: (context) =>
                Klaim1ListBloc()),
        BlocProvider<Klaim2ListBloc>(
            create: (context) =>
                Klaim2ListBloc()),
        BlocProvider<GuestsCrudBloc>(
            create: (context) =>
                GuestsCrudBloc(repository: GuestsCrudRepository())),
        BlocProvider<GalleryeventCariBloc>(
            create: (context) =>
                GalleryeventCariBloc()),
        BlocProvider<GallerytestimonyCariBloc>(
            create: (context) =>
                GallerytestimonyCariBloc()),
        BlocProvider<GallerymemberCariBloc>(
            create: (context) =>
                GallerymemberCariBloc()),
        BlocProvider<RekanContactBloc>(
            create: (context) =>
                RekanContactBloc(repository: RekanContactRepository())),
        BlocProvider<RekanGeneralBloc>(
            create: (context) =>
                RekanGeneralBloc(repository: RekanGeneralRepository())),
        BlocProvider<RekanPajakBloc>(
            create: (context) =>
                RekanPajakBloc(repository: RekanPajakRepository())),
        BlocProvider<RekanBankBloc>(
            create: (context) =>
                RekanBankBloc(repository: RekanBankRepository())),
        BlocProvider<MRekanContactCrudBloc>(
          create: (context) => MRekanContactCrudBloc(repository: MRekanContactCrudRepository()),
        ),
        BlocProvider<MRekanGeneralCmpCrudBloc>(
          create: (context) => MRekanGeneralCmpCrudBloc(repository: MRekanGeneralCmpCrudRepository()),
        ),
        BlocProvider<MRekanGeneralCmpCrudBloc>(
          create: (context) => MRekanGeneralCmpCrudBloc(repository: MRekanGeneralCmpCrudRepository()),
        ),
        BlocProvider<MRekanPajakCrudBloc>(
          create: (context) => MRekanPajakCrudBloc(repository: MRekanPajakCrudRepository()),
        ),BlocProvider<MRekanBankCrudBloc>(
          create: (context) => MRekanBankCrudBloc(repository: MRekanBankCrudRepository()),
        ),
        BlocProvider<MRekanGeneralIdvCrudBloc>(
          create: (context) => MRekanGeneralIdvCrudBloc(repository: MRekanGeneralIdvCrudRepository()),
        ),
        BlocProvider<MRekanPicListBloc>(
          create: (context) => MRekanPicListBloc(repository: MRekanPicListRepository())..add(FetchMRekanPicListEvent()),
        ),
        BlocProvider<MRekan1CrudBloc>(
          create: (context) => MRekan1CrudBloc(repository: MRekan1CrudRepository()),
        ),
        BlocProvider<MRekanPicCrudBloc>(
          create: (context) => MRekanPicCrudBloc(repository: MRekanPicCrudRepository()),
        ),
        BlocProvider<GallerymemberCariBloc>(
            create: (context) =>
                GallerymemberCariBloc()),
        BlocProvider<ProfileUploadFotoBloc>(
            create: (context) =>
                ProfileUploadFotoBloc()),
        BlocProvider<ProfileDownloadFotoBloc>(
            create: (context) =>
                ProfileDownloadFotoBloc(repository: UserFotoRepository())),
        BlocProvider<MRekan1ListBloc>(
            create: (context) =>
                MRekan1ListBloc()),
        BlocProvider<RegUserBloc>(
            create: (context) =>
                RegUserBloc(repository: RegUserRepository(), authenticationBloc: BlocProvider.of<AuthenticationBloc>(context))),
        BlocProvider<CobCariBloc>(
            create: (context) => CobCariBloc()),
        BlocProvider<AsetDashboardCariBloc>(
            create: (context) => AsetDashboardCariBloc()),
        BlocProvider<AsetParCariBloc>(
            create: (context) => AsetParCariBloc()),
        BlocProvider<AsetMvCariBloc>(
            create: (context) => AsetMvCariBloc()),
        BlocProvider<AsetRingkasanCariBloc>(
            create: (context) => AsetRingkasanCariBloc()),
        BlocProvider<AsetHealthCariBloc>(
            create: (context) => AsetHealthCariBloc()),
        BlocProvider(create: (context) => StatusAsetCariBloc()),
        BlocProvider(create: (context) => ReviewCariBloc()),
        BlocProvider(create: (context) => Berita1CariBloc()),
        BlocProvider(create: (context) => Berita2CariBloc()),
        BlocProvider(create: (context) => Berita3CariBloc()),
        BlocProvider(create: (context) => BeritaKecilCariBloc()),
        BlocProvider(create: (context) => BeritaLainCariBloc()),
        BlocProvider(create: (context) => Promo1CariBloc()),
        BlocProvider(create: (context) => Promo2CariBloc()),
        BlocProvider<SimulmvCrudBloc>(
            create: (context) =>
                SimulmvCrudBloc(repository: SimulmvCrudRepository())),
        BlocProvider<SimulparCrudBloc>(
            create: (context) =>
                SimulparCrudBloc(repository: SimulparCrudRepository())),
        BlocProvider(create:(context) => SppamvListBloc()),
        BlocProvider(create: (context) => SppamvCrudBloc(repository: SppamvCrudRepository())),
        BlocProvider(create: (context) => SppaparListBloc()),
        BlocProvider(create: (context) => SppaparCrudBloc(repository: SppaparCrudRepository())),
      ],
      child: BlocListener<AuthenticationBloc, AuthenticationState>(
        listenWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
        listener: (context, state) {
          handleAuthenticationStateGlobal(
            rootNav: navigatorKey.currentState,
            context: context,
            state: state,
          );
        },
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'JPS Insurance',
          theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
          darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
          themeMode: ThemeMode.light,
          navigatorObservers: [routeObserver],
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case 'chat':
                return MaterialPageRoute(builder: (_) => const MobileChatScreen());
              default:
                return MaterialPageRoute(
                  builder: (_) => HomePage(
                    userRepository: userRepository,
                    userid: 0, key: null,
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}


// void disableAllLogs() {
//   // 1. Matikan semua print/debugPrint
//   debugPrint = (String? message, {int? wrapWidth}) {};
//
//   // 2. Matikan error dari Flutter framework
//   FlutterError.onError = (FlutterErrorDetails details) {};
//
//   // 3. Tangani semua error global (termasuk Web & Mobile)
//   PlatformDispatcher.instance.onError = (error, stack) => true;
//
//   // 4. Matikan console log di Web
//   if (kIsWeb) {
//     try {
//       final console = js_util.getProperty(html.window, 'console');
//       js_util.setProperty(console, 'log', js_util.allowInterop((_) {}));
//       js_util.setProperty(console, 'warn', js_util.allowInterop((_) {}));
//       js_util.setProperty(console, 'error', js_util.allowInterop((_) {}));
//     } catch (_) {
//       // jika browser tidak support
//     }
//   }
//
//   // 5. Hilangkan widget error merah dari UI
//   ErrorWidget.builder = (FlutterErrorDetails details) {
//     return const SizedBox();
//   };
// }
