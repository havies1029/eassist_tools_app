part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final bool isLoading;

  const HomeState({this.isLoading = false});

  @override
  List<Object?> get props => [isLoading];
}

// ───────────────────────
// Active Page States
// ───────────────────────
class HomePageActive extends HomeState {
  const HomePageActive({super.isLoading});
}

class ProfilePageActive extends HomeState {
  const ProfilePageActive({super.isLoading});
}

class RoomCariPageActive extends HomeState {
  const RoomCariPageActive({super.isLoading});
}

class ChatSupportPageActive extends HomeState {
  const ChatSupportPageActive({super.isLoading});
}

class ChangePasswordPageActive extends HomeState {
  const ChangePasswordPageActive({super.isLoading});
}

class SimulBONPageActive extends HomeState {
  const SimulBONPageActive({super.isLoading});
}

class SimulCARPageActive extends HomeState {
  const SimulCARPageActive({super.isLoading});
}

class SimulCARGOPageActive extends HomeState {
  const SimulCARGOPageActive({super.isLoading});
}

class SimulEEIPageActive extends HomeState {
  const SimulEEIPageActive({super.isLoading});
}

class SimulGISPageActive extends HomeState {
  const SimulGISPageActive({super.isLoading});
}

class SimulGITPageActive extends HomeState {
  const SimulGITPageActive({super.isLoading});
}

class SimulMBPageActive extends HomeState {
  const SimulMBPageActive({super.isLoading});
}

class SimulMVPageActive extends HomeState {
  const SimulMVPageActive({super.isLoading});
}

class SimulPARPageActive extends HomeState {
  const SimulPARPageActive({super.isLoading});
}

class SimulTREEPageActive extends HomeState {
  const SimulTREEPageActive({super.isLoading});
}

class SimulWPPageActive extends HomeState {
  const SimulWPPageActive({super.isLoading});
}

class SimulFlexasPageActive extends HomeState {
  const SimulFlexasPageActive({super.isLoading});
}

class TrackKlaimPageActive extends HomeState {
  const TrackKlaimPageActive({super.isLoading});
}

class StartChatPageActive extends HomeState {
  const StartChatPageActive({super.isLoading});
}

class CobCariPageActive extends HomeState {
  const CobCariPageActive({super.isLoading});
}

class AsetDashboardPageActive extends HomeState {
  const AsetDashboardPageActive({super.isLoading});
}

class AsetParPageActive extends HomeState {
  const AsetParPageActive({super.isLoading});
}

class AsetMVPageActive extends HomeState {
  const AsetMVPageActive({super.isLoading});
}

class AsetRingkasanPageActive extends HomeState {
  const AsetRingkasanPageActive({super.isLoading});
}

class AsetHealthPageActive extends HomeState {
  const AsetHealthPageActive({super.isLoading});
}

class AsetStatusPageActive extends HomeState {
  const AsetStatusPageActive({super.isLoading});
}

class AsetPageActive extends HomeState {
  const AsetPageActive({super.isLoading});
}

class ReviewCariPageActive extends HomeState {
  const ReviewCariPageActive({super.isLoading});
}

class BeritaPageActive extends HomeState {
  const BeritaPageActive({super.isLoading});
}

class BeritaSampinganPageActive extends HomeState {
  const BeritaSampinganPageActive({super.isLoading});
}

class BeritaArtikelPageActive extends HomeState {
  const BeritaArtikelPageActive({super.isLoading});
}

// ───────────────────────
// Secondary Pages
// ───────────────────────
class SplashPageActive extends HomeState {
  const SplashPageActive({super.isLoading});
}

class ProfileIndividuPageActive extends HomeState {
  const ProfileIndividuPageActive({super.isLoading});
}

class ProfilePerusahaanPageActive extends HomeState {
  const ProfilePerusahaanPageActive({super.isLoading});
}

class Article1PageActive extends HomeState {
  const Article1PageActive({super.isLoading});
}

class TestProfilePageActive extends HomeState {
  const TestProfilePageActive({super.isLoading});
}

class AboutPageActive extends HomeState {
  const AboutPageActive({super.isLoading});
}

class ActiveAssetsPageActive extends HomeState {
  const ActiveAssetsPageActive({super.isLoading});
}

class ArticlePageActive extends HomeState {
  const ArticlePageActive({super.isLoading});
}

class AssetsManagementPageActive extends HomeState {
  const AssetsManagementPageActive({super.isLoading});
}

class PolisManagementPageActive extends HomeState {
  const PolisManagementPageActive({super.isLoading});
}

class FindInsurancePageActive extends HomeState {
  const FindInsurancePageActive({super.isLoading});
}

class TestimonyPageActive extends HomeState {
  const TestimonyPageActive({super.isLoading});
}

class CsPageActive extends HomeState {
  const CsPageActive({super.isLoading});
}

class UserNonJPSPageActive extends HomeState {
  const UserNonJPSPageActive({super.isLoading});
}

class UserJPSPageActive extends HomeState {
  const UserJPSPageActive({super.isLoading});
}

// ───────────────────────
// Loading States
// ───────────────────────
class LoadingHeroPageActive extends HomeState {
  const LoadingHeroPageActive({super.isLoading});
}

class LoadingHero2PageActive extends HomeState {
  const LoadingHero2PageActive({super.isLoading});
}

class LoadingHeroUserPageActive extends HomeState {
  const LoadingHeroUserPageActive({super.isLoading});
}
