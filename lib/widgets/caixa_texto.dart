import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

Widget caixaTextoExibicao(String label, String valor) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Text(
          label,
          //style: Te,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w100,
            letterSpacing: 0.4,
            //height: 1.33,
            //color: const Color.fromRGBO(255, 255, 255, 0.53),
            color: Color.fromARGB(188, 158, 158, 158),
            fontFamily: AppFonts.mairy,
          ),
        ),
      ),
      // A caixa estilizada contendo apenas o valor
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.53),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Text(
          valor,
          style: const TextStyle(
            fontSize: 16,
            color: Color.from(alpha: 1.0, red: 0.13, green: 0.59, blue: 0.95),
            fontFamily: AppFonts.mairy,
          ),
        ),
      ),
    ],
  );
}
