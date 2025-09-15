// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔮 Conjurador Inteligente - Invocador Supremo da VDF┃
// ┃ 🪄 Detecta e executa instrumentos mágicos dinamicamente┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

void main() async {
  final dir = Directory('instrumentos_magicos/');
  final arquivos = dir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart') && !f.path.contains('conjurador.dart'))
      .toList();

  if (arquivos.isEmpty) {
    print('⚠️ Nenhum instrumento mágico encontrado.');
    return;
  }

  print('🔍 Instrumentos mágicos detectados:');
  for (var file in arquivos) {
    final nome = file.uri.pathSegments.last;
    print('🪄 Encontrado: $nome');
  }

  print('\n🔮 Iniciando invocação ritualística...\n');

  for (var file in arquivos) {
    final nome = file.uri.pathSegments.last;
    print('✨ Invocando $nome...');
    final result = await Process.run('dart', [file.path]);

    if (result.exitCode == 0) {
      print('✅ $nome executado com sucesso.');
    } else {
      print('❌ Falha ao executar $nome.');
      print(result.stderr);
    }

    print('─────────────────────────────────────────────');
  }

  print('\n🧙‍♂️ Invocação concluída. Todos os instrumentos foram processados.');
}
