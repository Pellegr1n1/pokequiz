import 'package:flutter/material.dart';

class PokemonButton extends StatelessWidget {
  final String text;
  final VoidCallback function;

  const PokemonButton({required this.text, required this.function, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          onPressed: function,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 22.0),
          ),
        ),
      ),
    );
  }
}
