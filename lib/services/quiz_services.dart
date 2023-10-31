import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pokequiz/models/pokemon.dart';
import 'package:pokequiz/utils/string_extension.dart';

class QuizServices {
  final List<Pokemon> pokemonList;
  int randomId;
  static int correctAnswers = 0;
  static int incorrectAnswers = 0;

  QuizServices(this.pokemonList, this.randomId);

  List<String> generateButtonNames() {
    int correctIndex = Random().nextInt(4);
    List<String> buttonNames = List.generate(4, (index) {
      if (index == correctIndex) {
        return pokemonList[randomId].name.capitalize();
      } else {
        int randomIndex;
        do {
          randomIndex = Random().nextInt(pokemonList.length);
        } while (randomIndex == randomId); // Garantir nomes diferentes
        return pokemonList[randomIndex].name.capitalize();
      }
    });
    return buttonNames;
  }

  int updateRandomId() {
    randomId = Random().nextInt(pokemonList.length);
    return randomId;
  }

  bool checkPokemonCorrect(String selected, String correct) {
    if (selected == correct) {
      correctAnswers++;
      print("Correto");
      return true;
    } else {
      incorrectAnswers++;
      print("Errado");
      return false;
    }
  }

  void nextPokemon(BuildContext context) async {
    if (correctAnswers + incorrectAnswers < 10) {
      print("Jogo Continua");
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Stack(
            children: [
              ModalBarrier(
                dismissible: false,
                color: Colors.black.withOpacity(0.6),
              ),
              AlertDialog(
                title: const Text("Quiz Concluído"),
                content: Text(
                    "Você completou o quiz com sucesso! Acertou: $correctAnswers Pokémon!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      resetQuiz();
                      Navigator.of(context).pop();
                    },
                    child: const Text("Restart"),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
  }

  void resetQuiz() {
    correctAnswers = 0;
    incorrectAnswers = 0;
  }
}
