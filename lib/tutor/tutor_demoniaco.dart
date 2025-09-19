// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔱 tutor_demoniaco.dart - Orquestrador dos rituais aprovados              ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'avaliador.dart';
import 'promotor.dart';

class TutorDemoniaco {
  final avaliador = Avaliador();
  final promotor = Promotor();

  void promoverTodos() {
    avaliador.avaliarTodos();
    final lista = promotor.listarPromoviveis();
    for (final ritual in lista) {
      promotor.promover(ritual);
    }
  }
}
