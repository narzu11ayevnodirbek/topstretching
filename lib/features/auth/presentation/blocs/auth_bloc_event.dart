abstract class AuthBlocEvent {}

class LoginRequested extends AuthBlocEvent {
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
}

class RegisterRequested extends AuthBlocEvent {
  final String email;
  final String password;
  RegisterRequested(this.email, this.password);
}

class LogoutRequested extends AuthBlocEvent {}

class CheckAuthState extends AuthBlocEvent {}
