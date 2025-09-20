// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ ⚙️ bin/genesis.dart - Varredura de plugins e geração de rituais txt       ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

void main(List<String> args) async {
  final pluginList = [
    'plugin_meteorico',
    'plugin_abissal',
    'plugin_aurora',
    'plugin_sintetico',
  ];

  final destino = Directory('recipe');
  destino.createSync(recursive: true);

  for (final repo in pluginList) {
    final ritual = File('recipe/$repo.txt');
    if (ritual.existsSync()) {
      print('⚠️ Ritual já existe: ${ritual.path}');
      continue;
    }

    final buffer = StringBuffer()
      ..writeln('tipo: plugin')
      ..writeln('autor: sistema')
      ..writeln('conteudo: >')
      ..writeln('  Acione o repositório "$repo" como extensão ritualística.')
      ..writeln('  Este plugin deve ser invocado com parâmetros padrão.')
      ..writeln('  Verifique compatibilidade com artefatos em LIMBO.');

    ritual.writeAsStringSync(buffer.toString());
    print('✅ Ritual criado: ${ritual.path}');
  }
}
