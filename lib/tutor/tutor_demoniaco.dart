// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 😈 TutorDemoníaco - Guardião supremo da VDF         ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'ritual_index.dart';
import 'avaliador.dart';
import 'promotor.dart';

class TutorDemoníaco {
  final Avaliador _avaliador = Avaliador();
  final Promotor _promotor = Promotor();

  void inspecionar() {
    print('🔍 TutorDemoníaco inicia inspeção ritualística...');
    _avaliador.avaliarTodos();
  }

  void promoverTodos() {
    print('\n🔱 TutorDemoníaco executa promoção dos rituais prontos...');
    final promoviveis = _promotor.listarPromoviveis();

    if (promoviveis.isEmpty) {
      print('⚠️ Nenhum ritual está pronto para promoção.');
      return;
    }

    for (var ritual in promoviveis) {
      _promotor.promover(ritual);
    }
  }

  void relatorioFinal() {
    print('\n📜 Relatório final dos rituais:');
    ritualIndex.forEach((nome, dados) {
      print('• $nome → status: ${dados['status']} | autor: ${dados['autor']}');
    });
  }
}
