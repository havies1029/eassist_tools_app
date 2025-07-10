import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';
part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomePageActive()) {
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
    on<Article1PageActiveEvent>((event, emit) => emit(Article1PageActive()));
    on<TestProfilePageActiveEvent>((event, emit) => emit(TestProfilePageActive()));
    on<AboutPageActiveEvent>((event, emit) {
      if (state is! AboutPageActive) {
        debugPrint("[BLOC] AboutPageActiveEvent triggered");
        emit(AboutPageActive());
      } else {
        debugPrint("[BLOC] AboutPageActiveEvent skipped — already in AboutPageActive state");
      }
    });
    on<ActiveAssetsPageActiveEvent>((event, emit) => emit(ActiveAssetsPageActive()));
    on<ArticlePageActiveEvent>((event, emit) => emit(ArticlePageActive()));
    on<AssetsManagementPageActiveEvent>((event, emit) => emit(AssetsManagementPageActive()));
    on<PolisManagementPageActiveEvent>((event, emit) => emit(PolisManagementPageActive()));
    on<FindInsurancePageActiveEvent>((event, emit) => emit(FindInsurancePageActive()));
    on<HeroUserPageActiveEvent>((event, emit) => emit(HeroUserPageActive()));
    on<HeroPageActiveEvent>((event, emit) => emit(HeroPageActive()));
    on<TestimonyPageActiveEvent>((event, emit) => emit(TestimonyPageActive()));
    on<CsPageActiveEvent>((event, emit) => emit(CsPageActive()));
    on<UserNonJPSPageActiveEvent>((event, emit) => emit(UserNonJPSPageActive()));
    on<UserJPSPageActiveEvent>((event, emit) => emit(UserJPSPageActive()));
    on<LoadingHeroPageActiveEvent>((event, emit) => emit(LoadingHeroPageActive()));
    on<LoadingHero2PageActiveEvent>((event, emit) => emit(LoadingHero2PageActive()));
    on<LoadingHeroUserPageActiveEvent>((event, emit) => emit(LoadingHeroUserPageActive()));

    on<CobCariPageActiveEvent>((event, emit) => emit(CobCariPageActive()));
    on<AsetDashboardPageActiveEvent>((event, emit) => emit(AsetDashboardPageActive()));
  }
}
