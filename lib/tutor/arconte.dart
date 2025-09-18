// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧭 arconte.dart - Inspeção de repositórios extraplanares                  ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';
import 'package:path/path.dart' as p;
import 'escriba.dart';

class Arconte {
  final String origem = 'extraplanar/';
  final String destino = 'recipes/lidos/';
  final escriba = Escriba();

  void inspecionar() {
    final dir = Directory(origem);
    if (!dir.existsSync()) {
      escriba.aviso('Arconte', 'Pasta extraplanar não encontrada.');
      return;
    }

    final arquivos = dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.txt'));

    for (final arquivo in arquivos) {
      final nome = p.basename(arquivo.path);
      final destinoPath = '$destino$nome';

      final jaLido = File(destinoPath).existsSync();
      final conteudo = arquivo.readAsStringSync();

      if (jaLido) {
        escriba.aviso(nome, 'Já existe em recipes/lidos/');
        continue;
      }

      if (!conteudo.contains('main()')) {
        escriba.erro(nome, 'Conteúdo inadequado: ausência de main()');
        continue;
      }

      File(destinoPath).writeAsStringSync(conteudo);
      escriba.sucesso(nome, 'Copiado para recipes/lidos/');
    }
  }
}
