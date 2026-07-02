import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:flutter/material.dart';

Widget caixaTextoExibicao(String label, String valor) {
  return Container(
    width: double.infinity, // Ocupa a largura disponível igual ao input
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    decoration: BoxDecoration(
      // Equivalente ao 'filled: true' e 'fillColor'
      color: const Color.fromRGBO(255, 255, 255, 0.53),
      // Equivalente ao 'borderRadius: BorderRadius.circular(100.0)'
      borderRadius: BorderRadius.circular(100.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // O "Label" menor em cima, simulando o comportamento do input
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
            fontFamily: AppFonts.mairy,
          ),
        ),
        const SizedBox(height: 4),
        // O valor real do dado do usuário
        Text(
          valor,
          style: const TextStyle(
            fontSize: 16,
            color: Color.from(alpha: 1.0, red: 0.13, green: 0.59, blue: 0.95),
            fontFamily: AppFonts.mairy,
          ),
        ),
      ],
    ),
  );
}
