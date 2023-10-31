import 'package:flutter/material.dart';

class PokemonScore extends StatefulWidget {
  final String text01;
  final String text02;

  const PokemonScore({required this.text01, required this.text02, super.key});

  @override
  State<PokemonScore> createState() => _PokemonScoreState();
}

class _PokemonScoreState extends State<PokemonScore> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          widget.text01,
          style: const TextStyle(fontSize: 22),
        ),
        Text(
          widget.text02,
          style: const TextStyle(fontSize: 22),
        ),
      ],
    );
  }
}
