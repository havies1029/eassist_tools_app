part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object> get props => [];
}

class HomePageActive extends HomeState {}
class ProfilePageActive extends HomeState {}
class RoomCariPageActive extends HomeState {}
class ChatSupportPageActive extends HomeState {}
class ChangePasswordPageActive extends HomeState {}
class SimulBONPageActive extends HomeState {}

class SimulCARPageActive extends HomeState {}
class SimulCARGOPageActive extends HomeState {}
class SimulEEIPageActive extends HomeState {}
class SimulGISPageActive extends HomeState {}
class SimulGITPageActive extends HomeState {}

class SimulMBPageActive extends HomeState{}

class SimulMVPageActive extends HomeState {}

class SimulPARPageActive extends HomeState {}

class  SimulTREEPageActive extends HomeState {}

class SimulWPPageActive extends HomeState {}

class SimulFlexasPageActive extends HomeState {}

class TrackKlaimPageActive extends HomeState {}

class StartChatPageActive extends HomeState {}

//Active Page
class SplashPageActive extends HomeState {}
class ProfileIndividuPageActive extends HomeState {}
class ProfilePerusahaanPageActive extends HomeState {}
class Article1PageActive extends HomeState {}
class TestProfilePageActive extends HomeState {}
class AboutPageActive extends HomeState {}
class ActiveAssetsPageActive extends HomeState {}
class ArticlePageActive extends HomeState {}
class AssetsManagementPageActive extends HomeState {}
class FindInsurancePageActive extends HomeState {}
class HeroUserPageActive extends HomeState {}
class HeroPageActive extends HomeState {}
class TestimonyPageActive extends HomeState {}
class CsPageActive extends HomeState {}
class UserNonJPSPageActive extends HomeState {}
class UserJPSPageActive extends HomeState {}

//loading
class LoadingHeroPageActive extends HomeState {}
class LoadingHero2PageActive extends HomeState {}
class LoadingHeroUserPageActive extends HomeState {}

