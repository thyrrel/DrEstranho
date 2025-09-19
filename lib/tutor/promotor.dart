// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 📁 promotor.dart - Geração de artefatos a partir de rituais aprovados     ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';
import 'ritual_index.dart';
import 'escriba.dart';

class Promotor {
  final String pastaArtefatos = 'artefatos';
  final escriba = Escriba();

  List<String> listarPromoviveis() {
    return ritualIndex.entries
        .where((entry) => entry.value['status'] == 'aprovado')
        .map((entry) => entry.key)
        .toList();
  }

  void promover(String nome) {
    final dados = ritualIndex[nome];
    if (dados == null) {
      escriba.aviso(nome, 'Ritual não encontrado.');
      return;
    }

    final conteudo = dados['conteudo']?.toString() ?? '';
    if (conteudo.trim().isEmpty) {
      escriba.erro(nome, 'Conteúdo vazio.');
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

    escriba.sucesso(nome, 'Artefato gerado');
  }
}
