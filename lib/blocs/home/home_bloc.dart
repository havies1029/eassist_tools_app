// import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:hydrated_bloc/hydrated_bloc.dart';
//
// part 'home_state.dart';
// part 'home_event.dart';
//
// class HomeBloc extends HydratedBloc<HomeEvent, HomeState> {
//   HomeBloc() : super(HomePageActive()) {
//     on<HomePageActiveEvent>((event, emit) => emit(HomePageActive()));
//     on<ProfilePageActiveEvent>((event, emit) => emit(ProfilePageActive()));
//     on<RoomCariPageActiveEvent>((event, emit) => emit(RoomCariPageActive()));
//     on<ChatSupportPageActiveEvent>((event, emit) => emit(ChatSupportPageActive()));
//     on<ChangePasswordPageActiveEvent>((event, emit) => emit(ChangePasswordPageActive()));
//     on<SimulMVPageActiveEvent>((event, emit) => emit(SimulMVPageActive()));
//     on<SimulPARPageActiveEvent>((event, emit) => emit(SimulPARPageActive()));
//     on<SimulEEIPageActiveEvent>((event, emit) => emit(SimulEEIPageActive()));
//     on<SimulGITPageActiveEvent>((event, emit) => emit(SimulGITPageActive()));
//     on<SimulGISPageActiveEvent>((event, emit) => emit(SimulGISPageActive()));
//     on<SimulBONPageActiveEvent>((event, emit) => emit(SimulBONPageActive()));
//     on<SimulWPPageActiveEvent>((event, emit) => emit(SimulWPPageActive()));
//     on<SimulCARGOPageActiveEvent>((event, emit) => emit(SimulCARGOPageActive()));
//     on<SimulFlexasPageActiveEvent>((event, emit) => emit(SimulFlexasPageActive()));
//     on<SimulCARPageActiveEvent>((event, emit) => emit(SimulCARPageActive()));
//     on<SimulMBPageActiveEvent>((event, emit) => emit(SimulMBPageActive()));
//     on<SimulTREEPageActiveEvent>((event, emit) => emit(SimulTREEPageActive()));
//     on<TrackKlaimPageActiveEvent>((event, emit) => emit(TrackKlaimPageActive()));
//     on<StartChatPageActiveEvent>((event, emit) => emit(StartChatPageActive()));
//     on<SplashPageActiveEvent>((event, emit) => emit(SplashPageActive()));
//     on<ProfileIndividuPageActiveEvent>((event, emit) => emit(ProfileIndividuPageActive()));
//     on<ProfilePerusahaanPageActiveEvent>((event, emit) => emit(ProfilePerusahaanPageActive()));
//     on<Article1PageActiveEvent>((event, emit) => emit(Article1PageActive()));
//     on<TestProfilePageActiveEvent>((event, emit) => emit(TestProfilePageActive()));
//     on<AboutPageActiveEvent>((event, emit) {
//       debugPrint("🔥 AboutPageActiveEvent triggered, current state: ${state.runtimeType}");
//       if (state is! AboutPageActive) {
//         emit(AboutPageActive());
//         debugPrint("✅ Emitted AboutPageActive()");
//       } else {
//         debugPrint("⚠️ State already AboutPageActive, no emit needed.");
//       }
//     });
//
//     on<ActiveAssetsPageActiveEvent>((event, emit) => emit(ActiveAssetsPageActive()));
//     on<ArticlePageActiveEvent>((event, emit) => emit(ArticlePageActive()));
//     on<AssetsManagementPageActiveEvent>((event, emit) => emit(AssetsManagementPageActive()));
//     on<PolisManagementPageActiveEvent>((event, emit) => emit(PolisManagementPageActive()));
//     on<FindInsurancePageActiveEvent>((event, emit) => emit(FindInsurancePageActive()));
//     on<HeroUserPageActiveEvent>((event, emit) => emit(HeroUserPageActive()));
//     on<HeroPageActiveEvent>((event, emit) => emit(HeroPageActive()));
//     on<TestimonyPageActiveEvent>((event, emit) => emit(TestimonyPageActive()));
//     on<CsPageActiveEvent>((event, emit) => emit(CsPageActive()));
//     on<UserNonJPSPageActiveEvent>((event, emit) => emit(UserNonJPSPageActive()));
//     on<UserJPSPageActiveEvent>((event, emit) => emit(UserJPSPageActive()));
//     on<LoadingHeroPageActiveEvent>((event, emit) => emit(LoadingHeroPageActive()));
//     on<LoadingHero2PageActiveEvent>((event, emit) => emit(LoadingHero2PageActive()));
//     on<LoadingHeroUserPageActiveEvent>((event, emit) => emit(LoadingHeroUserPageActive()));
//     on<CobCariPageActiveEvent>((event, emit) => emit(CobCariPageActive()));
//     on<AsetDashboardPageActiveEvent>((event, emit) => emit(AsetDashboardPageActive()));
//     on<AsetParPageActiveEvent>((event, emit) => emit(AsetParPageActive()));
//     on<AsetMVPageActiveEvent>((event, emit) => emit(AsetMVPageActive()));
//     on<AsetRingkasanPageActiveEvent>((event, emit) => emit(AsetRingkasanPageActive()));
//     on<AsetHealthPageActiveEvent>((event, emit) => emit(AsetHealthPageActive()));
//     on<AsetStatusPageActiveEvent>((event, emit) => emit(AsetStatusPageActive()));
//     on<AsetPageActiveEvent>((event, emit) => emit(AsetPageActive()));
//     on<ReviewCariPageActiveEvent>((event, emit) => emit(ReviewCariPageActive()));
//     on<BeritaPageActiveEvent>((event, emit) => emit(BeritaPageActive()));
//     on<BeritaSampinganPageActiveEvent>((event, emit) => emit(BeritaSampinganPageActive()));
//     on<BeritaArtikelPageActiveEvent>((event, emit) => emit(BeritaArtikelPageActive()));
//   }
//
//   @override
//   HomeState? fromJson(Map<String, dynamic> json) {
//     final type = json['type'] as String?;
//     debugPrint("💾 fromJson: ${json['type']}");
//     switch (type) {
//       case 'home': return HomePageActive();
//       case 'profile': return ProfilePageActive();
//       case 'roomchat': return RoomCariPageActive();
//       case 'startchat': return StartChatPageActive();
//       case 'changepswd': return ChangePasswordPageActive();
//       case 'simulmv': return SimulMVPageActive();
//       case 'simulpar': return SimulPARPageActive();
//       case 'simuleei': return SimulEEIPageActive();
//       case 'simulgit': return SimulGITPageActive();
//       case 'simulgis': return SimulGISPageActive();
//       case 'simulbon': return SimulBONPageActive();
//       case 'simulwp': return SimulWPPageActive();
//       case 'simulcargo': return SimulCARGOPageActive();
//       case 'simulflexas': return SimulFlexasPageActive();
//       case 'simulcar': return SimulCARPageActive();
//       case 'simulmb': return SimulMBPageActive();
//       case 'simultree': return SimulTREEPageActive();
//       case 'klaimtrack': return TrackKlaimPageActive();
//       case 'splash': return SplashPageActive();
//       case 'profileindividu': return ProfileIndividuPageActive();
//       case 'profileperusahaan': return ProfilePerusahaanPageActive();
//       case 'article1': return Article1PageActive();
//       case 'testprofile': return TestProfilePageActive();
//       case 'about': return AboutPageActive();
//       case 'activeassets': return ActiveAssetsPageActive();
//       case 'article': return ArticlePageActive();
//       case 'assetsmanagement': return AssetsManagementPageActive();
//       case 'polismanagement': return PolisManagementPageActive();
//       case 'findinsurance': return FindInsurancePageActive();
//       case 'herouser': return HeroUserPageActive();
//       case 'hero': return HeroPageActive();
//       case 'testimony': return TestimonyPageActive();
//       case 'cs': return CsPageActive();
//       case 'usernonjps': return UserNonJPSPageActive();
//       case 'userjps': return UserJPSPageActive();
//       case 'loadinghero': return LoadingHeroPageActive();
//       case 'loadinghero2': return LoadingHero2PageActive();
//       case 'loadingherouser': return LoadingHeroUserPageActive();
//       case 'cobcari': return CobCariPageActive();
//       case 'asetdashboard': return AsetDashboardPageActive();
//       case 'asetpar': return AsetParPageActive();
//       case 'asetmv': return AsetMVPageActive();
//       case 'asetringkasan': return AsetRingkasanPageActive();
//       case 'asethealth': return AsetHealthPageActive();
//       case 'asetstatus': return AsetStatusPageActive();
//       case 'aset': return AsetPageActive();
//       case 'review': return ReviewCariPageActive();
//       case 'berita': return BeritaPageActive();
//       case 'beritasampingan': return BeritaSampinganPageActive();
//       case 'beritaartikel': return BeritaArtikelPageActive();
//       default: return HomePageActive();
//     }
//   }
//
//   @override
//   Map<String, dynamic>? toJson(HomeState state) {
//     debugPrint("📝 toJson: $state");
//     if (state is HomePageActive) return {'type': 'home'};
//     if (state is ProfilePageActive) return {'type': 'profile'};
//     if (state is RoomCariPageActive) return {'type': 'roomchat'};
//     if (state is StartChatPageActive) return {'type': 'startchat'};
//     if (state is ChangePasswordPageActive) return {'type': 'changepswd'};
//     if (state is SimulMVPageActive) return {'type': 'simulmv'};
//     if (state is SimulPARPageActive) return {'type': 'simulpar'};
//     if (state is SimulEEIPageActive) return {'type': 'simuleei'};
//     if (state is SimulGITPageActive) return {'type': 'simulgit'};
//     if (state is SimulGISPageActive) return {'type': 'simulgis'};
//     if (state is SimulBONPageActive) return {'type': 'simulbon'};
//     if (state is SimulWPPageActive) return {'type': 'simulwp'};
//     if (state is SimulCARGOPageActive) return {'type': 'simulcargo'};
//     if (state is SimulFlexasPageActive) return {'type': 'simulflexas'};
//     if (state is SimulCARPageActive) return {'type': 'simulcar'};
//     if (state is SimulMBPageActive) return {'type': 'simulmb'};
//     if (state is SimulTREEPageActive) return {'type': 'simultree'};
//     if (state is TrackKlaimPageActive) return {'type': 'klaimtrack'};
//     if (state is SplashPageActive) return {'type': 'splash'};
//     if (state is ProfileIndividuPageActive) return {'type': 'profileindividu'};
//     if (state is ProfilePerusahaanPageActive) return {'type': 'profileperusahaan'};
//     if (state is Article1PageActive) return {'type': 'article1'};
//     if (state is TestProfilePageActive) return {'type': 'testprofile'};
//     if (state is AboutPageActive) return {'type': 'about'};
//     if (state is ActiveAssetsPageActive) return {'type': 'activeassets'};
//     if (state is ArticlePageActive) return {'type': 'article'};
//     if (state is AssetsManagementPageActive) return {'type': 'assetsmanagement'};
//     if (state is PolisManagementPageActive) return {'type': 'polismanagement'};
//     if (state is FindInsurancePageActive) return {'type': 'findinsurance'};
//     if (state is HeroUserPageActive) return {'type': 'herouser'};
//     if (state is HeroPageActive) return {'type': 'hero'};
//     if (state is TestimonyPageActive) return {'type': 'testimony'};
//     if (state is CsPageActive) return {'type': 'cs'};
//     if (state is UserNonJPSPageActive) return {'type': 'usernonjps'};
//     if (state is UserJPSPageActive) return {'type': 'userjps'};
//     if (state is LoadingHeroPageActive) return {'type': 'loadinghero'};
//     if (state is LoadingHero2PageActive) return {'type': 'loadinghero2'};
//     if (state is LoadingHeroUserPageActive) return {'type': 'loadingherouser'};
//     if (state is CobCariPageActive) return {'type': 'cobcari'};
//     if (state is AsetDashboardPageActive) return {'type': 'asetdashboard'};
//     if (state is AsetParPageActive) return {'type': 'asetpar'};
//     if (state is AsetMVPageActive) return {'type': 'asetmv'};
//     if (state is AsetRingkasanPageActive) return {'type': 'asetringkasan'};
//     if (state is AsetHealthPageActive) return {'type': 'asethealth'};
//     if (state is AsetStatusPageActive) return {'type': 'asetstatus'};
//     if (state is AsetPageActive) return {'type': 'aset'};
//     if (state is ReviewCariPageActive) return {'type': 'review'};
//     if (state is BeritaPageActive) return {'type': 'berita'};
//     if (state is BeritaSampinganPageActive) return {'type': 'beritasampingan'};
//     if (state is BeritaArtikelPageActive) return {'type': 'beritaartikel'};
//     return null;
//   }
// }
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/base/base_page.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<PageType> _pageStack;
  bool _hasStartupPush = false;
  bool get hasStartupPush => _hasStartupPush;

  void markStartupPush() => _hasStartupPush = true;

  PageType get currentPage => _pageStack.last;
  bool get canGoBack => _pageStack.length > 1;

  List<PageType> get pageStack => _pageStack;

  HomeBloc({required PageType initialPage})
      : _pageStack = [initialPage],
        super(_mapPageTypeToState(initialPage)) {
    on<HomePageActiveEvent>((event, emit) => emit(HomePageActive()));
    on<ProfilePageActiveEvent>((event, emit) => emit(ProfilePageActive()));
    on<RoomCariPageActiveEvent>((event, emit) => emit(RoomCariPageActive()));
    on<ChatSupportPageActiveEvent>((event, emit) => emit(ChatSupportPageActive()));
    on<ChangePasswordPageActiveEvent>((event, emit) => emit(ChangePasswordPageActive()));
    on<SimulMVPageActiveEvent>((event, emit) => emit(SimulMVPageActive()));
    on<SimulPARPageActiveEvent>((event, emit) => emit(SimulPARPageActive()));
    on<SimulEEIPageActiveEvent>((event, emit) => emit(SimulEEIPageActive()));
    on<SimulGITPageActiveEvent>((event, emit) => emit(SimulGITPageActive()));
    on<SimulGISPageActiveEvent>((event, emit) => emit(SimulGISPageActive()));
    on<SimulBONPageActiveEvent>((event, emit) => emit(SimulBONPageActive()));
    on<SimulWPPageActiveEvent>((event, emit) => emit(SimulWPPageActive()));
    on<SimulCARGOPageActiveEvent>((event, emit) => emit(SimulCARGOPageActive()));
    on<SimulFlexasPageActiveEvent>((event, emit) => emit(SimulFlexasPageActive()));
    on<SimulCARPageActiveEvent>((event, emit) => emit(SimulCARPageActive()));
    on<SimulMBPageActiveEvent>((event, emit) => emit(SimulMBPageActive()));
    on<SimulTREEPageActiveEvent>((event, emit) => emit(SimulTREEPageActive()));
    on<TrackKlaimPageActiveEvent>((event, emit) => emit(TrackKlaimPageActive()));
    on<StartChatPageActiveEvent>((event, emit) => emit(StartChatPageActive()));
    on<SplashPageActiveEvent>((event, emit) => emit(SplashPageActive()));
    on<ProfileIndividuPageActiveEvent>((event, emit) => emit(ProfileIndividuPageActive()));
    on<ProfilePerusahaanPageActiveEvent>((event, emit) => emit(ProfilePerusahaanPageActive()));
    on<Article1PageActiveEvent>((event, emit) {
      debugPrint("🖍 Event Article1PageActiveEvent diterima, emit state: Article1PageActive");
      emit(Article1PageActive());
    });
    on<TestProfilePageActiveEvent>((event, emit) => emit(TestProfilePageActive()));
    on<AboutPageActiveEvent>((event, emit) {
      if (state is! AboutPageActive) {
        emit(AboutPageActive());
      }
    });
    on<ActiveAssetsPageActiveEvent>((event, emit) => emit(ActiveAssetsPageActive()));
    on<ArticlePageActiveEvent>((event, emit) {
      debugPrint("📰 Event ArticlePageActiveEvent diterima, emit state: ArticlePageActive");
      emit(ArticlePageActive());
    });
    on<AssetsManagementPageActiveEvent>((event, emit) => emit(AssetsManagementPageActive()));
    on<PolisManagementPageActiveEvent>((event, emit) => emit(PolisManagementPageActive()));
    on<FindInsurancePageActiveEvent>((event, emit) => emit(FindInsurancePageActive()));
    on<TestimonyPageActiveEvent>((event, emit) => emit(TestimonyPageActive()));
    on<CsPageActiveEvent>((event, emit) => emit(CsPageActive()));
    on<UserNonJPSPageActiveEvent>((event, emit) => emit(UserNonJPSPageActive()));
    on<UserJPSPageActiveEvent>((event, emit) => emit(UserJPSPageActive()));
    on<LoadingHeroPageActiveEvent>((event, emit) => emit(LoadingHeroPageActive()));
    on<LoadingHero2PageActiveEvent>((event, emit) => emit(LoadingHero2PageActive()));
    on<LoadingHeroUserPageActiveEvent>((event, emit) => emit(LoadingHeroUserPageActive()));

    on<CobCariPageActiveEvent>((event, emit) => emit(CobCariPageActive()));
    on<AsetDashboardPageActiveEvent>((event, emit) => emit(AsetDashboardPageActive()));
    on<AsetParPageActiveEvent>((event, emit) => emit(AsetParPageActive()));
    on<AsetMVPageActiveEvent>((event, emit) => emit(AsetMVPageActive()));
    on<AsetRingkasanPageActiveEvent>((event, emit) => emit(AsetRingkasanPageActive()));
    on<AsetHealthPageActiveEvent>((event, emit) => emit(AsetHealthPageActive()));
    on<AsetStatusPageActiveEvent>((event, emit) => emit(AsetStatusPageActive()));
    on<AsetPageActiveEvent>((event, emit) => emit(AsetPageActive()));

    on<ReviewCariPageActiveEvent>((event, emit) => emit(ReviewCariPageActive()));

    on<BeritaPageActiveEvent>((event, emit) => emit(BeritaPageActive()));
    on<BeritaSampinganPageActiveEvent>((event, emit) => emit(BeritaSampinganPageActive()));
    on<BeritaArtikelPageActiveEvent>((event, emit) => emit(BeritaArtikelPageActive()));

    on<PushPageEvent>((event, emit) async {
      if (_pageStack.isNotEmpty && _pageStack.last == event.pageType) {
        debugPrint("⏩ PushPageEvent dilewati karena sudah di stack terakhir: \${event.pageType}");
        return;
      }

      _pageStack.add(event.pageType);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('lastPageType', event.pageType.name);

      final newState = _mapPageTypeToState(event.pageType);
      emit(newState);
      _dispatchInitEventForPage(event.pageType);
      markStartupPush();
    });

    on<PopPageEvent>((event, emit) {
      if (canGoBack) {
        _pageStack.removeLast();
        emit(_mapPageTypeToState(currentPage));
      }
    });
  }

  final Map<PageType, HomeEvent> _pageTypeToEventMap = {
    PageType.home: HomePageActiveEvent(),
    PageType.groupchat: StartChatPageActiveEvent(),
    PageType.roomchat: RoomCariPageActiveEvent(),
    PageType.changepswd: ChangePasswordPageActiveEvent(),
    PageType.klaimtrack: TrackKlaimPageActiveEvent(),
    PageType.splash: SplashPageActiveEvent(),
    PageType.profileindividu: ProfileIndividuPageActiveEvent(),
    PageType.profileperusahaan: ProfilePerusahaanPageActiveEvent(),
    PageType.article1: Article1PageActiveEvent(),
    PageType.testprofile: TestProfilePageActiveEvent(),
    PageType.about: AboutPageActiveEvent(),
    PageType.article: ArticlePageActiveEvent(),
    PageType.assetsmanagement: AssetsManagementPageActiveEvent(),
    PageType.polismanagement: PolisManagementPageActiveEvent(),
    PageType.findinsurance: FindInsurancePageActiveEvent(),
    PageType.testimony: TestimonyPageActiveEvent(),
    PageType.cs: CsPageActiveEvent(),
    PageType.usernonjps: UserNonJPSPageActiveEvent(),
    PageType.userjps: UserJPSPageActiveEvent(),
    PageType.loadinghero: LoadingHeroPageActiveEvent(),
    PageType.loadinghero2: LoadingHero2PageActiveEvent(),
    PageType.loadingherouser: LoadingHeroUserPageActiveEvent(),
    PageType.cobcari: CobCariPageActiveEvent(),
    PageType.asetdashboard: AsetDashboardPageActiveEvent(),
    PageType.asetpar: AsetParPageActiveEvent(),
    PageType.asetmv: AsetMVPageActiveEvent(),
    PageType.asetringkasan: AsetRingkasanPageActiveEvent(),
    PageType.asethealth: AsetHealthPageActiveEvent(),
    PageType.asetstatus: AsetStatusPageActiveEvent(),
    PageType.aset: AsetPageActiveEvent(),
    PageType.review: ReviewCariPageActiveEvent(),
    PageType.berita: BeritaPageActiveEvent(),
    PageType.beritasampingan: BeritaSampinganPageActiveEvent(),
    PageType.beritaartikel: BeritaArtikelPageActiveEvent(),
    PageType.simulmv: SimulMVPageActiveEvent(),
    PageType.simulpar: SimulPARPageActiveEvent(),

  };

  void _dispatchInitEventForPage(PageType pageType) {
    final event = _pageTypeToEventMap[pageType];
    if (event != null) {
      add(event);
    } else {
      debugPrint("⚠️ Tidak ada event lanjut untuk: \$pageType");
    }
  }

  static final Map<PageType, HomeState Function()> _pageTypeToStateMap = {
    PageType.home: () => HomePageActive(),
    PageType.groupchat: () => StartChatPageActive(),
    PageType.roomchat: () => RoomCariPageActive(),
    PageType.changepswd: () => ChangePasswordPageActive(),
    PageType.klaimtrack: () => TrackKlaimPageActive(),
    PageType.splash: () => SplashPageActive(),
    PageType.profileindividu: () => ProfileIndividuPageActive(),
    PageType.profileperusahaan: () => ProfilePerusahaanPageActive(),
    PageType.article1: () => Article1PageActive(),
    PageType.testprofile: () => TestProfilePageActive(),
    PageType.about: () => AboutPageActive(),
    PageType.article: () => ArticlePageActive(),
    PageType.assetsmanagement: () => AssetsManagementPageActive(),
    PageType.polismanagement: () => PolisManagementPageActive(),
    PageType.findinsurance: () => FindInsurancePageActive(),
    PageType.testimony: () => TestimonyPageActive(),
    PageType.cs: () => CsPageActive(),
    PageType.usernonjps: () => UserNonJPSPageActive(),
    PageType.userjps: () => UserJPSPageActive(),
    PageType.loadinghero: () => LoadingHeroPageActive(),
    PageType.loadinghero2: () => LoadingHero2PageActive(),
    PageType.loadingherouser: () => LoadingHeroUserPageActive(),
    PageType.cobcari: () => CobCariPageActive(),
    PageType.asetdashboard: () => AsetDashboardPageActive(),
    PageType.asetpar: () => AsetParPageActive(),
    PageType.asetmv: () => AsetMVPageActive(),
    PageType.asetringkasan: () => AsetRingkasanPageActive(),
    PageType.asethealth: () => AsetHealthPageActive(),
    PageType.asetstatus: () => AsetStatusPageActive(),
    PageType.aset: () => AsetPageActive(),
    PageType.review: () => ReviewCariPageActive(),
    PageType.berita: () => BeritaPageActive(),
    PageType.beritasampingan: () => BeritaSampinganPageActive(),
    PageType.beritaartikel: () => BeritaArtikelPageActive(),
    PageType.simulmv: () => SimulMVPageActive(),
    PageType.simulpar: () => SimulPARPageActive(),


  };

  static HomeState _mapPageTypeToState(PageType pageType) {
    return _pageTypeToStateMap[pageType]?.call() ?? HomePageActive();
  }

  void resetStack() {
    _pageStack.clear();
    _pageStack.add(PageType.home);
  }
}
