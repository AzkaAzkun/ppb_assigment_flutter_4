import 'package:ppb_flutter_firebase/screens/home.dart';
import 'package:ppb_flutter_firebase/screens/login.dart';
import 'package:ppb_flutter_firebase/screens/register.dart';
import 'package:ppb_flutter_firebase/screens/note_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: 'login', routes: {
      'home': (context) => const HomeScreen(),
      'login': (context) => const LoginScreen(),
      'register': (context) => const RegisterScreen(),
      'note_form': (context) => const NoteFormScreen(),
    });
  }
}