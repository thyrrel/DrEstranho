// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔮 Conjurador Dimensional - ExtraPlanares                                                ┃
// ┃ 📜 Detecta e invoca artefatos em extraplanar/ dinamicamente                              ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

void main() async {
  final dir = Directory('extraplanar/');
  final arquivos = await dir.list(recursive: false).toList();

  final rituais = arquivos
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart') && File(f.path).existsSync())
      .toList();

  if (rituais.isEmpty) {
    print('⚠️ Nenhum ritual extraplanar detectado.');
    return;
  }

  print('🔍 Rituais detectados:');
  for (var file in rituais) {
    final nome = file.uri.pathSegments.last;
    print('🪄 $nome');
  }

  print('\n🌌 Iniciando invocação dimensional...\n');

  for (var file in rituais) {
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

  print('\n🌌 Invocação dimensional concluída.');
}
