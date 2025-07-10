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
    if (state is HeroUserPageActive) return PageType.herouser;
    if (state is HeroPageActive) return PageType.hero;
    if (state is TestimonyPageActive) return PageType.testimony;
    if (state is CsPageActive) return PageType.cs;
    if (state is UserNonJPSPageActive) return PageType.usernonjps;
    if (state is UserJPSPageActive) return PageType.userjps;
    if (state is LoadingHeroPageActive) return PageType.loadinghero;
    if (state is LoadingHero2PageActive) return PageType.loadinghero2;
    if (state is LoadingHeroUserPageActive) return PageType.loadingherouser;
    if (state is CobCariPageActive) return PageType.cobcari;
    if (state is AsetDashboardPageActive) return PageType.asetdashboard;

    return null;
  }
}
