  part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

// ────────────────────────────────────
// Active Page States
// ────────────────────────────────────
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
class SimulMBPageActive extends HomeState {}
class SimulMVPageActive extends HomeState {}
class SimulPARPageActive extends HomeState {}
class SimulTREEPageActive extends HomeState {}
class SimulWPPageActive extends HomeState {}
class SimulFlexasPageActive extends HomeState {}
class TrackKlaimPageActive extends HomeState {}
class StartChatPageActive extends HomeState {}
class CobCariPageActive extends HomeState {}
class AsetDashboardPageActive extends HomeState {}
class AsetParPageActive extends HomeState {}
class AsetMVPageActive extends HomeState {}
class AsetRingkasanPageActive extends HomeState {}
class AsetHealthPageActive extends HomeState {}
class AsetStatusPageActive extends HomeState {}
class AsetPageActive extends HomeState {}
class ReviewCariPageActive extends HomeState {}
class BeritaPageActive extends HomeState {}
class BeritaSampinganPageActive extends HomeState {}
class BeritaArtikelPageActive extends HomeState {}

class SppamvPageActive extends HomeState {}
class SppaparPageActive extends HomeState {}
// ────────────────────────────────────
// Secondary Pages
// ────────────────────────────────────
class SplashPageActive extends HomeState {}
class ProfileIndividuPageActive extends HomeState {}
class ProfilePerusahaanPageActive extends HomeState {}
class Article1PageActive extends HomeState {}
class TestProfilePageActive extends HomeState {}
class AboutPageActive extends HomeState {}
class ActiveAssetsPageActive extends HomeState {}
class ArticlePageActive extends HomeState {}
class AssetsManagementPageActive extends HomeState {}
class PolisManagementPageActive extends HomeState {}
class FindInsurancePageActive extends HomeState {}
class TestimonyPageActive extends HomeState {}
class CsPageActive extends HomeState {}
class UserNonJPSPageActive extends HomeState {}
class UserJPSPageActive extends HomeState {}

// ────────────────────────────────────
// Loading States
// ────────────────────────────────────
class LoadingHeroPageActive extends HomeState {}
class LoadingHero2PageActive extends HomeState {}
class LoadingHeroUserPageActive extends HomeState {}

class PromoPageActive extends HomeState {}
