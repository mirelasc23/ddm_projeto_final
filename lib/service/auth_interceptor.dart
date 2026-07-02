import 'package:ddm_projeto_final/model/acesso.dart';
import 'package:ddm_projeto_final/util/dbhelper.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio = Dio();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    Acesso? sessao = await DatabaseHelper.instance.buscarSessao();

    if (sessao != null) {
      if (sessao.precisaDeRefresh) {
        try {
          sessao = await _atualizarTokenFirebase(sessao.refreshToken);
        } catch (e) {
          await DatabaseHelper.instance.limparSessao();
          return handler.reject(
            DioException(
              requestOptions: options,
              error: 'Sessão expirada. Faça login novamente.',
            ),
          );
        }
      }
      options.headers['Authorization'] = 'Bearer ${sessao.idToken}';
    }
    return handler.next(options);
  }

  Future<Acesso> _atualizarTokenFirebase(String refreshToken) async {
    final apiKey = "AIzaSyCNTlB_qCE1fi_hyQdQZeY_hEPI2xzzCFs";
    final url = "https://securetoken.googleapis.com/v1/token?key=$apiKey";

    final response = await _dio.post(
      url,
      data: {'grant_type': 'refresh_token', 'refresh_token': refreshToken},
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    if (response.statusCode == 200) {
      final dados = response.data;

      final segundos = int.parse(dados['expires_in']);
      final novaExpiracao = DateTime.now().add(Duration(seconds: segundos));

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
