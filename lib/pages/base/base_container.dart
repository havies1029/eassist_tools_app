// import 'package:eassist_tools_app/pages/aset/aset_main.dart';
// import 'package:eassist_tools_app/pages/chatting/roomcari_list.dart';
// import 'package:eassist_tools_app/pages/gen_aset_health/asethealthcari_main.dart';
// import 'package:eassist_tools_app/pages/groupchat/groupchat_page.dart';
// import 'package:eassist_tools_app/pages/home/home_page.dart';
// import 'package:eassist_tools_app/menu/app_menu_drawer.dart';
// import 'package:eassist_tools_app/pages/base/base_page.dart';
// import 'package:eassist_tools_app/common/styles.dart';
// import 'package:eassist_tools_app/pages/klaim/klaim1list_main.dart';
// import 'package:eassist_tools_app/pages/login/change_pswd_main.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// // import 'package:eassist_tools_app/pages/profile/profile_main_page.dart';
// import 'package:eassist_tools_app/repositories/user/user_repository.dart';
// import '../../blocs/authentication/authentication_bloc.dart';
// import '../../blocs/home/home_bloc.dart';
// import '../../main.dart';
// import '../../widgets/account/profile/profile_main_page.dart';
// import '../about_jps/about_main.dart';
// import '../active_assets/active_assets_main.dart';
// import '../article_page/article_detail.dart';
// import '../article_page/article_main.dart';
// import '../customer_service/cs_main.dart';
// import '../find_insurance/find_insurance_main.dart';
// import '../gen_aset_dashboard/asetdashboardcari_list.dart';
// import '../gen_aset_dashboard/asetdashboardcari_main.dart';
// import '../gen_aset_mv/asetmvcari_main.dart';
// import '../gen_aset_par/asetparcari_list.dart';
// import '../gen_aset_par/asetparcari_main.dart';
// import '../gen_aset_ringkasan/asetringkasancari_main.dart';
// import '../gen_cob_app/cobcari_main.dart';
// import '../gen_profile/test_profile_main.dart';
// import '../gen_review/reviewcari_main.dart';
// import '../gen_status_aset/statusasetcari_main.dart';
// import '../hero_client_page/hero_user_main.dart';
// import '../heropage/hero_main.dart';
// import '../home/home_redirector_page.dart';
// import '../loading/loading_user2_page.dart';
// import '../qontak/floating_chat_wrapper.dart';
// import '../loading/loading_client_page.dart';
// import '../loading/loading_user_page.dart';
// import '../splash/splash_page.dart';
// import '../management_asset/management_asset_main.dart';
// import '../management_polis/management_polis_main.dart';
// import '../testimony_page/testimony_main.dart';
// import '../user_jps/user_jps_main.dart';
// import '../user_non_jps/user_non_jps_main.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class PageContainerWithUserRepository extends PageContainerBase {
//   final int userid;
//   final UserRepository userRepository;
//   final PageType pageType;
//
//   const PageContainerWithUserRepository(
//       {required super.key,
//       required this.userid,
//       required this.userRepository,
//       required this.pageType});
//
//   @override
//   Widget get menuDrawer {
//     return const AppMenu();
//   }
//
//   @override
//   String get pageTitle {
//     //debugPrint("PageContainerWithUserRepository -> pageTitle");
//     switch (pageType) {
//       case PageType.profile:
//         return "Profile";
//       default:
//         return "Login Page";
//     }
//   }
//
//   @override
//   Widget get body {
//     Widget? page;
//     //debugPrint("PageContainerWithUserRepository -> body");
//     switch (pageType) {
//       case PageType.home:
//         page = HomePage(
//           userid: userid,
//           userRepository: userRepository,
//           key: null,
//         );
//         break;
//       // case PageType.profile:
//       //   page = ProfileMainPage(
//       //     userid: userid,
//       //     userRepository: userRepository,
//       //   );
//       //   break;
//       default:
//         page = null;
//     }
//     return Padding(
//       padding: EdgeInsets.all(Spacing.matGridUnit()),
//       child: page,
//     );
//   }
//
//   @override
//   Widget get background => Container();
//
//   @override
//   Color get backgroundColor => AppColors.background;
//
//   @override
//   PageType? get parentModal => null;
// }
//
// class PageContainer extends StatefulWidget {
//   final PageType pageType;
//   final String? recId;
//
//   const PageContainer({super.key, required this.pageType, this.recId});
//
//   @override
//   State<PageContainer> createState() => _PageContainerState();
// }
//
// class _PageContainerState extends State<PageContainer> with RouteAware {
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Daftarkan halaman ini ke RouteObserver saat aktif
//     final route = ModalRoute.of(context);
//     if (route is PageRoute) {
//       routeObserver.subscribe(this, route);
//     }
//
//   }
//
//   @override
//   void dispose() {
//     // Unregister saat halaman ini tidak aktif lagi
//     routeObserver.unsubscribe(this);
//     super.dispose();
//   }
//
//   @override
//   void didPopNext() {
//     // Saat user kembali ke halaman ini (via back/forward)
//     debugPrint("🔁 [RouteObserver] Back/Forward ke: ${widget.pageType}");
//     context.read<HomeBloc>().add(_mapPageTypeToEvent(widget.pageType));
//   }
//
//   HomeEvent _mapPageTypeToEvent(PageType type) {
//     switch (type) {
//       case PageType.home:
//         return HomePageActiveEvent();
//       case PageType.profile:
//         return ProfilePageActiveEvent();
//       case PageType.profileindividu:
//         return ProfileIndividuPageActiveEvent();
//       case PageType.profileperusahaan:
//         return ProfilePerusahaanPageActiveEvent();
//       case PageType.roomchat:
//         return RoomCariPageActiveEvent();
//       case PageType.groupchat:
//         return StartChatPageActiveEvent();
//       case PageType.changepswd:
//         return ChangePasswordPageActiveEvent();
//       case PageType.klaimtrack:
//         return TrackKlaimPageActiveEvent();
//       case PageType.splash:
//         return SplashPageActiveEvent();
//       case PageType.article1:
//         return Article1PageActiveEvent();
//       case PageType.testprofile:
//         return TestProfilePageActiveEvent();
//       case PageType.about:
//         return AboutPageActiveEvent();
//       case PageType.activeassets:
//         return ActiveAssetsPageActiveEvent();
//       case PageType.article:
//         return ArticlePageActiveEvent();
//       case PageType.assetsmanagement:
//         return AssetsManagementPageActiveEvent();
//       case PageType.polismanagement:
//         return PolisManagementPageActiveEvent();
//       case PageType.findinsurance:
//         return FindInsurancePageActiveEvent();
//       case PageType.testimony:
//         return TestimonyPageActiveEvent();
//       case PageType.cs:
//         return CsPageActiveEvent();
//       case PageType.usernonjps:
//         return UserNonJPSPageActiveEvent();
//       case PageType.userjps:
//         return UserJPSPageActiveEvent();
//       case PageType.loadinghero:
//         return LoadingHeroPageActiveEvent();
//       case PageType.loadinghero2:
//         return LoadingHero2PageActiveEvent();
//       case PageType.loadingherouser:
//         return LoadingHeroUserPageActiveEvent();
//       case PageType.cobcari:
//         return CobCariPageActiveEvent();
//       case PageType.asetdashboard:
//         return AsetDashboardPageActiveEvent();
//       case PageType.asetpar:
//         return AsetParPageActiveEvent();
//       case PageType.asetmv:
//         return AsetMVPageActiveEvent();
//       case PageType.asetringkasan:
//         return AsetRingkasanPageActiveEvent();
//       case PageType.asethealth:
//         return AsetHealthPageActiveEvent();
//       case PageType.asetstatus:
//         return AsetStatusPageActiveEvent();
//       case PageType.aset:
//         return AsetPageActiveEvent();
//       case PageType.review:
//         return ReviewCariPageActiveEvent();
//       case PageType.berita:
//         return BeritaPageActiveEvent();
//       case PageType.beritasampingan:
//         return BeritaSampinganPageActiveEvent();
//       case PageType.beritaartikel:
//         return BeritaArtikelPageActiveEvent();
//       default:
//         return HomePageActiveEvent();
//     }
//   }
//
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     backgroundColor: AppColors.background,
//   //     drawer: const AppMenu(),
//   //     appBar: AppBar(title: Text(_pageTitle)),
//   //     body: Padding(
//   //       padding: EdgeInsets.all(Spacing.matGridUnit()),
//   //       child: _buildBody(context),
//   //     ),
//   //   );
//   // }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   return _buildBody(context);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     final body = _buildBody(context);
//
//     if (kIsWeb) {
//       return body; // Jangan bungkus dengan FloatingChatWrapper
//     } else {
//       return FloatingChatWrapper(child: body);
//     }
//   }
//
//   String get _pageTitle {
//     switch (widget.pageType) {
//       case PageType.profile:
//         return "Profile";
//       case PageType.roomchat:
//         return "Chat Support";
//       case PageType.changepswd:
//         return "Change Password";
//       case PageType.simulmv:
//         return "Calc. Premi MV";
//       case PageType.simulpar:
//         return "Calc. Premi PAR";
//       case PageType.simulflexas:
//         return "Calc. Premi FLEXAS";
//       case PageType.simuleei:
//         return "Calc. Premi EEI";
//       case PageType.simulgit:
//         return "Calc. Premi GIT";
//       case PageType.simulgis:
//         return "Calc. Premi GIS";
//       case PageType.simulcargo:
//         return "Calc. Premi CARGO";
//       case PageType.simulbon:
//         return "Calc. Premi BON";
//       case PageType.simulwp:
//         return "Calc. Premi WP";
//       case PageType.simulcar:
//         return "Calc. Premi CAR";
//       case PageType.simulmb:
//         return "Calc. Premi MB";
//       case PageType.simultree:
//         return "Calc. Premi TREE";
//       case PageType.klaimtrack:
//         return "Lacak Klaim";
//       case PageType.startchat:
//         return "Start Chat";
//       case PageType.splash:
//         return "Splash";
//       case PageType.profileindividu:
//         return "Profile Individu";
//       case PageType.profileperusahaan:
//         return "Profile Perusahaan";
//       case PageType.article1:
//         return "Artikel Detail";
//       case PageType.testprofile:
//         return "Test Profile";
//       case PageType.about:
//         return "Tentang Kami";
//       case PageType.activeassets:
//         return "Polis Aktif";
//       case PageType.article:
//         return "Artikel";
//       case PageType.assetsmanagement:
//         return "Manajemen Aset";
//       case PageType.polismanagement:
//         return "Manajemen Polis";
//       case PageType.findinsurance:
//         return "Cari Asuransi";
//       case PageType.testimony:
//         return "Testimoni";
//       case PageType.cs:
//         return "Customer Service";
//       case PageType.usernonjps:
//         return "User Non-JPS";
//       case PageType.userjps:
//         return "User JPS";
//       case PageType.loadinghero:
//         return "Memuat Hero";
//       case PageType.loadinghero2:
//         return "Memuat Hero2";
//       case PageType.loadingherouser:
//         return "Memuat Hero User";
//       case PageType.cobcari:
//         return "Memuat Cob Cari";
//       case PageType.asetdashboard:
//         return "Memuat Aset Dashboard";
//       case PageType.asethealth:
//         return "Memuat Aset Health";
//       case PageType.aset:
//         return "Memuat Aset";
//       case PageType.review:
//         return "Memuat Review";
//       case PageType.berita:
//         return "Memuat Berita";
//       case PageType.beritasampingan:
//         return "Memuat Berita Sampingan";
//       case PageType.beritaartikel:
//         return "Memuat Berita Artikel";
//       default:
//         return "Login Page";
//     }
//   }
//
//   Widget _buildBody(BuildContext context) {
//     // debugPrint("🏗 Membangun body untuk: ${widget.pageType}");
//     switch (widget.pageType) {
//       case PageType.home:
//         return const HeroMain();
//       case PageType.groupchat:
//         return const ChatPage(roomId: "support");
//       case PageType.roomchat:
//         return const RoomCariPage();
//       case PageType.changepswd:
//         return const ChangePswdMainPage();
//       case PageType.klaimtrack:
//         return const Klaim1ListMainPage();
//       case PageType.splash:
//         return const SplashPage();
//       case PageType.profileindividu:
//         final userId = int.tryParse(Uri.base.queryParameters['userid'] ?? '') ?? 0;
//         return ProfileMainPage(userid: userId, selectedChoice: 'Individu');
//       case PageType.profileperusahaan:
//         final userId = int.tryParse(Uri.base.queryParameters['userid'] ?? '') ?? 0;
//         return ProfileMainPage(userid: userId, selectedChoice: 'Perusahaan');
//       case PageType.article1:
//         debugPrint('Navigating to ArticleDetailMain (PageType: article1)');
//         return const ArticleDetailMain();
//       case PageType.testprofile:
//         return const TestProfileMain();
//       case PageType.about:
//         debugPrint("🟢 AboutMain dibuild");
//         return const AboutPage();
//       case PageType.article:
//         debugPrint('Navigating to ArticleMain (PageType: article)');
//         return const ArticleMain();
//       case PageType.assetsmanagement:
//         return const AssetManagementMain();
//       case PageType.polismanagement:
//         return const PolisManagementMain();
//       case PageType.findinsurance:
//         return const FindInsuranceMain();
//       case PageType.testimony:
//         return const TestimonyMain();
//       case PageType.cs:
//         return const CSMain();
//       case PageType.usernonjps:
//         return const UserNonJpsMain();
//       case PageType.userjps:
//         return const UserJpsMain();
//       case PageType.loadinghero:
//         return const LoadingUserPage();
//       case PageType.loadinghero2:
//         return const LoadingUser2Page();
//       case PageType.loadingherouser:
//         return const LoadingClientPage();
//       case PageType.cobcari:
//         return const CobCariMainPage();
//       case PageType.asetdashboard:
//         return const AsetDashboardCariMainPage();
//       case PageType.asetpar:
//         return const AsetParCariMainPage();
//       case PageType.asetmv:
//         return const AsetMVCariMainPage();
//       case PageType.asetringkasan:
//         return const AsetRingkasanCariMainPage();
//       case PageType.asethealth:
//         return const AsetHealthCariMainPage();
//       case PageType.asetstatus:
//         return const StatusasetcariMain();
//       case PageType.aset:
//         return const AsetMainPage();
//       case PageType.review:
//         return const ReviewCariMainPage();
//       default:
//         return const SizedBox();
//     }
//   }
//
//   @override
//   Widget get background => Container();
//
//   @override
//   Color get backgroundColor => AppColors.background;
//
//   @override
//   PageType? get parentModal => null;
// }
//

import 'package:eassist_tools_app/pages/aset/aset_main.dart';
import 'package:eassist_tools_app/pages/chatting/roomcari_list.dart';
import 'package:eassist_tools_app/pages/gen_aset_health/asethealthcari_main.dart';
import 'package:eassist_tools_app/pages/groupchat/groupchat_page.dart';
import 'package:eassist_tools_app/pages/home/home_page.dart';
import 'package:eassist_tools_app/menu/app_menu_drawer.dart';
import 'package:eassist_tools_app/pages/base/base_page.dart';
import 'package:eassist_tools_app/common/styles.dart';
import 'package:eassist_tools_app/pages/klaim/klaim1list_main.dart';
import 'package:eassist_tools_app/pages/login/change_pswd_main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:eassist_tools_app/pages/profile/profile_main_page.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import '../../blocs/home/home_bloc.dart';
import '../../widgets/account/profile/profile_main_page.dart';
import '../about_jps/about_main.dart';
import '../active_assets/active_assets_main.dart';
import '../article_page/article_detail.dart';
import '../article_page/article_main.dart';
import '../customer_service/cs_main.dart';
import '../find_insurance/find_insurance_main.dart';
import '../gen_aset_dashboard/asetdashboardcari_list.dart';
import '../gen_aset_dashboard/asetdashboardcari_main.dart';
import '../gen_aset_mv/asetmvcari_main.dart';
import '../gen_aset_par/asetparcari_list.dart';
import '../gen_aset_par/asetparcari_main.dart';
import '../gen_aset_ringkasan/asetringkasancari_main.dart';
import '../gen_berita/berita_main.dart';

import '../gen_cob_app/cobcari_main.dart';
import '../gen_profile/test_profile_main.dart';
import '../gen_review/reviewcari_main.dart';
import '../gen_status_aset/statusasetcari_main.dart';
import '../hero_client_page/hero_user_main.dart';
import '../heropage/hero_main.dart';
import '../home/home_redirector_page.dart';
import '../loading/loading_user2_page.dart';
import '../qontak/floating_chat_wrapper.dart';
import '../loading/loading_client_page.dart';
import '../loading/loading_user_page.dart';
import '../splash/splash_page.dart';
import '../management_asset/management_asset_main.dart';
import '../management_polis/management_polis_main.dart';
import '../testimony_page/testimony_main.dart';
import '../user_jps/user_jps_main.dart';
import '../user_non_jps/user_non_jps_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageContainerWithUserRepository extends PageContainerBase {
  final int userid;
  final UserRepository userRepository;
  final PageType pageType;

  const PageContainerWithUserRepository(
      {required super.key,
        required this.userid,
        required this.userRepository,
        required this.pageType});

  @override
  Widget get menuDrawer {
    return const AppMenu();
  }

  @override
  String get pageTitle {
    //debugPrint("PageContainerWithUserRepository -> pageTitle");
    switch (pageType) {
      case PageType.profile:
        return "Profile";
      default:
        return "Login Page";
    }
  }

  @override
  Widget get body {
    Widget? page;
    //debugPrint("PageContainerWithUserRepository -> body");
    switch (pageType) {
      case PageType.home:
        page = HomePage(
          userid: userid,
          userRepository: userRepository,
          key: null,
        );
        break;
    // case PageType.profile:
    //   page = ProfileMainPage(
    //     userid: userid,
    //     userRepository: userRepository,
    //   );
    //   break;
      default:
        page = null;
    }
    return Padding(
      padding: EdgeInsets.all(Spacing.matGridUnit()),
      child: page,
    );
  }

  @override
  Widget get background => Container();

  @override
  Color get backgroundColor => AppColors.background;

  @override
  PageType? get parentModal => null;
}

class PageContainer extends StatelessWidget {
  final PageType pageType;
  final String? recId;

  const PageContainer({super.key, required this.pageType, this.recId});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: AppColors.background,
  //     drawer: const AppMenu(),
  //     appBar: AppBar(title: Text(_pageTitle)),
  //     body: Padding(
  //       padding: EdgeInsets.all(Spacing.matGridUnit()),
  //       child: _buildBody(context),
  //     ),
  //   );
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return _buildBody(context);
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   final body = _buildBody(context);
  //
  //   if (kIsWeb) {
  //     return body; // Jangan bungkus dengan FloatingChatWrapper
  //   } else {
  //     return FloatingChatWrapper(child: body);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    final body = _buildBody(context);

    final child = WillPopScope(
      onWillPop: () async {
        if (bloc.canGoBack) {
          bloc.add(PopPageEvent()); // pop stack
          return false; // cegah navigator asli
        }
        return true; // izinkan keluar app/browser
      },
      child: body,
    );

    if (kIsWeb) {
      return child; // tanpa FloatingChatWrapper
    } else {
      return FloatingChatWrapper(child: child);
    }
  }

  String get _pageTitle {
    switch (pageType) {
      case PageType.profile:
        return "Profile";
      case PageType.roomchat:
        return "Chat Support";
      case PageType.changepswd:
        return "Change Password";
      case PageType.simulmv:
        return "Calc. Premi MV";
      case PageType.simulpar:
        return "Calc. Premi PAR";
      case PageType.simulflexas:
        return "Calc. Premi FLEXAS";
      case PageType.simuleei:
        return "Calc. Premi EEI";
      case PageType.simulgit:
        return "Calc. Premi GIT";
      case PageType.simulgis:
        return "Calc. Premi GIS";
      case PageType.simulcargo:
        return "Calc. Premi CARGO";
      case PageType.simulbon:
        return "Calc. Premi BON";
      case PageType.simulwp:
        return "Calc. Premi WP";
      case PageType.simulcar:
        return "Calc. Premi CAR";
      case PageType.simulmb:
        return "Calc. Premi MB";
      case PageType.simultree:
        return "Calc. Premi TREE";
      case PageType.klaimtrack:
        return "Lacak Klaim";
      case PageType.startchat:
        return "Start Chat";
      case PageType.splash:
        return "Splash";
      case PageType.profileindividu:
        return "Profile Individu";
      case PageType.profileperusahaan:
        return "Profile Perusahaan";
      case PageType.article1:
        return "Artikel Detail";
      case PageType.testprofile:
        return "Test Profile";
      case PageType.about:
        return "Tentang Kami";
      case PageType.activeassets:
        return "Polis Aktif";
      case PageType.article:
        return "Artikel";
      case PageType.assetsmanagement:
        return "Manajemen Aset";
      case PageType.polismanagement:
        return "Manajemen Polis";
      case PageType.findinsurance:
        return "Cari Asuransi";
      // case PageType.herouser:
      //   return "Halaman Utama User";
      // case PageType.hero:
      //   return "Halaman Utama";
      case PageType.testimony:
        return "Testimoni";
      case PageType.cs:
        return "Customer Service";
      case PageType.usernonjps:
        return "User Non-JPS";
      case PageType.userjps:
        return "User JPS";
      case PageType.loadinghero:
        return "Memuat Hero";
      case PageType.loadinghero2:
        return "Memuat Hero2";
      case PageType.loadingherouser:
        return "Memuat Hero User";
      case PageType.cobcari:
        return "Memuat Cob Cari";
      case PageType.asetdashboard:
        return "Memuat Aset Dashboard";
      case PageType.asethealth:
        return "Memuat Aset Health";
      case PageType.aset:
        return "Memuat Aset";
      case PageType.review:
        return "Memuat Review";
      case PageType.berita:
        return "Memuat Berita";
      case PageType.beritasampingan:
        return "Memuat Berita Sampingan";
      case PageType.beritaartikel:
        return "Memuat Berita Artikel";
      default:
        return "Login Page";
    }
  }

  Widget _buildBody(BuildContext context) {
    // debugPrint("🏗 Membangun body untuk: $pageType");
    switch (pageType) {
      case PageType.home:
        return const HeroMain();
      case PageType.groupchat:
        return const ChatPage(roomId: "support");
      case PageType.roomchat:
        return const RoomCariPage();
      case PageType.changepswd:
        return const ChangePswdMainPage();
      case PageType.klaimtrack:
        return const Klaim1ListMainPage();
      case PageType.splash:
        return const SplashPage();
      case PageType.profileindividu:
        final userId = int.tryParse(Uri.base.queryParameters['userid'] ?? '') ?? 0;

        return ProfileMainPage(
          userid: userId,
          selectedChoice: 'Individu',
        );

      case PageType.profileperusahaan:
        final userId = int.tryParse(Uri.base.queryParameters['userid'] ?? '') ?? 0;

        return ProfileMainPage(
          userid: userId,
          selectedChoice: 'Perusahaan',
        );
      case PageType.article1:
        return const ArticleDetailMain();
      case PageType.testprofile:
        return const TestProfileMain();
      case PageType.about:
        debugPrint("🟢 AboutMain dibuild");
        return const AboutPage();
      case PageType.article:
        return const ArticleMain();
      case PageType.assetsmanagement:
        return const AssetManagementMain();
      case PageType.polismanagement:
        return const PolisManagementMain();
      case PageType.findinsurance:
        return const FindInsuranceMain();
      case PageType.testimony:
        return const TestimonyMain();
      case PageType.cs:
        return const CSMain();
      case PageType.usernonjps:
        return const UserNonJpsMain();
      case PageType.userjps:
        return const UserJpsMain();
      case PageType.loadinghero:
        return const LoadingUserPage();
      case PageType.loadinghero2:
        return const LoadingUser2Page();
      case PageType.loadingherouser:
        return const LoadingClientPage();
      case PageType.cobcari:
        return const CobCariMainPage();
      case PageType.asetdashboard:
        return const AsetDashboardCariMainPage();
      case PageType.asetpar:
        return const AsetParCariMainPage();
      case PageType.asetmv:
        return const AsetMVCariMainPage();
      case PageType.asetringkasan:
        return const AsetRingkasanCariMainPage();
      case PageType.asethealth:
        return const AsetHealthCariMainPage();
      case PageType.asetstatus:
        return const StatusasetcariMain();
      case PageType.aset:
        return const AsetMainPage();
      case PageType.review:
        return const ReviewCariMainPage();
      case PageType.berita:
        return const BeritaMainPage(jenis: 1);
      // case PageType.beritaartikel:
      //   return const BeritaArtikelMainPage(jenis: 2);
      default:
        return const SizedBox();
    }
  }

  @override
  Widget get background => Container();

  @override
  Color get backgroundColor => AppColors.background;

  @override
  PageType? get parentModal => null;
}
