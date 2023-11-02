import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pokequiz/models/pokemon.dart';
import 'package:pokequiz/services/quiz_services.dart';
import 'package:pokequiz/utils/string_extension.dart';
import 'package:pokequiz/widgets/pokemon_buttons.dart';
import 'package:pokequiz/widgets/pokemon_image.dart';
import 'package:pokequiz/widgets/pokemon_score.dart';

class PokemonQuiz extends StatefulWidget {
  const PokemonQuiz({required this.pokemonList, super.key});
  final List<Pokemon> pokemonList;

  @override
  State<PokemonQuiz> createState() => _PokemonQuizState();
}

class _PokemonQuizState extends State<PokemonQuiz> {
  late int pokemonId;
  bool isQuizFinished = false;

  @override
  void initState() {
    super.initState();
    pokemonId = Random().nextInt(widget.pokemonList.length);
  }

  // atualiza o pokemon
  void updatePokemon() {
    setState(() {
      pokemonId = Random().nextInt(widget.pokemonList.length);
    });
  }

  // reinicia o quiz
  void restartQuiz() {
    setState(() {
      QuizServices.resetScore();
      isQuizFinished = false;
      updatePokemon();
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentPokemon = widget.pokemonList[pokemonId];
    QuizServices quizServices = QuizServices(widget.pokemonList, pokemonId);
    List<String> buttonNames = quizServices.generateButtonNames();

    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        bottom: 12.0,
        left: 20.0,
        right: 20.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //pontuacao
          PokemonScore(
            text01: "Acertos: ${QuizServices.correctAnswers}",
            text02: "Erros: ${QuizServices.incorrectAnswers}",
          ),
          //pokemon card
          PokemonImage(pokemon: currentPokemon),
          //botoes
          for (var i = 0; i < 4; i++)
            PokemonButton(
              text: buttonNames[i],
              function: () {
                setState(() {
                  //verificacao da resposta
                  quizServices.checkPokemonAnswer(
                      buttonNames[i], currentPokemon.name.capitalize());
                });
                // verificacao se o quiz terminou
                if (QuizServices.correctAnswers +
                        QuizServices.incorrectAnswers >=
                    10) {
                  isQuizFinished = true;
                }
                // se o quiz terminou
                if (isQuizFinished) {
                  showDialog(
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
                              "Você completou o quiz com sucesso! Acertou: ${QuizServices.correctAnswers} Pokémon!",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  restartQuiz();
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
                  // se nao terminou
                } else {
                  updatePokemon();
                }
              },
            ),
        ],
      ),
    );
  }
}
