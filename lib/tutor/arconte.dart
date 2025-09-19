// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧭 arconte.dart - Executor extraplanar e validador de plugins              ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';
import 'package:path/path.dart' as p;
import 'escriba.dart';

class Arconte {
  final escriba = Escriba();

  final String recipesPath = 'recipes/';
  final String acervoPath = 'recipes/acervo/';
  final String infernusPath = 'recipes/infernus/';
  final String extraplanarPath = 'extraplanar/';

  void executar() {
    final receitas = _coletarReceitas();
    if (receitas.isEmpty) {
      escriba.aviso('Arconte', 'Nenhuma receita encontrada em /recipes/ ou /recipes/acervo/.');
      return;
    }

    final plugins = _coletarPlugins();
    if (plugins.isEmpty) {
      escriba.aviso('Arconte', 'Nenhum repositório extraplanar encontrado.');
      return;
    }

    for (final plugin in plugins) {
      final nome = p.basenameWithoutExtension(plugin.path);
      final conteudo = plugin.readAsStringSync();

      if (!_estaFinalizado(conteudo)) {
        escriba.erro(nome, 'Plugin extraplanar incompleto ou inválido.');
        _moverPara(infernusPath, plugin);
        continue;
      }

      _moverPara(acervoPath, plugin);
      escriba.sucesso(nome, 'Plugin extraplanar validado e movido para acervo.');
    }
  }

  List<File> _coletarReceitas() {
    final receitasDir = Directory(recipesPath);
    final acervoDir = Directory(acervoPath);

    final arquivos = <File>[];

    if (receitasDir.existsSync()) {
      arquivos.addAll(receitasDir
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.txt')));
    }

    if (acervoDir.existsSync()) {
      arquivos.addAll(acervoDir
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.txt')));
    }

    return arquivos;
  }

  List<File> _coletarPlugins() {
    final dir = Directory(extraplanarPath);
    if (!dir.existsSync()) return [];

    return dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.txt'))
        .toList();
  }

  bool _estaFinalizado(String conteudo) {
    return conteudo.contains('main()') &&
           conteudo.contains('PluginExtraplanar') &&
           !conteudo.contains('TODO') &&
           conteudo.length > 100;
  }

  void _moverPara(String destino, File arquivo) {
    final nome = p.basename(arquivo.path);
    final destinoPath = p.join(destino, nome);

    final dir = Directory(destino);
    if (!dir.existsSync()) dir.createSync(recursive: true);

    arquivo.copySync(destinoPath);
    arquivo.deleteSync();
  }
}
