import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topstretching/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:topstretching/features/auth/presentation/blocs/auth_bloc_event.dart';
import 'package:topstretching/features/auth/presentation/blocs/auth_bloc_state.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Auth"), centerTitle: true),
      body: BlocProvider(
        create: (_) => AuthBloc()..add(CheckAuthState()),
        child: BlocBuilder<AuthBloc, AuthBlocState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is AuthAuthenticated) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Logged in as ${state.user.email}"),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<AuthBloc>().add(LogoutRequested()),
                      child: Text("Log Out"),
                    ),
                  ],
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: passController,
                    obscureText: true,
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (isLogin) {
                        context.read<AuthBloc>().add(
                          LoginRequested(
                            emailController.text,
                            passController.text,
                          ),
                        );
                      } else {
                        context.read<AuthBloc>().add(
                          RegisterRequested(
                            emailController.text,
                            passController.text,
                          ),
                        );
                      }
                    },
                    child: Text(isLogin ? "Login" : "Register"),
                  ),
                  TextButton(
                    onPressed: () => setState(() {
                      isLogin = !isLogin;
                    }),
                    child: Text(
                      isLogin
                          ? "Don't have an account? Register"
                          : "Already have an account? Login",
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
