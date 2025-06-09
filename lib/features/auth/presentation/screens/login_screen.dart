import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:topstretching/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:topstretching/features/auth/presentation/blocs/auth_bloc_event.dart';
import 'package:topstretching/features/auth/presentation/blocs/auth_bloc_state.dart';
import 'package:topstretching/features/auth/presentation/screens/home_screen.dart';
import 'package:topstretching/features/auth/presentation/screens/register_screen.dart';
import 'package:topstretching/features/auth/presentation/widgets/textformfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
          } else if (state is AuthUnauthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error ?? "Noma'lum xatolik yuz berdi"),
              ),
            );
          }
        },
        child: Stack(
          children: [
            // 1. Background image
            Positioned(
              child: Image.asset(
                "assets/images/login.png",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 480,
              ),
            ),

            // 2. Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      // More visible overlay
                      Colors.transparent,
                      Colors.black,
                    ],
                  ),
                ),
              ),
            ),

            // 3. Form and UI
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 80,
                ),
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.55),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextformfieldWidget(
                            controller: _emailController,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                "assets/icons/email_icon.svg",
                                color: Color(0xFFF41671),
                              ),
                            ),
                            hintText: "Email",

                            validator: (value) =>
                                value!.contains('@') ? null : "Email noto'g'ri",
                          ),
                          SizedBox(height: 28),
                          TextformfieldWidget(
                            controller: _passwordController,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                "assets/icons/password_icon.svg",
                              ),
                            ),
                            hintText: "Parol",
                            hideText: true,
                            validator: (value) => value!.length >= 6
                                ? null
                                : "Parol kamida 6 ta belgidan iborat bo'lishi kerak",
                          ),
                          SizedBox(height: 30),
                          BlocBuilder<AuthBloc, AuthBlocState>(
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return CircularProgressIndicator(
                                  strokeWidth: 6,
                                  color: Color(0xFFF41671),
                                );
                              }
                              return Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFF41671),
                                      Color(0xFFCF31BF),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      final email = _emailController.text;
                                      final password = _passwordController.text;
                                      context.read<AuthBloc>().add(
                                        LoginRequested(email, password),
                                      );
                                    }
                                  },
                                  child: Text(
                                    "LOG IN",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 25),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            ),
                            child: Text(
                              "Create a new account",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
