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
      child: BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (prev, curr) => false, // tidak ada side-effect khusus
        listener: (context, state) {},
        buildWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
        builder: (context, state) {
          // Tentukan pageType dari state
          if (state is ProfilePageActive) {
            return PageContainerWithUserRepository(
              key: const ValueKey('profile'),
              pageType: PageType.profile,
              userRepository: widget.userRepository,
              userid: widget.userid,
            );
          }

          final pageType = _getPageTypeFromState(state) ?? PageType.home;

          return PageContainer(
            key: ValueKey<PageType>(pageType), // penting agar subtree berganti
            pageType: pageType,
          );
        },
      ),
    );
  }
// 1) Definisikan sekali (global / static)
  final Map<Type, PageType> _stateToPage = {
    HomePageActive: PageType.home,
    RoomCariPageActive: PageType.roomchat,
    ChangePasswordPageActive: PageType.changepswd,
    SimulMVPageActive: PageType.simulmv,
    SimulPARPageActive: PageType.simulpar,
    SimulFlexasPageActive: PageType.simulflexas,
    SimulEEIPageActive: PageType.simuleei,
    SimulGITPageActive: PageType.simulgit,
    SimulGISPageActive: PageType.simulgis,
    SimulBONPageActive: PageType.simulbon,
    SimulWPPageActive: PageType.simulwp,
    SimulCARGOPageActive: PageType.simulcargo,
    SimulCARPageActive: PageType.simulcar,
    SimulMBPageActive: PageType.simulmb,
    SimulTREEPageActive: PageType.simultree,
    TrackKlaimPageActive: PageType.klaimtrack,
    StartChatPageActive: PageType.startchat,
    SplashPageActive: PageType.splash,
    ProfileIndividuPageActive: PageType.profileindividu,
    ProfilePerusahaanPageActive: PageType.profileperusahaan,
    Article1PageActive: PageType.article1,
    TestProfilePageActive: PageType.testprofile,
    AboutPageActive: PageType.about,
    ActiveAssetsPageActive: PageType.activeassets,
    ArticlePageActive: PageType.article,
    AssetsManagementPageActive: PageType.assetsmanagement,
    PolisManagementPageActive: PageType.polismanagement,
    FindInsurancePageActive: PageType.findinsurance,
    TestimonyPageActive: PageType.testimony,
    CsPageActive: PageType.cs,
    UserNonJPSPageActive: PageType.usernonjps,
    UserJPSPageActive: PageType.userjps,
    LoadingHeroPageActive: PageType.loadinghero,
    LoadingHero2PageActive: PageType.loadinghero2,
    LoadingHeroUserPageActive: PageType.loadingherouser,
    CobCariPageActive: PageType.cobcari,
    AsetDashboardPageActive: PageType.asetdashboard,
    AsetParPageActive: PageType.asetpar,
    AsetMVPageActive: PageType.asetmv,
    AsetRingkasanPageActive: PageType.asetringkasan,
    AsetHealthPageActive: PageType.asethealth,
    AsetStatusPageActive: PageType.asetstatus,
    AsetPageActive: PageType.aset,
    ReviewCariPageActive: PageType.review,
    BeritaPageActive: PageType.berita,
    BeritaSampinganPageActive: PageType.beritasampingan,
    BeritaArtikelPageActive: PageType.beritaartikel,
    SppamvPageActive: PageType.sppamv,
    SppaparPageActive: PageType.sppapar,
  };

// 2) Fungsi jadi ringkas
  PageType? _getPageTypeFromState(HomeState state) {
    return _stateToPage[state.runtimeType];
  }
}
