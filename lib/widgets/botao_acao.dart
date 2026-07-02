import 'package:flutter/material.dart';
import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:dotted_border/dotted_border.dart';

class BotaoAcao extends StatelessWidget {
  final String imagem;
  final String label;
  final Color cor;
  final VoidCallback onTap;
  final double tamanho;

  const BotaoAcao({
    Key? key,
    required this.imagem,
    required this.label,
    this.cor = Colors.white,
    required this.onTap,
    this.tamanho = 175,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        options: CircularDottedBorderOptions(
          color: cor,
          strokeWidth: 1.3,
          dashPattern: const [6, 5],
          padding: const EdgeInsets.all(0.1),
        ),
        child: Container(
          width: tamanho,
          height: tamanho,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // border: Border.all(color: cor, width: 2, style: BorderStyle.solid),
            image: DecorationImage(
              image: AssetImage(imagem),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: AppFonts.childos,
                  color: cor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          // const SizedBox(height: 6),
          // Text(
          //   label,
          //   style: const TextStyle(
          //     color: Colors.blueGrey,
          //     fontWeight: FontWeight.w600,
          //   ),
        ),
      ),
    );
  }
}
