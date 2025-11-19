// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wordle/app/app_colors.dart';
import 'package:wordle/wordle/views/wordle_screen.dart'; // Assurez-vous d'importer l'écran

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Appliquer une police via Google Fonts (ex: Poppins)
    // Si vous avez déclaré une police locale dans pubspec.yaml, mettez son nom ici.
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    return MaterialApp(
      title: 'Flutter Wordle',
      debugShowCheckedModeBanner: false, // Masque la bannière Debug

      // Thème Clair
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: lightBackground,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: lightBackground,
          titleTextStyle: textTheme.titleLarge?.copyWith(
            color: lightTextColor,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: lightIconColor),
        ),
        colorScheme: const ColorScheme.light(
          primary:
              lightCorrectColor, // Utilisé pour des éléments comme le curseur etc.
          secondary: lightInWordColor,
          background: lightBackground,
          surface: lightBackground, // Couleur de fond des Cards, Dialogs etc.
          onBackground: lightTextColor,
          onSurface: lightTextColor,
          error: Colors.redAccent,
          onError: Colors.white,
        ),
        textTheme: textTheme.apply(
          bodyColor: lightTextColor,
          displayColor: lightTextColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: lightKeyDefaultColor,
            foregroundColor:
                lightKeyboardTextColor, // Couleur du texte/icône sur le bouton
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 12), // Ajustez le padding
            textStyle:
                textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),

      // Thème Sombre
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: darkBackground,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: darkBackground,
          titleTextStyle: textTheme.titleLarge?.copyWith(
            color: darkTextColor,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: darkIconColor),
        ),
        colorScheme: const ColorScheme.dark(
          primary: darkCorrectColor,
          secondary: darkInWordColor,
          background: darkBackground,
          surface: darkBackground,
          onBackground: darkTextColor,
          onSurface: darkTextColor,
          error: Colors.red,
          onError: Colors.white,
        ),
        textTheme: textTheme.apply(
          bodyColor: darkTextColor,
          displayColor: darkTextColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: darkKeyDefaultColor,
            foregroundColor:
                darkKeyboardTextColor, // Couleur du texte/icône sur le bouton
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 12), // Ajustez le padding
            textStyle:
                textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),

      // S'adapte au thème système par défaut
      themeMode: ThemeMode.system,

      home: const WordleScreen(),
    );
  }
}
