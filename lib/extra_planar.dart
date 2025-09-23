// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔮 Conjurador Inteligente - VDF                               ┃
// ┃ 🧙‍♂️ Detecta e invoca ExtraPlanares dinamicamente               ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

void main() async {
  final dir = Directory('extraplanar/');
  final arquivos = await dir.list(recursive: false).toList();

  final extraplanar = arquivos
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart') && File(f.path).existsSync())
      .toList();

  if (instrumentos.isEmpty) {
    print('⚠️ Nenhum ectraplanar encontrado.');
    return;
  }

  print('🔍 ExtraPlanar detectados:');
  for (var file in extraplanar) {
    final nome = file.uri.pathSegments.last;
    print('🪄 $nome');
  }

  print('\n🔮 Iniciando invocação ritualística...\n');

  for (var file in extraplanar) {
    final nome = file.uri.pathSegments.last;
    print('✨ Invocando $nome...');
    try {
      final result = await Process.run('dart', [file.path]);

      if (result.exitCode == 0) {
        print('✅ $nome executado com sucesso.');
        if (result.stdout.toString().trim().isNotEmpty) {
          print('📜 Saída:\n${result.stdout}');
        }
      } else {
        print('❌ Falha ao executar $nome.');
        print('🧾 Erro:\n${result.stderr}');
      }
    } catch (e) {
      print('💥 Erro ao invocar $nome: $e');
    }

    print('─────────────────────────────────────────────');
  }

  print('\n🧙‍♂️ Invocação concluída.');
}
