import 'package:flutter/material.dart';
import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:dotted_border/dotted_border.dart';

class BotaoAcao extends StatefulWidget {
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
  State<BotaoAcao> createState() => _BotaoAcaoState();
}

class _BotaoAcaoState extends State<BotaoAcao> {
  bool _pressionado = false;

  void _setPressionado(bool valor) => setState(() {
    _pressionado = valor;
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _setPressionado(true),
      onTapUp: (_) => _setPressionado(false),
      onTapCancel: () => _setPressionado(false),
      child: AnimatedScale(
        scale: _pressionado ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: DottedBorder(
          options: CircularDottedBorderOptions(
            color: widget.cor,
            strokeWidth: 1.3,
            dashPattern: const [6, 5],
            padding: const EdgeInsets.all(0.1),
          ),
          child: Container(
            width: widget.tamanho,
            height: widget.tamanho,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // border: Border.all(color: cor, width: 2, style: BorderStyle.solid),
              image: DecorationImage(
                image: AssetImage(widget.imagem),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(_pressionado ? 0.08 : 0.12),
                  blurRadius: _pressionado ? 6 : 12,
                  offset: Offset(0, _pressionado ? 2: 6),
                )
              ]
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: AppFonts.childos,
                    color: widget.cor,
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
      ),
    );
  }
}
