// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔱 promotor.dart - Promove rituais e gera artefatos mágicos               ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';
import 'ritual_index.dart';

class Promotor {
  final String pastaArtefatos = 'artefatos';

  List<String> listarPromoviveis() {
    return ritualIndex.entries
        .where((entry) => entry.value['status'] == 'aprovado')
        .map((entry) => entry.key)
        .toList();
  }

  void promover(String nome) {
    final dados = ritualIndex[nome];
    if (dados == null) {
      print('⚠️ Ritual não encontrado: $nome');
      return;
    }

    final conteudo = dados['conteudo']?.toString() ?? '';
    if (conteudo.trim().isEmpty) {
      print('⚠️ Ritual vazio: $nome');
      return;
    }

    final artefato = '''
// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ ✨ Artefato gerado: $nome                                                  ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

$conteudo
''';

    final dir = Directory(pastaArtefatos);
    if (!dir.existsSync()) dir.createSync(recursive: true);

    final file = File('$pastaArtefatos/$nome.dart');
    file.writeAsStringSync(artefato);

    print('✅ Artefato promovido: ${file.path}');
  }

  void promoverTodos() {
    final lista = listarPromoviveis();
    for (final nome in lista) {
      promover(nome);
    }
  }
}
