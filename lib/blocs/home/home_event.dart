part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomePageActiveEvent extends HomeEvent {}
class ProfilePageActiveEvent extends HomeEvent {}
class RoomCariPageActiveEvent extends HomeEvent {}
class ChatSupportPageActiveEvent extends HomeEvent {}
class ChangePasswordPageActiveEvent extends HomeEvent {}
class SimulMVPageActiveEvent extends HomeEvent {}
class SimulPARPageActiveEvent extends HomeEvent {}
class SimulEEIPageActiveEvent extends HomeEvent {}
class SimulGITPageActiveEvent extends HomeEvent {}
class SimulGISPageActiveEvent extends HomeEvent {}
class SimulBONPageActiveEvent extends HomeEvent {}
class SimulWPPageActiveEvent extends HomeEvent {}

class SimulCARGOPageActiveEvent extends HomeEvent {}

class SimulFlexasPageActiveEvent extends HomeEvent {}

class SimulTREEPageActiveEvent extends HomeEvent {}

class SimulCARPageActiveEvent extends HomeEvent {}

class SimulMBPageActiveEvent extends HomeEvent {}

class TrackKlaimPageActiveEvent extends HomeEvent {}

class StartChatPageActiveEvent extends HomeEvent {}

//Active Page
class SplashPageActiveEvent extends HomeEvent {}
class ProfileIndividuPageActiveEvent extends HomeEvent {}
class ProfilePerusahaanPageActiveEvent extends HomeEvent {}
class Article1PageActiveEvent extends HomeEvent {}
class TestProfilePageActiveEvent extends HomeEvent {}
class AboutPageActiveEvent extends HomeEvent {}
class ActiveAssetsPageActiveEvent extends HomeEvent {}
class ArticlePageActiveEvent extends HomeEvent {}
class AssetsManagementPageActiveEvent extends HomeEvent {}
class FindInsurancePageActiveEvent extends HomeEvent {}
class HeroUserPageActiveEvent extends HomeEvent {}
class HeroPageActiveEvent extends HomeEvent {}
class TestimonyPageActiveEvent extends HomeEvent {}
class CsPageActiveEvent extends HomeEvent {}
class UserNonJPSPageActiveEvent extends HomeEvent {}
class UserJPSPageActiveEvent extends HomeEvent {}

//loading
class LoadingHeroPageActiveEvent extends HomeEvent {}
class LoadingHeroUserPageActiveEvent extends HomeEvent {}

