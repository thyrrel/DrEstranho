// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔮 Conjurador Inteligente - VDF                                                          ┃
// ┃ 🧙‍♂️ Detecta e invoca instrumentos mágicos dinamicamente em rituais/                       ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

void main() async {
  final dir = Directory('rituais/');
  final arquivos = await dir.list(recursive: false).toList();

  final instrumentos = arquivos
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart') && File(f.path).existsSync())
      .toList();

  if (instrumentos.isEmpty) {
    print('⚠️ Nenhum ritual encontrado em rituais/.');
    return;
  }

  print('🔍 Rituais detectados:');
  for (var file in instrumentos) {
    final nome = file.uri.pathSegments.last;
    print('🪄 $nome');
  }

  print('\n🔮 Iniciando invocação ritualística...\n');

  for (var file in instrumentos) {
    final nome = file.uri.pathSegments.last;
    print('✨ Invocando $nome...');
    try {
      final result = await Process.run('dart', [file.path]);

      if (result.exitCode == 0) {
        print('✅ $nome executado com sucesso.');
        final saida = result.stdout.toString().trim();
        if (saida.isNotEmpty) {
          print('📖 Saída:\n$saida');
        }
      } else {
        print('❌ Falha ao executar $nome.');
        final erro = result.stderr.toString().trim();
        if (erro.isNotEmpty) {
          print('🧾 Erro:\n$erro');
        }
      }
    } catch (e) {
      print('💥 Erro ao invocar $nome: $e');
    }

    print('─────────────────────────────────────────────');
  }

  print('\n🧙‍♂️ Invocação concluída.');
}
