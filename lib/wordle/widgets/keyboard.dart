// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:wordle/app/app_colors.dart'; // Pour les couleurs spécifiques si nécessaire
import 'package:wordle/wordle/models/letter_model.dart';

// Disposition standard du clavier QWERTY
const _qwerty = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['ENTER', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'DEL'],
];

class Keyboard extends StatelessWidget {
  const Keyboard({
    super.key,
    required this.onKeyTapped,
    required this.onDeleteTapped,
    required this.onEnterTapped,
    required this.letters,
  });

  final void Function(String) onKeyTapped;
  final VoidCallback onDeleteTapped;
  final VoidCallback onEnterTapped;
  final Set<Letter> letters; // Set contenant l'état des lettres utilisées

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Accéder au thème
    final bool isDark = theme.brightness == Brightness.dark;

    // Ajouter un Padding autour de l'ensemble du clavier pour éviter
    // que les touches ne collent aux bords de l'écran.
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 4.0), // Léger padding horizontal global
      child: Column(
        // Génère les lignes du clavier
        children: _qwerty
            .map(
              (keyRow) => Padding(
                // Ajouter un léger espace vertical entre les lignes
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Utiliser spacing peut aider si Flexible ne suffit pas, mais Flexible est mieux
                  // spacing: 4.0, // Espace horizontal entre les touches
                  children: keyRow.map(
                    (letter) {
                      // Trouver le statut de la lettre actuelle (si elle a été jouée)
                      final currentLetter = letters.firstWhere(
                        (e) => e.val == letter,
                        orElse: () =>
                            Letter.empty(), // Lettre vide si non trouvée
                      );

                      // Déterminer la couleur de fond de la touche
                      Color keyColor = isDark
                          ? darkKeyDefaultColor
                          : lightKeyDefaultColor; // Couleur par défaut
                      Color keyTextColor = isDark
                          ? darkKeyboardTextColor
                          : lightKeyboardTextColor; // Couleur texte par défaut

                      switch (currentLetter.status) {
                        case LetterStatus.notInWord:
                          keyColor =
                              isDark ? darkNotInWordColor : lightNotInWordColor;
                          break;
                        case LetterStatus.inWord:
                          keyColor =
                              isDark ? darkInWordColor : lightInWordColor;
                          break;
                        case LetterStatus.correct:
                          keyColor =
                              isDark ? darkCorrectColor : lightCorrectColor;
                          break;
                        default:
                          // Garder la couleur par défaut
                          break;
                      }

                      Widget
                          keyWidget; // Variable pour stocker le widget bouton+padding

                      // Gérer les touches spéciales ENTER et DEL
                      if (letter == 'ENTER') {
                        keyWidget = Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2.0), // Padding réduit un peu
                          child: ElevatedButton(
                            style: theme.elevatedButtonTheme.style?.copyWith(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 14)), // Padding interne ajusté
                              backgroundColor: MaterialStateProperty.all(
                                  keyColor), // Peut-être une couleur spéciale pour ENTER?
                              foregroundColor:
                                  MaterialStateProperty.all(keyTextColor),
                            ),
                            onPressed: onEnterTapped,
                            child: const Text('ENTER'),
                          ),
                        );
                        // Pour ENTER, utiliser Expanded pourrait être mieux pour prendre plus de place
                        // return Expanded(child: keyWidget);
                        // OU pour Flexible, spécifier un flex plus grand:
                        // return Flexible(flex: 2, child: keyWidget); // Prend plus de place relative
                      } else if (letter == 'DEL') {
                        keyWidget = Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: ElevatedButton(
                            style: theme.elevatedButtonTheme.style?.copyWith(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 14)), // Padding interne ajusté
                              backgroundColor: MaterialStateProperty.all(
                                  keyColor), // Peut-être une couleur spéciale pour DEL?
                              foregroundColor:
                                  MaterialStateProperty.all(keyTextColor),
                            ),
                            onPressed: onDeleteTapped,
                            child:
                                const Icon(Icons.backspace_outlined, size: 18),
                          ),
                        );
                        // Pour DEL aussi, un flex plus grand peut être pertinent
                        // return Flexible(flex: 2, child: keyWidget);
                      } else {
                        // Touches de lettres normales
                        keyWidget = Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: ElevatedButton(
                            style: theme.elevatedButtonTheme.style?.copyWith(
                              // Réduire un peu le padding interne si les touches sont trop larges
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 14)), // Padding interne réduit
                              backgroundColor:
                                  MaterialStateProperty.all(keyColor),
                              foregroundColor:
                                  MaterialStateProperty.all(keyTextColor),
                              // Optionnel: forcer une taille minimum plus petite si besoin
                              // minimumSize: MaterialStateProperty.all(Size(20, 48)),
                            ),
                            onPressed: () => onKeyTapped(letter),
                            child: Text(letter),
                          ),
                        );
                        // Pour les lettres normales, flex: 1 est implicite avec Flexible seul
                        // return Flexible(child: keyWidget);
                      }

                      // CORRECTION : Envelopper chaque touche dans un Flexible
                      // Utiliser flex: pour donner plus d'importance à ENTER/DEL si souhaité
                      if (letter == 'ENTER' || letter == 'DEL') {
                        return Flexible(
                            flex: 3,
                            fit: FlexFit.tight,
                            child: keyWidget); // Prend plus de place
                      } else {
                        return Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: keyWidget); // Prend une place normale
                      }
                    },
                  ).toList(),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
