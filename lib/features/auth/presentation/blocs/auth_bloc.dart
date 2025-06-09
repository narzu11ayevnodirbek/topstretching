import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topstretching/features/auth/presentation/blocs/auth_bloc_event.dart';
import 'package:topstretching/features/auth/presentation/blocs/auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<CheckAuthState>((event, emit) {
      final user = _auth.currentUser;
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final cred = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(AuthAuthenticated(cred.user!));
      } catch (e) {
        emit(AuthUnauthenticated(error: e.toString()));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final cred = await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(AuthAuthenticated(cred.user!));
      } catch (e) {
        emit(AuthUnauthenticated(error: e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await _auth.signOut();
      emit(AuthUnauthenticated());
    });
  }
}
