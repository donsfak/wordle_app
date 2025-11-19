// ignore_for_file: unreachable_switch_default

import 'package:flutter/material.dart';
import 'package:wordle/app/app_colors.dart';
import 'package:wordle/wordle/wordle.dart'; // Assurez-vous que Letter est exporté

class BoardTile extends StatelessWidget {
  const BoardTile({super.key, required this.letter});

  final Letter letter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Accéder au thème actuel

    // Déterminer les couleurs en fonction du thème et du statut de la lettre
    Color tileColor;
    Color borderColor;
    Color textColor;

    bool isDark = theme.brightness == Brightness.dark;

    switch (letter.status) {
      case LetterStatus.initial:
        tileColor = Colors.transparent; // Pas de fond si initial
        borderColor = isDark ? darkTileBorderEmpty : lightTileBorderEmpty;
        textColor = isDark ? darkTextColor : lightTextColor;
        break;
      case LetterStatus.notInWord:
        tileColor = isDark ? darkNotInWordColor : lightNotInWordColor;
        borderColor = tileColor; // Pas de bordure distincte
        textColor = isDark ? darkKeyboardTextColor : lightKeyboardTextColor;
        break;
      case LetterStatus.inWord:
        tileColor = isDark ? darkInWordColor : lightInWordColor;
        borderColor = tileColor;
        textColor = isDark ? darkKeyboardTextColor : lightKeyboardTextColor;
        break;
      case LetterStatus.correct:
        tileColor = isDark ? darkCorrectColor : lightCorrectColor;
        borderColor = tileColor;
        textColor = isDark ? darkKeyboardTextColor : lightKeyboardTextColor;
        break;
      default: // Lettre saisie mais pas encore soumise
        tileColor = Colors.transparent; // Pas de fond
        borderColor = isDark ? darkTileBorderFilled : lightTileBorderFilled;
        textColor = isDark ? darkTextColor : lightTextColor;
        break;
    }

    return Container(
      width: 60, // Largeur fixe, ajustez si besoin
      height: 60, // Hauteur fixe, ajustez si besoin
      alignment: Alignment.center,
      margin: const EdgeInsets.all(2), // Petite marge entre les tuiles
      decoration: BoxDecoration(
        color: tileColor,
        border: Border.all(
          color: borderColor,
          width: letter.val.isNotEmpty
              ? 2
              : 1.5, // Bordure plus épaisse si lettre saisie
        ),
        borderRadius: BorderRadius.circular(4), // << Coins arrondis
      ),
      child: Text(
        letter.val,
        style: theme.textTheme.headlineMedium?.copyWith(
          // Utilise la police du thème
          fontWeight: FontWeight.bold,
          color: textColor, // Couleur de texte basée sur le statut/thème
        ),
      ),
    );
  }
}
