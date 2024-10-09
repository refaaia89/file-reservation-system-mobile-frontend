part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class SuccessSignUpState extends AuthState {}

class ErrorSignUpState extends AuthState {
  final String message;

  ErrorSignUpState({required this.message});
}

class LoadingSignUpState extends AuthState {}

class SuccessLoginState extends AuthState {}

class ErrorLoginState extends AuthState {
  final String message;

  ErrorLoginState({required this.message});
}

class LoadingLoginState extends AuthState {}

class SuccessLogOutState extends AuthState {}

class ErrorLogOutState extends AuthState {
  final String message;

  ErrorLogOutState({required this.message});
}

class LoadingLogOutState extends AuthState {}
