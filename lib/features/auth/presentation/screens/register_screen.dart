import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topstretching/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:topstretching/features/auth/presentation/blocs/auth_bloc_event.dart';
import 'package:topstretching/features/auth/presentation/blocs/auth_bloc_state.dart';
import 'package:topstretching/features/auth/presentation/screens/login_screen.dart';
import 'package:topstretching/features/auth/presentation/widgets/textformfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Screen"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (_) => AuthBloc()..add(CheckAuthState()),

        child: BlocBuilder<AuthBloc, AuthBlocState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextformfieldWidget(
                        controller: _emailController,
                        labelText: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Iltimos email kiriting";
                          }
                          if (!value.contains("@")) {
                            return "Iltimos to'g'ri email kiriting";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16),
                      TextformfieldWidget(
                        controller: _passwordController,
                        labelText: "Parol",
                        hideText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Iltimos parol kiriting";
                          }
                          if (value.length < 6) {
                            return "Iltimos kuchliroq parol kiriting";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextformfieldWidget(
                        controller: _passwordConfirmationController,
                        labelText: "Parol tasdiqlang",
                        hideText: true,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return "Parollar mos kelmadi";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            context.read<AuthBloc>().add(
                              RegisterRequested(email, password),
                            );
                          }
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text("Ro'yxatdan o'tish"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
