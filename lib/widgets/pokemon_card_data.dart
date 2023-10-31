import 'package:flutter/material.dart';
import 'package:pokequiz/models/pokemon.dart';

class PokemonCardData extends StatelessWidget {
  const PokemonCardData({required this.pokemon, super.key});
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Image.network(pokemon.image),
    );
  }
}
