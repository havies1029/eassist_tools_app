import 'package:eassist_tools_app/common/app_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/models/user/user_model.dart';
import 'package:eassist_tools_app/repositories/user/user_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<UserEvents, UserState> {
  final UserRepository userRepository;
  final int id;
  late User _user;

  ProfileBloc({required this.userRepository, required this.id})
      : super(UserState(isLoading: true)) {
    on<GetUserEvent>(_onGetUser);
    on<CreateUserEvent>(_onCreateUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<DeleteUserEvent>(_onDeleteUser);
  }

  Future<void> _onGetUser(GetUserEvent event, Emitter<UserState> emit) async {
    emit(UserState(isLoading: true, isLoaded: false));
    User user;
    if (AppData.kIsWeb) {
      user = AppData.user;
    } else {
      user = await userRepository.getUserById(id);
    }
    emit(UserState(user: user, isLoading: false, isLoaded: true));
  }

  Future<void> _onCreateUser(
      CreateUserEvent event, Emitter<UserState> emit) async {
    emit(UserState(isSaving: true, isSaved: false));
    bool? isSuccessful = await userRepository.createUser(_user);
    emit(UserState(
        isSaving: false, isSaved: isSuccessful!, hasFailure: isSuccessful));
  }

  Future<void> _onUpdateUser(
      UpdateUserEvent event, Emitter<UserState> emit) async {
    emit(UserState(
      isSaving: true,
      isSaved: false,
    ));

    event.user.id = 0;
    //event.user.username = "";

    bool isSuccessful = await userRepository.updateUser(event.user);

    //debugPrint("profile_block -> _onUpdateUser #20");

    emit(UserState(
      isSaving: false,
      isSaved: isSuccessful,
      hasFailure: !isSuccessful,
    ));

    //debugPrint("profile_block -> _onUpdateUser #30");
  }

  Future<void> _onDeleteUser(
      DeleteUserEvent event, Emitter<UserState> emit) async {
    emit(UserState(
      isDeleting: true,
      isDeleted: false,
    ));

    bool isSuccessful =
        AppData.kIsWeb ? true : await userRepository.deleteUser(id);

    emit(UserState(
      isDeleting: false,
      isDeleted: isSuccessful,
      hasFailure: !isSuccessful,
    ));
  }
}
