import 'package:eassist_tools_app/pages/chatting/roomcari_list.dart';
import 'package:eassist_tools_app/pages/find_insurance/find_insurance_main.dart';
import 'package:eassist_tools_app/pages/groupchat/groupchat_page.dart';
import 'package:eassist_tools_app/pages/hero_user_page/hero_user_main.dart';
import 'package:eassist_tools_app/pages/heropage/hero_main.dart';
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
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/profile/profile_main_page.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';

import '../about_jps/about_main.dart';
import '../simulcar/simulcarcrud_main.dart';
import '../simulcargo/simulcargocrud_main.dart';
import '../simulmb/simulmbcrud_main.dart';
import '../simultree/simultreecrud_main.dart';

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
      case PageType.profile:
        page = ProfileMainPage(
          userid: userid,
          userRepository: userRepository,
        );
        break;
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

class PageContainer extends PageContainerBase {
  final PageType pageType;
  final String? recId;

  const PageContainer({super.key, required this.pageType, this.recId});

  @override
  Widget get menuDrawer {
    return const AppMenu();
  }

  @override
  String get pageTitle {
    switch (pageType) {
      case PageType.home:
        return "";
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
      default:
        return "Login Page";
    }
  }

  @override
  Widget get body {
    Widget? page;

    switch (pageType) {
      case PageType.home:
        page = const HeroMain();
        break;
      case PageType.groupchat:
        page = const ChatPage(roomId: "support");
        break;
      case PageType.roomchat:
        page = const RoomCariPage();
        break;
      case PageType.changepswd:
        page = const ChangePswdMainPage();
        break;
      case PageType.simulmv:
        page = const SimulmvCrudMainPage();
        break;
      case PageType.simulpar:
        page = const SimulparCrudMainPage(usage: 'PAREQ',);
        break;
      case PageType.simulflexas:
        page = const SimulparCrudMainPage(usage: 'FLEXAS',);
        break;
      case PageType.simuleei:
        page = const SimuleeiCrudMainPage();
        break;
      case PageType.simulgit:
        page = const SimulgitCrudMainPage();
        break;
      case PageType.simulgis:
        // page = const SimulgisCrudMainPage(viewMode: "", recordId: "",);
        page = const SimulgisCrudMainPage();
        break;
      case PageType.simulbon:
        page = const SimulbonCrudMainPage();
        break;
      case PageType.simulwp:
        page = const SimulwpCrudMainPage();
      case PageType.simulcargo:
        page = const SimulcargoCrudMainPage();
        break;
      case PageType.simulcar:
        page = const SimulcarCrudMainPage();
        break;
      case PageType.simulmb:
        page = const SimulmbCrudMainPage();
        break;
      case PageType.simultree:
        page = const SimultreeCrudMainPage();
        break;
      case PageType.klaimtrack:
        page = const Klaim1ListMainPage();
        break;
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
