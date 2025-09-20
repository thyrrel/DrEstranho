// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔮 bin/genesis.dart - Ritual de leitura e invocação de receitas místicas   ┃
// ┃ 📜 Estilo byThyrrel | Vasculha recipe/ | Gera artefatos em artefatos/     ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

void main() {
  final recipeDir = Directory('recipe');
  final outputDir = Directory('artefatos');

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
    final content = file.readAsStringSync();
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

    final output = File('artefatos/$name.dart');
    output.writeAsStringSync(artifact);
    print('✅ Artefato gerado: artefatos/$name.dart');
  }

  print('✨ Ritual concluído com sucesso. Todos os artefatos foram selados.');
}
