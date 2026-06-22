import 'package:flutter/material.dart';

class BotaoLogin extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;

  const BotaoLogin({super.key, required this.texto, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        backgroundColor: Colors.grey[200],
      ),
      child: Text(texto),
    );
  }
}
