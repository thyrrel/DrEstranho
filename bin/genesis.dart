// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔮 bin/genesis.dart - Ritual de leitura e invocação de receitas místicas   ┃
// ┃ 📜 Estilo byThyrrel | Vasculha recipe/ | Gera artefatos em artefatos/     ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

void main() {
  final recipeDir = Directory('recipe');
  final outputDir = Directory('artefatos');

  print('🔍 Iniciando ritual de invocação...');
  print('📦 Vasculhando pasta: ${recipeDir.path}');

  if (!recipeDir.existsSync()) {
    print('❌ Pasta recipe/ não encontrada. Ritual abortado.');
    exit(1);
  }

  outputDir.createSync(recursive: true);

  final recipeFiles = recipeDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.txt'))
      .toList();

  if (recipeFiles.isEmpty) {
    print('⚠️ Nenhum arquivo de receita encontrado. Nada será invocado.');
    exit(0);
  }

  for (final file in recipeFiles) {
    final content = file.readAsStringSync().trim();
    final name = file.uri.pathSegments.last.replaceAll('.txt', '');
    final artifact = '''
// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧱 Artefato: $name.dart - Invocado a partir de recipe/$name.txt           ┃
// ┃ 🔮 Conteúdo original preservado abaixo                                    ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

void conjurar_$name() {
  print("🔮 Invocando: $name");
  print(\"\"\"$content\"\"\");
}
''';

    final output = File('${outputDir.path}/$name.dart');
    output.writeAsStringSync(artifact);
    print('✅ Artefato selado: ${output.path}');
  }

  print('✨ Ritual concluído com sucesso. Todos os artefatos foram invocados e selados.');
}
