import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../user/domain/entities/user_entity.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/usecases/log_out_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  List<bool> userCheckList = [];
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final LogOutUseCase logOutUseCase;

  AuthBloc({required this.loginUseCase, required this.signUpUseCase, required this.logOutUseCase}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<SignUpEvent>(_onSignUpEvent);
    on<LoginEvent>(_onLoginEvent);
    on<LogOutEvent>(_onLogoutEvent);
  }

  _onSignUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(LoadingSignUpState());
    final result = await signUpUseCase(authEntity: event.authEntity);
    result.fold((l) {
      emit(ErrorSignUpState(message: l));
    }, (r) {
      emit(SuccessSignUpState());
    });
  }

  _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoadingLoginState());
    final result = await loginUseCase(email: event.email, password: event.password);
    result.fold((l) {
      emit(ErrorLoginState(message: l));
    }, (r) {
      emit(SuccessLoginState());
    });
  }

  _onLogoutEvent(LogOutEvent event, Emitter<AuthState> emit) async {
    emit(LoadingLogOutState());
    final result = await logOutUseCase();
    result.fold((l) {
      emit(ErrorLogOutState(message: l));
    }, (r) {
      emit(SuccessLogOutState());
    });
  }
}
