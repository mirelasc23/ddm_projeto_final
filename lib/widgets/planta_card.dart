import 'package:flutter/material.dart';
import 'package:ddm_projeto_final/model/planta.dart';
import 'package:ddm_projeto_final/model/rega.dart';

// Ajuste este import para o local real do seu DAO/repositório
// import 'package:ddm_projeto_final/dao/rega_dao.dart';

/// Widget que exibe os dados de uma [Planta] e sua última [Rega].
/// Use [PlantaCardSheet.mostrar] para abrir como bottom sheet.
class PlantaCardSheet extends StatelessWidget {
  final Planta planta;

  const PlantaCardSheet({super.key, required this.planta});

  /// Abre o card como um bottom sheet. Chame assim na tela_mapa:
  /// PlantaCardSheet.mostrar(context, planta);
  static void mostrar(BuildContext context, Planta planta) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => PlantaCardSheet(planta: planta),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem da planta
          if (planta.imagem != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                planta.imagem!,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 140,
                  color: Colors.green.shade50,
                  child: const Icon(
                    Icons.local_florist,
                    size: 48,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 16),

          // Nome da planta
          Text(
            planta.nome,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),

          // Localização (lat/long)
          Row(
            children: [
              Icon(Icons.place, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                '${planta.lat.toStringAsFixed(5)}, '
                '${planta.long.toStringAsFixed(5)}',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ],
          ),

          const Divider(height: 28),

          // Última rega (busca assíncrona no banco)
          FutureBuilder<Rega?>(
            future: _buscarUltimaRega(planta.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }

              final rega = snapshot.data;
              if (rega == null) {
                return Row(
                  children: [
                    Icon(
                      Icons.water_drop_outlined,
                      size: 18,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Nenhuma rega registrada',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                );
              }

              final data = DateTime.parse(rega.dataRega);
              final dias = DateTime.now().difference(data).inDays;

              return Row(
                children: [
                  const Icon(Icons.water_drop, size: 18, color: Colors.blue),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Última rega',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        '${data.day.toString().padLeft(2, '0')}/'
                        '${data.month.toString().padLeft(2, '0')}/'
                        '${data.year} '
                        '(há $dias dia${dias == 1 ? '' : 's'})',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Busca a rega mais recente da planta.
  // Ajuste para usar seu DAO/repositório real (sqflite, etc).
  static Future<Rega?> _buscarUltimaRega(int idPlanta) async {
    // Exemplo:
    // final regas = await RegaDao().listarPorPlanta(idPlanta);
    // regas.sort((a, b) => b.dataRega.compareTo(a.dataRega));
    // return regas.isNotEmpty ? regas.first : null;
    throw UnimplementedError('Conecte este método ao seu DAO de Rega');
  }
}
