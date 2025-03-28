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