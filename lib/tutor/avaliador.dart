// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧪 avaliador.dart - Avaliação ritualística com validação sintática         ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';
import 'ritual_index.dart';
import 'escriba.dart';

class Avaliador {
  final escriba = Escriba();

  void avaliar(String nome) {
    final ritual = ritualIndex[nome];
    if (ritual == null) {
      escriba.aviso(nome, 'Ritual não encontrado.');
      return;
    }

    final conteudo = ritual['conteudo']?.toString() ?? '';
    if (conteudo.trim().isEmpty) {
      ritual['status'] = 'reprovado';
      escriba.erro(nome, 'Conteúdo vazio.');
      return;
    }

    final tempDir = Directory.systemTemp.createTempSync();
    final file = File('${tempDir.path}/$nome.dart');
    file.writeAsStringSync(conteudo);

    final result = Process.runSync('dart', ['analyze', file.path]);
    final aprovado = result.exitCode == 0;

    ritual['status'] = aprovado ? 'aprovado' : 'reprovado';

    if (aprovado) {
      escriba.sucesso(nome, 'Ritual aprovado');
    } else {
      escriba.erro(nome, 'Erro de sintaxe');
    }

    tempDir.deleteSync(recursive: true);
  }

  void avaliarTodos() {
    for (final nome in ritualIndex.keys) {
      avaliar(nome);
    }
  }
}
