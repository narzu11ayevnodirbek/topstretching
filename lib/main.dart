import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topstretching/core/services/di_instance.dart';
import 'package:topstretching/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:topstretching/features/auth/presentation/blocs/auth_bloc_event.dart';
import 'package:topstretching/features/auth/presentation/screens/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await serviceLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
    );
  }
}
