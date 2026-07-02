import 'package:flutter/material.dart';

Widget botaoSaibaMais(BuildContext context, String titulo, String explicacao) {
  return IconButton(
    icon: const Icon(Icons.info_outline, color: Color(0xFF2196F3)),
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20.0,
              ), // Cantos arredondados combinando com seu app
            ),
            title: Text(
              titulo,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(explicacao),
            actions: [
              TextButton(
                child: const Text('Entendi'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o Alerta
                },
              ),
            ],
          );
        },
      );
    },
  );
}
