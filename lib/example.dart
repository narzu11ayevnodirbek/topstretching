// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:topstretching/features/auth/presentation/blocs/auth_bloc.dart';
// import 'package:topstretching/features/auth/presentation/blocs/auth_bloc_event.dart';
// import 'package:topstretching/features/auth/presentation/blocs/auth_bloc_state.dart';
// import 'package:topstretching/features/auth/presentation/screens/home_screen.dart';
// import 'package:topstretching/features/auth/presentation/widgets/textformfield_widget.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Login")),
//       body: BlocListener<AuthBloc, AuthBlocState>(
//         listener: (context, state) {
//           if (state is AuthAuthenticated) {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (_) => HomeScreen()),
//             );
//           } else if (state is AuthUnauthenticated) {
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text(state.error!)));
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 TextformfieldWidget(
//                   controller: _emailController,
//                   labelText: "Email",
//                   validator: (value) =>
//                       value!.contains('@') ? null : "Email noto‘g‘ri",
//                 ),
//                 SizedBox(height: 16),
//                 TextformfieldWidget(
//                   controller: _passwordController,
//                   labelText: "Parol",
//                   hideText: true,
//                   validator: (value) => value!.length >= 6
//                       ? null
//                       : "Parol kamida 6 ta belgidan iborat bo‘lishi kerak",
//                 ),
//                 SizedBox(height: 20),
//                 BlocBuilder<AuthBloc, AuthBlocState>(
//                   builder: (context, state) {
//                     if (state is AuthLoading) {
//                       return CircularProgressIndicator();
//                     }
//                     return FilledButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           final email = _emailController.text;
//                           final password = _passwordController.text;
//                           context.read<AuthBloc>().add(
//                             LoginRequested(email, password),
//                           );
//                         }
//                       },
//                       child: Text("Kirish"),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
