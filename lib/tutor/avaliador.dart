// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧪 avaliador.dart - Avaliação ritualística com validação sintática         ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';
import 'ritual_index.dart';

class Avaliador {
  void avaliar(String nome) {
    final ritual = ritualIndex[nome];
    if (ritual == null) {
      print('⚠️ Ritual não encontrado: $nome');
      return;
    }

    final conteudo = ritual['conteudo']?.toString() ?? '';
    if (conteudo.trim().isEmpty) {
      ritual['status'] = 'reprovado';
      print('❌ Ritual vazio: $nome');
      return;
    }

    // Gerar artefato temporário
    final tempDir = Directory.systemTemp.createTempSync();
    final file = File('${tempDir.path}/$nome.dart');
    file.writeAsStringSync(conteudo);

    // Validar com dart analyze
    final result = Process.runSync('dart', ['analyze', file.path]);

    final aprovado = result.exitCode == 0;

    ritual['status'] = aprovado ? 'aprovado' : 'reprovado';

    print(aprovado
        ? '✅ Ritual aprovado: $nome'
        : '❌ Ritual com erro de sintaxe: $nome');

    tempDir.deleteSync(recursive: true);
  }

  void avaliarTodos() {
    for (final nome in ritualIndex.keys) {
      avaliar(nome);
    }
  }
}
