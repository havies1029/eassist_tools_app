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
class SimulMVPageActive extends HomeState {}
class SimulPARPageActive extends HomeState {}
class SimulEEIPageActive extends HomeState {}
