import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_application/features/auth/domain/entities/auth_entity.dart';
import 'package:internet_application/features/user/domain/usecases/users/get_user_usecase.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/users/create_new_User_usecase.dart';
import '../../../domain/usecases/users/delete_user_usecase.dart';
import '../../../domain/usecases/users/get_all_users_usecase.dart';
import '../../../domain/usecases/users/update_current_user_usecase.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetAllUsersUseCase getAllUsersUseCase;
  final GetUserUseCase getUserUseCase;
  final CreateNewUserUseCase createNewUserUseCase;
  final UpdateCurrentUserUseCase updateCurrentUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  UserBloc({
    required this.getAllUsersUseCase,
    required this.getUserUseCase,
    required this.deleteUserUseCase,
    required this.updateCurrentUserUseCase,
    required this.createNewUserUseCase,
  }) : super(UserInitial()) {
    on<GetAllUsersEvent>(_onGetAllUsers);
    on<GetUserEvent>(_onGetUser);
    on<CreateNewUserEvent>(_onCreateNewUser);
    on<UpdateCurrentUserEvent>(_onUpdateCurrentUser);
    on<DeleteUserEvent>(_onDeleteUser);
  }

  _onGetAllUsers(GetAllUsersEvent event, Emitter<UserState> emit) async {
    emit(LoadingGetAllUsersState());
    final result = await getAllUsersUseCase(page: event.page, pageSize: event.pageSize);
    result.fold((l) {
      emit(ErrorGetAllUsersState(message: l));
    }, (listAllUsers) {
      emit(SuccessGetAllUsersState(listAllUsers: listAllUsers));
    });
  }

  _onGetUser(GetUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingGetUserState());
    final result = await getUserUseCase(userId: event.userId);
    result.fold((l) {
      emit(ErrorGetUserState(message: l));
    }, (userEntity) {
      emit(SuccessGetUserState(userEntity: userEntity));
    });
  }

  _onCreateNewUser(CreateNewUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingCreateNewUserState());
    final result = await createNewUserUseCase(authEntity: event.authEntity,roleId: event.roleId);
    result.fold((l) {
      emit(ErrorCreateNewUserState(message: l));
    }, (r) {
      emit(SuccessCreateNewUserState());
    });
  }

  _onUpdateCurrentUser(UpdateCurrentUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingUpdateCurrentUserState());
    final result = await updateCurrentUserUseCase(authEntity: event.authEntity,roleId: event.roleId,userId: event.userId);
    result.fold((l) {
      emit(ErrorUpdateCurrentUserState(message: l));
    }, (r) {
      emit(SuccessUpdateCurrentUserState());
    });
  }

  _onDeleteUser(DeleteUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingDeleteUserState());
    final result = await deleteUserUseCase(userId: event.userId);
    result.fold((l) {
      emit(ErrorDeleteUserState(message: l));
    }, (r) {
      emit(SuccessDeleteUserState());
    });
  }
}
