import 'package:flutter/material.dart';
import 'package:pokequiz/models/pokemon.dart';

class PokemonImage extends StatelessWidget {
  const PokemonImage({required this.pokemon, super.key});
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Image.network(pokemon.image),
    );
  }
}
