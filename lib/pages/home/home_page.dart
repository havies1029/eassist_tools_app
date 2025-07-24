// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:eassist_tools_app/blocs/home/home_bloc.dart';
// import 'package:eassist_tools_app/blocs/profile/profile_bloc.dart';
// import 'package:eassist_tools_app/common/size_config.dart';
// import 'package:eassist_tools_app/pages/base/base_container.dart';
// import 'package:eassist_tools_app/pages/base/base_page.dart';
// import 'package:eassist_tools_app/repositories/user/user_repository.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
//
// import '../../blocs/authentication/authentication_bloc.dart';
//
// class HomePage extends StatefulWidget {
//   final int userid;
//   final UserRepository userRepository;
//
//   const HomePage(
//       {required super.key, required this.userid, required this.userRepository});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   bool _isRestoredFromHydration = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final HomeState currentState = context.read<HomeBloc>().state;
//       debugPrint("🔥 [INIT] Hydrated HomeBloc State: $currentState");
//
//       // Anggap semua state selain HomePageActive berasal dari hydrated
//       _isRestoredFromHydration = currentState is! HomePageActive;
//
//       final authState = context.read<AuthenticationBloc>().state;
//
//       if (_isRestoredFromHydration && authState is AuthenticationAuthenticated) {
//         final event = _convertStateToEvent(currentState);
//         debugPrint("⚡️ [INIT] Dispatching restored event: $event");
//         context.read<HomeBloc>().add(event);
//       } else {
//         debugPrint("⛔️ [INIT] Skip restore karena belum login atau sudah HomePageActive");
//       }
//     });
//   }
//
//
//   HomeEvent _convertStateToEvent(HomeState state) {
//     debugPrint("🧠 [CONVERT] Converting $state to HomeEvent");
//     if (state is ProfilePageActive) return ProfilePageActiveEvent();
//     if (state is RoomCariPageActive) return RoomCariPageActiveEvent();
//     if (state is ChangePasswordPageActive) return ChangePasswordPageActiveEvent();
//     if (state is SimulMVPageActive) return SimulMVPageActiveEvent();
//     if (state is SimulPARPageActive) return SimulPARPageActiveEvent();
//     if (state is SimulFlexasPageActive) return SimulFlexasPageActiveEvent();
//     if (state is SimulEEIPageActive) return SimulEEIPageActiveEvent();
//     if (state is SimulGITPageActive) return SimulGITPageActiveEvent();
//     if (state is SimulGISPageActive) return SimulGISPageActiveEvent();
//     if (state is SimulBONPageActive) return SimulBONPageActiveEvent();
//     if (state is SimulWPPageActive) return SimulWPPageActiveEvent();
//     if (state is SimulCARGOPageActive) return SimulCARGOPageActiveEvent();
//     if (state is SimulCARPageActive) return SimulCARPageActiveEvent();
//     if (state is SimulMBPageActive) return SimulMBPageActiveEvent();
//     if (state is SimulTREEPageActive) return SimulTREEPageActiveEvent();
//     if (state is TrackKlaimPageActive) return TrackKlaimPageActiveEvent();
//     if (state is StartChatPageActive) return StartChatPageActiveEvent();
//     if (state is SplashPageActive) return SplashPageActiveEvent();
//     if (state is ProfileIndividuPageActive) return ProfileIndividuPageActiveEvent();
//     if (state is ProfilePerusahaanPageActive) return ProfilePerusahaanPageActiveEvent();
//     if (state is Article1PageActive) return Article1PageActiveEvent();
//     if (state is TestProfilePageActive) return TestProfilePageActiveEvent();
//     if (state is AboutPageActive) return AboutPageActiveEvent();
//     if (state is ActiveAssetsPageActive) return ActiveAssetsPageActiveEvent();
//     if (state is ArticlePageActive) return ArticlePageActiveEvent();
//     if (state is AssetsManagementPageActive) return AssetsManagementPageActiveEvent();
//     if (state is PolisManagementPageActive) return PolisManagementPageActiveEvent();
//     if (state is FindInsurancePageActive) return FindInsurancePageActiveEvent();
//     if (state is HeroUserPageActive) {
//       debugPrint("🔁 [EVENT] Converting HeroUserPageActive to HeroUserPageActiveEvent()");
//       return HeroUserPageActiveEvent();
//     }
//     if (state is HeroPageActive) {
//       debugPrint("🔁 [EVENT] Converting HeroPageActive to HeroPageActiveEvent()");
//       return HeroPageActiveEvent();
//     }
//     if (state is TestimonyPageActive) return TestimonyPageActiveEvent();
//     if (state is CsPageActive) return CsPageActiveEvent();
//     if (state is UserNonJPSPageActive) return UserNonJPSPageActiveEvent();
//     if (state is UserJPSPageActive) return UserJPSPageActiveEvent();
//     if (state is LoadingHeroPageActive) return LoadingHeroPageActiveEvent();
//     if (state is LoadingHero2PageActive) return LoadingHero2PageActiveEvent();
//     if (state is LoadingHeroUserPageActive) return LoadingHeroUserPageActiveEvent();
//     if (state is CobCariPageActive) return CobCariPageActiveEvent();
//     if (state is AsetDashboardPageActive) return AsetDashboardPageActiveEvent();
//     if (state is AsetParPageActive) return AsetParPageActiveEvent();
//     if (state is AsetMVPageActive) return AsetMVPageActiveEvent();
//     if (state is AsetRingkasanPageActive) return AsetRingkasanPageActiveEvent();
//     if (state is AsetHealthPageActive) return AsetHealthPageActiveEvent();
//     if (state is AsetStatusPageActive) return AsetStatusPageActiveEvent();
//     if (state is AsetPageActive) return AsetPageActiveEvent();
//     if (state is ReviewCariPageActive) return ReviewCariPageActiveEvent();
//     if (state is BeritaPageActive) return BeritaPageActiveEvent();
//     if (state is BeritaSampinganPageActive) return BeritaSampinganPageActiveEvent();
//     if (state is BeritaArtikelPageActive) return BeritaArtikelPageActiveEvent();
//     debugPrint("❗️[FALLBACK] Unknown state, fallback to HomePageActiveEvent()");
//     // Default fallback
//     return HomePageActiveEvent();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return MultiBlocProvider(
//       providers: [
//         // BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
//         BlocProvider<ProfileBloc>(
//           create: (content) => ProfileBloc(
//               userRepository: widget.userRepository, id: widget.userid),
//         )
//       ],
//       child: BlocListener<HomeBloc, HomeState>(
//         listener: (context, state) {
//           // debugPrint("🧭 Listener menerima state: $state");
//
//           Widget targetPage;
//
//           if (state is ProfilePageActive) {
//             targetPage = PageContainerWithUserRepository(
//               pageType: PageType.profile,
//               userRepository: widget.userRepository,
//               userid: widget.userid, key: null,
//             );
//           } else {
//             final pageType = _getPageTypeFromState(state);
//             if (pageType != null) {
//               targetPage = PageContainer(pageType: pageType);
//             } else {
//               return;
//             }
//           }
//
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => targetPage),
//           );
//         },
//         child:
//         BlocBuilder<AuthenticationBloc, AuthenticationState>(
//           builder: (context, authState) {
//             // Belum login → Splash
//             if (authState is AuthenticationUnauthenticated &&
//                 authState is! AuthenticationGoogleUserAuthenticated ) {
//               HydratedBloc.storage.clear();
//               return const PageContainer(pageType: PageType.home);
//             }
//
//             // Sudah login → lihat HomeBloc state
//             return BlocBuilder<HomeBloc, HomeState>(
//               builder: (context, homeState) {
//                 final pageType = _getPageTypeFromState(homeState);
//                 if (pageType != null) {
//                   return PageContainer(pageType: pageType);
//                 } else {
//                   return const PageContainer(pageType: PageType.home);
//                 }
//               },
//             );
//           },
//         )
//         ,
//       ),
//     );
//   }
//
//   PageType? _getPageTypeFromState(HomeState state) {
//       if (state is HomePageActive) {
//       debugPrint("🎯 [PAGE TYPE] Mapped HomePageActive to PageType.home");
//       return PageType.home;
//     }
//     if (state is RoomCariPageActive) return PageType.roomchat;
//     if (state is ChangePasswordPageActive) return PageType.changepswd;
//     if (state is SimulMVPageActive) return PageType.simulmv;
//     if (state is SimulPARPageActive) return PageType.simulpar;
//     if (state is SimulFlexasPageActive) return PageType.simulflexas;
//     if (state is SimulEEIPageActive) return PageType.simuleei;
//     if (state is SimulGITPageActive) return PageType.simulgit;
//     if (state is SimulGISPageActive) return PageType.simulgis;
//     if (state is SimulBONPageActive) return PageType.simulbon;
//     if (state is SimulWPPageActive) return PageType.simulwp;
//     if (state is SimulCARGOPageActive) return PageType.simulcargo;
//     if (state is SimulCARPageActive) return PageType.simulcar;
//     if (state is SimulMBPageActive) return PageType.simulmb;
//     if (state is SimulTREEPageActive) return PageType.simultree;
//     if (state is TrackKlaimPageActive) return PageType.klaimtrack;
//     if (state is StartChatPageActive) return PageType.startchat;
//     if (state is SplashPageActive) return PageType.splash;
//     if (state is ProfileIndividuPageActive) return PageType.profileindividu;
//     if (state is ProfilePerusahaanPageActive) return PageType.profileperusahaan;
//     if (state is Article1PageActive) return PageType.article1;
//     if (state is TestProfilePageActive) return PageType.testprofile;
//     if (state is AboutPageActive) return PageType.about;
//     if (state is ActiveAssetsPageActive) return PageType.activeassets;
//     if (state is ArticlePageActive) return PageType.article;
//     if (state is AssetsManagementPageActive) return PageType.assetsmanagement;
//     if (state is PolisManagementPageActive) return PageType.polismanagement;
//     if (state is FindInsurancePageActive) return PageType.findinsurance;
//       if (state is HeroUserPageActive) {
//         debugPrint("🎯 [PAGE TYPE] Mapped HeroUserPageActive to PageType.herouser");
//         return PageType.herouser;
//       }
//       if (state is HeroPageActive) {
//         debugPrint("🎯 [PAGE TYPE] Mapped HeroPageActive to PageType.hero");
//         return PageType.hero;
//       }
//
//     if (state is TestimonyPageActive) return PageType.testimony;
//     if (state is CsPageActive) return PageType.cs;
//     if (state is UserNonJPSPageActive) return PageType.usernonjps;
//     if (state is UserJPSPageActive) return PageType.userjps;
//     if (state is LoadingHeroPageActive) return PageType.loadinghero;
//     if (state is LoadingHero2PageActive) return PageType.loadinghero2;
//     if (state is LoadingHeroUserPageActive) return PageType.loadingherouser;
//     if (state is CobCariPageActive) return PageType.cobcari;
//     if (state is AsetDashboardPageActive) return PageType.asetdashboard;
//     if (state is AsetParPageActive) return PageType.asetpar;
//     if (state is AsetMVPageActive) return PageType.asetmv;
//     if (state is AsetRingkasanPageActive) return PageType.asetringkasan;
//     if (state is AsetHealthPageActive) return PageType.asethealth;
//     if (state is AsetStatusPageActive) return PageType.asetstatus;
//     if (state is AsetPageActive) return PageType.aset;
//     if (state is ReviewCariPageActive) return PageType.review;
//     if (state is BeritaPageActive) return PageType.berita;
//     if (state is BeritaSampinganPageActive) return PageType.beritasampingan;
//     if (state is BeritaArtikelPageActive) return PageType.beritaartikel;
//     return null;
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/home/home_bloc.dart';
import 'package:eassist_tools_app/blocs/profile/profile_bloc.dart';
import 'package:eassist_tools_app/common/size_config.dart';
import 'package:eassist_tools_app/pages/base/base_container.dart';
import 'package:eassist_tools_app/pages/base/base_page.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';

class HomePage extends StatefulWidget {
  final int userid;
  final UserRepository userRepository;

  const HomePage(
      {required super.key, required this.userid, required this.userRepository});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        // BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        BlocProvider<ProfileBloc>(
          create: (content) => ProfileBloc(
              userRepository: widget.userRepository, id: widget.userid),
        )
      ],
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          // debugPrint("🧭 Listener menerima state: $state");

          Widget targetPage;

          if (state is ProfilePageActive) {
            targetPage = PageContainerWithUserRepository(
              pageType: PageType.profile,
              userRepository: widget.userRepository,
              userid: widget.userid, key: null,
            );
          } else {
            final pageType = _getPageTypeFromState(state);
            if (pageType != null) {
              targetPage = PageContainer(pageType: pageType);
            } else {
              return;
            }
          }

          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => targetPage),
          );
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            // Halaman pertama bisa default atau kosong
            return const PageContainer(pageType: PageType.home);
          },
        ),
      ),
    );
  }

  PageType? _getPageTypeFromState(HomeState state) {
    if (state is HomePageActive) return PageType.home;
    if (state is RoomCariPageActive) return PageType.roomchat;
    if (state is ChangePasswordPageActive) return PageType.changepswd;
    if (state is SimulMVPageActive) return PageType.simulmv;
    if (state is SimulPARPageActive) return PageType.simulpar;
    if (state is SimulFlexasPageActive) return PageType.simulflexas;
    if (state is SimulEEIPageActive) return PageType.simuleei;
    if (state is SimulGITPageActive) return PageType.simulgit;
    if (state is SimulGISPageActive) return PageType.simulgis;
    if (state is SimulBONPageActive) return PageType.simulbon;
    if (state is SimulWPPageActive) return PageType.simulwp;
    if (state is SimulCARGOPageActive) return PageType.simulcargo;
    if (state is SimulCARPageActive) return PageType.simulcar;
    if (state is SimulMBPageActive) return PageType.simulmb;
    if (state is SimulTREEPageActive) return PageType.simultree;
    if (state is TrackKlaimPageActive) return PageType.klaimtrack;
    if (state is StartChatPageActive) return PageType.startchat;
    if (state is SplashPageActive) return PageType.splash;
    if (state is ProfileIndividuPageActive) return PageType.profileindividu;
    if (state is ProfilePerusahaanPageActive) return PageType.profileperusahaan;
    if (state is Article1PageActive) return PageType.article1;
    if (state is TestProfilePageActive) return PageType.testprofile;
    if (state is AboutPageActive) return PageType.about;
    if (state is ActiveAssetsPageActive) return PageType.activeassets;
    if (state is ArticlePageActive) return PageType.article;
    if (state is AssetsManagementPageActive) return PageType.assetsmanagement;
    if (state is PolisManagementPageActive) return PageType.polismanagement;
    if (state is FindInsurancePageActive) return PageType.findinsurance;
    if (state is TestimonyPageActive) return PageType.testimony;
    if (state is CsPageActive) return PageType.cs;
    if (state is UserNonJPSPageActive) return PageType.usernonjps;
    if (state is UserJPSPageActive) return PageType.userjps;
    if (state is LoadingHeroPageActive) return PageType.loadinghero;
    if (state is LoadingHero2PageActive) return PageType.loadinghero2;
    if (state is LoadingHeroUserPageActive) return PageType.loadingherouser;
    if (state is CobCariPageActive) return PageType.cobcari;
    if (state is AsetDashboardPageActive) return PageType.asetdashboard;
    if (state is AsetParPageActive) return PageType.asetpar;
    if (state is AsetMVPageActive) return PageType.asetmv;
    if (state is AsetRingkasanPageActive) return PageType.asetringkasan;
    if (state is AsetHealthPageActive) return PageType.asethealth;
    if (state is AsetStatusPageActive) return PageType.asetstatus;
    if (state is AsetPageActive) return PageType.aset;
    if (state is ReviewCariPageActive) return PageType.review;
    if (state is BeritaPageActive) return PageType.berita;
    if (state is BeritaSampinganPageActive) return PageType.beritasampingan;
    if (state is BeritaArtikelPageActive) return PageType.beritaartikel;
    return null;
  }
}
