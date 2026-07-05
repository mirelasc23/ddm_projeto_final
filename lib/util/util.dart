import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:flutter/material.dart';

class Util {
  static InputDecoration estiloInput(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color.fromRGBO(255, 255, 255, 0.53),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.0),
        borderSide: const BorderSide(
          color: Color.from(alpha: 1.0, red: 0.13, green: 0.59, blue: 0.95),
          width: 1.5,
        ),
      ),
    );
  }

  static TextStyle estiloTextoInterno() {
    return TextStyle(
      fontSize: 16,
      color: Color.from(alpha: 1.0, red: 0.13, green: 0.59, blue: 0.95),
      fontFamily: AppFonts.mairy,
    );
  }
}
