import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokequiz/models/pokemon.dart';
import 'package:pokequiz/services/quiz_services.dart';
import 'package:pokequiz/utils/string_extension.dart';
import 'package:pokequiz/widgets/pokemon_buttons.dart';
import 'package:pokequiz/widgets/pokemon_card_data.dart';
import 'package:pokequiz/widgets/pokemon_score.dart';

class PokemonQuiz extends StatefulWidget {
  const PokemonQuiz({required this.pokemonList, super.key});
  final List<Pokemon> pokemonList;

  @override
  State<PokemonQuiz> createState() => _PokemonQuizState();
}

class _PokemonQuizState extends State<PokemonQuiz> {
  late int randomId = Random().nextInt(widget.pokemonList.length);
  @override
  Widget build(BuildContext context) {
    var randomPokemon = widget.pokemonList[randomId];
    QuizServices quizServices = QuizServices(widget.pokemonList, randomId);
    List<String> buttonNames = quizServices.generateButtonNames();
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, bottom: 12.0, left: 20.0, right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PokemonScore(
              text01: "Acertos: ${QuizServices.correctAnswers}",
              text02: "Erros: ${QuizServices.incorrectAnswers}"),
          PokemonCardData(pokemon: randomPokemon),
          for (var i = 0; i < 4; i++)
            PokemonButton(
              text: buttonNames[i],
              function: () {
                setState(
                  () {
                    quizServices.checkPokemonCorrect(
                        buttonNames[i], randomPokemon.name.capitalize());
                  },
                );
                quizServices.nextPokemon(context);
              },
            ),
        ],
      ),
    );
  }
}
