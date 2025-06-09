import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBlocState {}

class AuthInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class AuthAuthenticated extends AuthBlocState {
  final User user;
  AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthBlocState {
  final String? error;
  AuthUnauthenticated({this.error});
}
