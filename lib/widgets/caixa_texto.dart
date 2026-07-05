import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:ddm_projeto_final/util/util.dart';
import 'package:flutter/material.dart';

Widget caixaTextoExibicao(String label, String valor) {
  return Stack(
    children: [
      Align(
        alignment: Alignment.topCenter,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4,
            color: Color.fromRGBO(70, 120, 148, 1.0),
            fontFamily: AppFonts.childos,
          ),
        ),
      ),
      Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.53),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Text(valor, style: Util.estiloTextoInterno()),
      ),
    ],
  );
}
