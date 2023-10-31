import 'dart:math';
import 'package:pokequiz/models/pokemon.dart';
import 'package:pokequiz/utils/string_extension.dart';

class QuizServices {
  final List<Pokemon> pokemonList;
  int pokemon;
  static int correctAnswers = 0;
  static int incorrectAnswers = 0;

  QuizServices(this.pokemonList, this.pokemon);

  List<String> generateButtonNames() {
    int correctIndex = Random().nextInt(4);
    List<String> buttonNames = List.generate(4, (index) {
      if (index == correctIndex) {
        return pokemonList[pokemon].name.capitalize();
      } else {
        int randomIndex;
        do {
          randomIndex = Random().nextInt(pokemonList.length);
        } while (randomIndex == pokemon); // Garantir nomes diferentes
        return pokemonList[randomIndex].name.capitalize();
      }
    });
    return buttonNames;
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

  static void resetScore() {
    correctAnswers = 0;
    incorrectAnswers = 0;
  }
}
