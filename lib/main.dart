import 'package:flutter/material.dart';
import 'package:flashcards/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/deck_page.dart';
import 'pages/study_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const FlashcardsApp());
}

class FlashcardsApp extends StatelessWidget {
  const FlashcardsApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcards',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //scaffoldBackgroundColor: Colors.blue,
      ),
      builder: (context, child) {
        return SafeArea(child: child!);
      },
      routes: {
        '/': (context) => const LoginPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(title: 'Flashcards'),
        '/deck': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return DeckPage(deckName: args);
        },
        '/study': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return StudyPage(deckName: args);
        },
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
