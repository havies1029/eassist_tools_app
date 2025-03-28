import 'package:equatable/equatable.dart';
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
  }
}
