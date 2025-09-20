// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ ⚙️ bin/genesis.dart - Ritual mínimo para geração e validação de artefatos ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

void main() async {
  final recipeDir = Directory('recipe');
  if (!recipeDir.existsSync()) {
    recipeDir.createSync(recursive: true);
    File('recipe/exemplo.txt').writeAsStringSync('Ritual de exemplo\nLinha 2\nLinha 3');
  }

  final artefatosDir = Directory('artefatos')..createSync(recursive: true);

  final arquivos = recipeDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) =>
          f.path.endsWith('.txt') &&
          !f.path.contains('_infernus') &&
          !f.path.contains('/acervo/'))
      .toList();

  for (final ritualFile in arquivos) {
    final nome = ritualFile.uri.pathSegments.last.replaceAll('.txt', '');
    final artefato = File('artefatos/$nome.dart');
    final linhas = ritualFile.readAsLinesSync();

    final buffer = StringBuffer()
      ..writeln('// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓')
      ..writeln('// ┃ 🔮 Artefato: $nome.dart - Gerado a partir do ritual $nome     ┃')
      ..writeln('// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛')
      ..writeln('')
      ..writeln('void main() {')
      ..writeln("  print('🧙 Executando ritual: $nome');")
      ..writeln("  print('━' * 50);");

    for (var i = 0; i < linhas.length; i++) {
      final linha = linhas[i].trim().replaceAll("'", "\\'");
      if (linha.isNotEmpty) {
        buffer.writeln("  print('📜 Passo ${i + 1}: $linha');");
      }
    }

    buffer
      ..writeln("  print('━' * 50);")
      ..writeln("  print('✨ Ritual $nome concluído com sucesso!');")
      ..writeln('}')
      ..writeln('')
      ..writeln("String getArtefatoInfo() => 'Artefato $nome - Gerado automaticamente';");

    artefato.writeAsStringSync(buffer.toString());

    final result = await Process.run('dart', ['analyze', artefato.path]);
    if (result.exitCode != 0) {
      stderr.writeln('⚠️  Análise de $nome: ${result.stdout}');
    }
  }
}

// Sugestões
// - 🛡️ Adicionar tratamento para erros de leitura e escrita
// - 🔤 Permitir personalização do cabeçalho do artefato
// - 📦 Integrar com sistema de versionamento dos artefatos
// - 🧩 Criar modo de simulação sem escrita em disco
// - 🎨 Exibir progresso visual em interface web ou CLI

// ✍️ byThyrrel  
// 💡 Código formatado com estilo técnico, seguro e elegante  
// 🧪 Ideal para conjuradores de código com foco em automação limpa e confiável
