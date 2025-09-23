// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔮 Rituais - Executor do Grimório                   ┃
// ┃ 🧙‍♂️ Invoca todos os instrumentos em instrumentos/   ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

void main() async {
  final dir = Directory('rituais/');
  final arquivos = await dir.list(recursive: false).toList();

  final instrumentos = arquivos
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart') && File(f.path).existsSync())
      .toList();

  if (instrumentos.isEmpty) {
    print('⚠️ Nenhum Ritual encontrado em rituais/.');
    return;
  }

  print('🔮 Invocando rituais consagrados:\n');

  for (var file in instrumentos) {
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

  print('\n🧙‍♂️ Todos os Rituais foram invocados.');
}
