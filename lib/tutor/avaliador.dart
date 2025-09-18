// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧪 avaliador.dart - Avalia rituais e define aprovação ritualística         ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'ritual_index.dart';

class Avaliador {
  void avaliar(String nome) {
    final ritual = ritualIndex[nome];
    if (ritual == null) {
      print('⚠️ Ritual não encontrado: $nome');
      return;
    }

    // 🔍 Lógica de avaliação simples
    final conteudo = ritual['conteudo'] ?? '';
    final aprovado = conteudo.contains('invocação') || conteudo.length > 50;

    ritual['status'] = aprovado ? 'aprovado' : 'reprovado';

    print(aprovado
        ? '✅ Ritual aprovado: $nome'
        : '❌ Ritual reprovado: $nome');
  }

  void avaliarTodos() {
    for (final nome in ritualIndex.keys) {
      avaliar(nome);
    }
  }
}
