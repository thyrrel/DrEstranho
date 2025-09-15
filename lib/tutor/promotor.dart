// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔱 Promotor - Executor da vontade do TutorDemoníaco ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'ritual_index.dart';

class Promotor {
  List<String> listarPromoviveis() {
    return ritualIndex.entries
        .where((e) =>
            e.value['status'] == 'pronto' &&
            e.value['testado'] == true &&
            e.value['log'] == true)
        .map((e) => e.key)
        .toList();
  }

  void promover(String nome) {
    final ritual = ritualIndex[nome];
    if (ritual == null) {
      print('❌ Ritual "$nome" não encontrado.');
      return;
    }

    if (ritual['status'] == 'pronto' &&
        ritual['testado'] == true &&
        ritual['log'] == true) {
      print('✅ Ritual "$nome" promovido ao grimório principal.');
      // Aqui tu moveria o arquivo para lib/rituais/ no main
    } else {
      print('⛔ Ritual "$nome" ainda não cumpre os requisitos.');
    }
  }
}
