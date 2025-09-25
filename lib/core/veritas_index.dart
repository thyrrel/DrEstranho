// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 📜 VeritasIndex - Leitor do tomo Magna_Veritas                       ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:convert';
import 'dart:io';

class VeritasIndex {
  final String caminhoTomo = 'magna_veritas.json';

  /// Lê o tomo Magna_Veritas e retorna um mapa dimensional dos instrumentos ativos
  Map<String, List<String>> mapearInstrumentosPorDimensao() {
    final arquivo = File(caminhoTomo);

    if (!arquivo.existsSync()) {
      print('⛔ Tomo "$caminhoTomo" não encontrado.');
      return {};
    }

    final conteudo = jsonDecode(arquivo.readAsStringSync());
    final dimensoes = List<String>.from(conteudo['dimensoes']);
    final instrumentos = List<Map<String, dynamic>>.from(conteudo['instrumentos']);

    final mapa = <String, List<String>>{};
    for (final dimensao in dimensoes) {
      mapa[dimensao] = [];
    }

    for (final instrumento in instrumentos) {
      final branch = instrumento['branch'];
      final nome = instrumento['nome'];
      final status = instrumento['status'];
      final invocavel = instrumento['invocavel'];

      if (status == 'ativo' && invocavel == true) {
        final destino = _resolverDimensao(branch, dimensoes);
        if (destino != null) {
          mapa[destino]?.add(nome);
        }
      }
    }

    return mapa;
  }

  /// Resolve a dimensão correspondente à branch
  String? _resolverDimensao(String branch, List<String> dimensoes) {
    final normalizado = branch.toLowerCase();
    for (final dimensao in dimensoes) {
      if (normalizado.contains(dimensao.toLowerCase().replaceAll('-', '_'))) {
        return dimensao;
      }
    }
    return null;
  }
}
