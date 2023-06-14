import 'package:flutter/material.dart';
import 'package:flashcards/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/deck_page.dart';
import 'pages/study_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flashcards/color_schemes.g.dart';

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
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      theme: ThemeData(
          colorScheme: lightColorScheme,
          textTheme: GoogleFonts.interTextTheme(),
          useMaterial3: true),
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
