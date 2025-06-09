import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  String? _selectedAnswer = "yes";
  String? _isAgree = "true";

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: Text(
          "Account registration",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
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
                        controller: _nameController,
                        hintText: "Enter Your Name",
                      ),
                      SizedBox(height: 40),
                      TextformfieldWidget(
                        controller: _emailController,
                        hintText: "Enter Your Email",
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

                      SizedBox(height: 40),
                      TextformfieldWidget(
                        controller: _passwordController,
                        hintText: "Enter Your Password",
                        hideText: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset("assets/icons/checkmark.svg"),
                        ),
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
                      SizedBox(height: 40),
                      TextformfieldWidget(
                        controller: _passwordConfirmationController,
                        hintText: "Confirm Password",
                        hideText: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            "assets/icons/checkmark.svg",
                            color:
                                _passwordConfirmationController.text ==
                                    _passwordController.text
                                ? Colors.green
                                : null,
                          ),
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return "Parollar mos kelmadi";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Do you have TOPSTRETCHING membership?",
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Radio<String>(
                                value: "yes",
                                groupValue: _selectedAnswer,
                                activeColor: Color(0xFFF41671),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedAnswer = value;
                                  });
                                },
                              ),
                              Text(
                                "Yes",
                                style: TextStyle(color: Colors.white),
                              ),

                              SizedBox(width: 30),

                              Radio<String>(
                                value: "no",
                                groupValue: _selectedAnswer,
                                activeColor: Color(0xFFF41671),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedAnswer = value;
                                  });
                                },
                              ),
                              Text("No", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "We're all set. Now let's create your account.",
                            style: TextStyle(color: Colors.white),
                          ),
                          RadioListTile<String>(
                            contentPadding: EdgeInsets.all(0),
                            dense: true,
                            title: Text(
                              "I agree to TOPSTRETCHING Terms & Conditions",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            value: "true",
                            groupValue: _isAgree,
                            activeColor: Color(0xFFF41671),
                            onChanged: (value) {
                              setState(() {
                                _isAgree = value;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            contentPadding: EdgeInsets.all(0),
                            dense: true,
                            title: Text(
                              "I agree to Privacy Policy",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            value: "false",
                            groupValue: _isAgree,
                            activeColor: Color(0xFFF41671),
                            onChanged: (value) {
                              setState(() {
                                _isAgree = value;
                              });
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 80),

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
                        child: Text("CREATE AN ACCOUNT"),
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
