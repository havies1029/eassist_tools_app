import 'package:eassist_tools_app/pages/chatting/roomcari_list.dart';
import 'package:eassist_tools_app/pages/groupchat/groupchat_page.dart';
import 'package:eassist_tools_app/pages/home/home_page.dart';
import 'package:eassist_tools_app/menu/app_menu_drawer.dart';
import 'package:eassist_tools_app/pages/base/base_page.dart';
import 'package:eassist_tools_app/common/styles.dart';
import 'package:eassist_tools_app/pages/klaim/klaim1list_main.dart';
import 'package:eassist_tools_app/pages/login/change_pswd_main.dart';
import 'package:eassist_tools_app/pages/simulbon/simulboncrud_main.dart';
import 'package:eassist_tools_app/pages/simuleei/simuleeicrud_main.dart';
import 'package:eassist_tools_app/pages/simulgis/simulgiscrud_main.dart';
import 'package:eassist_tools_app/pages/simulgit/simulgitcrud_main.dart';
import 'package:eassist_tools_app/pages/simulmv/simulmvcrud_main.dart';
import 'package:eassist_tools_app/pages/simulpar/simulparcrud_main.dart';
import 'package:eassist_tools_app/pages/simulwp/simulwpcrud_main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:eassist_tools_app/pages/profile/profile_main_page.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';
import '../../blocs/authentication/authentication_bloc.dart';
import '../../widgets/account/profile/profile_main_page.dart';
import '../about_jps/about_main.dart';
import '../active_assets/active_assets_main.dart';
import '../article_page/article_detail.dart';
import '../article_page/article_main.dart';
import '../customer_service/cs_main.dart';
import '../find_insurance/find_insurance_main.dart';
import '../gen_profile/test_profile_main.dart';
import '../hero_client_page/hero_user_main.dart';
import '../heropage/hero_main.dart';
import '../home/home_redirector_page.dart';
import '../qontak/floating_chat_wrapper.dart';
import '../simulcar/simulcarcrud_main.dart';
import '../simulcargo/simulcargocrud_main.dart';
import '../simulmb/simulmbcrud_main.dart';
import '../simultree/simultreecrud_main.dart';
import '../splash/loading_client_page.dart';
import '../splash/loading_user_page.dart';
import '../splash/splash_page.dart';
import '../summary_polis_assets/assets_management_main.dart';
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

  @override
  Widget build(BuildContext context) {
    final body = _buildBody(context);

    if (kIsWeb) {
      return body; // Jangan bungkus dengan FloatingChatWrapper
    } else {
      return FloatingChatWrapper(child: body);
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
      case PageType.findinsurance:
        return "Cari Asuransi";
      case PageType.herouser:
        return "Halaman Utama User";
      case PageType.hero:
        return "Halaman Utama";
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
      case PageType.loadingherouser:
        return "Memuat Hero User";
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
      case PageType.simulmv:
        return const SimulmvCrudMainPage();
      case PageType.simulpar:
        return const SimulparCrudMainPage(usage: 'PAREQ');
      case PageType.simulflexas:
        return const SimulparCrudMainPage(usage: 'FLEXAS');
      case PageType.simuleei:
        return const SimuleeiCrudMainPage();
      case PageType.simulgit:
        return const SimulgitCrudMainPage();
      case PageType.simulgis:
        return const SimulgisCrudMainPage();
      case PageType.simulbon:
        return const SimulbonCrudMainPage();
      case PageType.simulwp:
        return const SimulwpCrudMainPage();
      case PageType.simulcargo:
        return const SimulcargoCrudMainPage();
      case PageType.simulcar:
        return const SimulcarCrudMainPage();
      case PageType.simulmb:
        return const SimulmbCrudMainPage();
      case PageType.simultree:
        return const SimultreeCrudMainPage();
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
      case PageType.activeassets:
        return const ActiveAssetPage();
      case PageType.article:
        return const ArticleMain();
      case PageType.assetsmanagement:
        return const AssetsManagementMain();
      case PageType.findinsurance:
        return const FindInsuranceMain();
      case PageType.herouser:
        return const HeroUserMain();
      case PageType.hero:
        return const HeroMain();
      case PageType.testimony:
        return const TestimonyMain();
      case PageType.cs:
        return const CSMain();
      case PageType.usernonjps:
        return const UserNonJpsMain();
      case PageType.userjps:
        return const UserJpsMain();
      case PageType.loadinghero:
        return const LoadingClientPage();
      case PageType.loadingherouser:
        return const LoadingUserPage();
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
