// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 😈 tutor_demoniaco.dart - Orquestrador dos rituais aprovados              ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'avaliador.dart';
import 'promotor.dart';

class TutorDemoniaco {
  final avaliador = Avaliador();
  final promotor = Promotor();

  void inspecionar() {
    final lista = promotor.listarPromoviveis();
    print('🔍 Rituais aprovados: ${lista.join(', ')}');
  }

  void promoverTodos() {
    final lista = promotor.listarPromoviveis();
    for (final ritual in lista) {
      promotor.promover(ritual);
    }
  }

  void relatorioFinal() {
    print('📜 Todos os rituais foram promovidos com sucesso.');
  }
}
