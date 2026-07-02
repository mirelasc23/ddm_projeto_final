import 'package:ddm_projeto_final/model/acesso.dart';
import 'package:ddm_projeto_final/util/dbhelper.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio = Dio(); // Instância interna para fazer o refresh

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. Busca os dados atuais salvos no banco local (SQLite)
    Acesso? sessao = await DatabaseHelper.instance.buscarSessao();

    if (sessao != null) {
      // 2. Se o token estiver expirado, faz o refresh antes de continuar
      if (sessao.precisaDeRefresh) {
        try {
          sessao = await _atualizarTokenFirebase(sessao.refreshToken);
        } catch (e) {
          // Se falhar o refresh (ex: refresh token revogado), força o logout
          await DatabaseHelper.instance.limparSessao();
          // Redirecionar para a tela de login (via gerenciador de estado ou Navigator)
          return handler.reject(
            DioException(
              requestOptions: options,
              error: 'Sessão expirada. Faça login novamente.',
            ),
          );
        }
      }

      // 3. Adiciona o token válido no cabeçalho da requisição atual
      options.headers['Authorization'] = 'Bearer ${sessao!.idToken}';
    }

    return handler.next(options);
  }

  // Função que faz o POST na API REST do Firebase para renovar o token
  Future<Acesso> _atualizarTokenFirebase(String refreshToken) async {
    final apiKey = "SUA_API_KEY_DO_FIREBASE";
    final url = "https://securetoken.googleapis.com/v1/token?key=$apiKey";

    final response = await _dio.post(
      url,
      data: {'grant_type': 'refresh_token', 'refresh_token': refreshToken},
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    if (response.statusCode == 200) {
      final dados = response.data;

      // Calcula o novo tempo de expiração baseado nos segundos retornados (expires_in)
      final segundos = int.parse(dados['expires_in']);
      final novaExpiracao = DateTime.now().add(Duration(seconds: segundos));

      // Atualiza apenas os tokens e o tempo no SQLite, mantendo nome e email intactos
      Acesso novaSessao = await DatabaseHelper.instance.atualizarTokens(
        novoIdToken: dados['id_token'],
        novoRefreshToken: dados['refresh_token'],
        expiraEm: novaExpiracao,
      );

      return novaSessao;
    } else {
      throw Exception('Falha ao atualizar token');
    }
  }
}
