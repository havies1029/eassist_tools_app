import 'package:eassist_tools_app/pages/chatting/roomcari_list.dart';
import 'package:eassist_tools_app/pages/groupchat/groupchat_page.dart';
import 'package:eassist_tools_app/pages/home/home_page.dart';
import 'package:eassist_tools_app/menu/app_menu_drawer.dart';
import 'package:eassist_tools_app/pages/base/base_page.dart';
import 'package:eassist_tools_app/common/styles.dart';
import 'package:eassist_tools_app/pages/login/change_pswd_main.dart';
import 'package:eassist_tools_app/pages/simulbon/simulboncrud_main.dart';
import 'package:eassist_tools_app/pages/simuleei/simuleeicrud_main.dart';
import 'package:eassist_tools_app/pages/simulgis/simulgiscrud_main.dart';
import 'package:eassist_tools_app/pages/simulgit/simulgitcrud_main.dart';
import 'package:eassist_tools_app/pages/simulmv/simulmvcrud_form_casco.dart';
import 'package:eassist_tools_app/pages/simulmv/simulmvcrud_main.dart';
import 'package:eassist_tools_app/pages/simulpar/simulparcrud_main.dart';
import 'package:eassist_tools_app/pages/simulgis/simulgiscrud_form.dart';
import 'package:eassist_tools_app/pages/dashboard/dashboard_main.dart';
import 'package:eassist_tools_app/pages/simulwp/simulwpcrud_main.dart';
import 'package:flutter/material.dart';
import 'package:eassist_tools_app/pages/profile/profile_main_page.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';

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
      case PageType.simuleei:
        return "Calc. Premi EEI";
      case PageType.simulgit:
        return "Calc. Premi GIT";
          case PageType.simulgis:
        return "Calc. Premi GIS";
      default:
        return "Login Page";
    }
  }

  @override
  Widget get body {
    Widget? page;

    switch (pageType) {
      case PageType.home:
        page = const DashboardMain();
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
        page = const SimulparCrudMainPage();
        break;
      case PageType.simuleei:
        page = const SimuleeiCrudMainPage();
        break;
      case PageType.simulgit:
        page = const SimulgitCrudMainPage();
        break;
      case PageType.simulgis:
        page = const SimulgisCrudMainPage(viewMode: "", recordId: "",);
        break;
      case PageType.simulbon:
        page = const SimulbonCrudMainPage(viewMode: "", recordId: "",);
        break;
      case PageType.simulwp:
        page = const SimulwpCrudMainPage(viewMode: "", recordId: "",);
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
