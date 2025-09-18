// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔱 promotor.dart - Promove rituais e gera artefatos mágicos               ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';
import 'ritual_index.dart';

class Promotor {
  List<String> listarPromoviveis() {
    return ritualIndex.entries
        .where((entry) => entry.value['status'] == 'aprovado')
        .map((entry) => entry.key)
        .toList();
  }

  void promover(String nome) {
    final dados = ritualIndex[nome];
    if (dados == null) return;

    final artefato = '''
// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ ✨ Artefato gerado: $nome                                                  ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

void main() {
  print("🔮 Ritual: $nome | Autor: ${dados['autor']}");
}
''';

    final dir = Directory('artefatos');
    if (!dir.existsSync()) dir.createSync(recursive: true);

    final file = File('artefatos/$nome.dart');
    file.writeAsStringSync(artefato);

    print('✅ Artefato promovido: ${file.path}');
  }
}
