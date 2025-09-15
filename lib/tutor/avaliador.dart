// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧠 Avaliador - Validador ritualístico da VDF         ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'ritual_index.dart';

class Avaliador {
  void avaliarTodos() {
    ritualIndex.forEach((nome, dados) {
      final testado = dados['testado'] == true;
      final log = dados['log'] == true;
      final descricao = dados['descricao']?.isNotEmpty ?? false;

      if (testado && log && descricao) {
        dados['status'] = 'pronto';
        print('✅ Ritual "$nome" validado como pronto.');
      } else {
        dados['status'] = 'em_validacao';
        print('🔄 Ritual "$nome" permanece em validação.');
      }
    });
  }

  void avaliarRitual(String nome) {
    final dados = ritualIndex[nome];
    if (dados == null) {
      print('❌ Ritual "$nome" não encontrado.');
      return;
    }

    final testado = dados['testado'] == true;
    final log = dados['log'] == true;
    final descricao = dados['descricao']?.isNotEmpty ?? false;

    if (testado && log && descricao) {
      dados['status'] = 'pronto';
      print('✅ Ritual "$nome" validado como pronto.');
    } else {
      dados['status'] = 'em_validacao';
      print('🔄 Ritual "$nome" permanece em validação.');
    }
  }
}
