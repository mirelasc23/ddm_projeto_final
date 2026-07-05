import 'package:ddm_projeto_final/model/planta.dart';
import 'package:ddm_projeto_final/provider/planta_provider.dart';
import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:ddm_projeto_final/util/util.dart';
import 'package:ddm_projeto_final/widgets/caixa_texto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Modo { cadastro, login }

class FormPlanta extends StatefulWidget {
  const FormPlanta({Key? key}) : super(key: key);

  @override
  State<FormPlanta> createState() => _FormPlantaState();
}

class _FormPlantaState extends State<FormPlanta> {
  final _metaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> _dadosForm = {'nome': '', 'password': ''};

  @override
  Widget build(BuildContext context) {
    Planta planta = ModalRoute.of(context)?.settings.arguments as Planta;
    /*final PlantaProvider plantaProvider = Provider.of<PlantaProvider>(
      context,
      listen: false,
    );*/

    //final planta = plantaProvider.plantaAtual;

    return Container(
      padding: const EdgeInsets.all(30),
      child: Form(
        key: _formKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 148, 186, 1.0),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 75.0,
                          backgroundImage: AssetImage(
                            'assets/images/foto-perfil.png',
                          ),
                        ),
                      ),
                      caixaTextoExibicao('Nome', planta.nome),
                      caixaTextoExibicao('Latitude', planta.lat.toString()),
                      caixaTextoExibicao('Longitude', planta.long.toString()),
                      const SizedBox(height: 40),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Meta de água (mL)',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.4,
                                color: Color.fromRGBO(70, 120, 148, 1.0),
                                fontFamily: AppFonts.childos,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 22),
                            child: TextFormField(
                              controller: _metaController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '2500',
                                filled: true,
                                fillColor: const Color.fromRGBO(
                                  255,
                                  255,
                                  255,
                                  0.53,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  borderSide: const BorderSide(
                                    color: Color.from(
                                      alpha: 1.0,
                                      red: 0.13,
                                      green: 0.59,
                                      blue: 0.95,
                                    ),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              style: Util.estiloTextoInterno(),
                              onTapOutside: (PointerDownEvent event) {
                                FocusScope.of(context).unfocus();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe a meta de água';
                                }
                                final meta = int.tryParse(value);
                                if (meta == null || meta <= 0) {
                                  return 'Informe um valor válido';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Tooltip(
                        message: 'Dados salvos localmente no SQLite.',
                        triggerMode: TooltipTriggerMode.tap,
                        preferBelow: false,
                        child: IconButton(
                          icon: const Icon(
                            Icons.info_rounded,
                            color: Colors.red,
                          ),
                          onPressed: null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
