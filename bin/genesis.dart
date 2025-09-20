import 'dart:io';

void main() {
  final dir = Directory('recipe');
  if (!dir.existsSync()) {
    print('⚠️ Pasta recipe/ não encontrada.');
    exit(0);
  }

  final arquivos = dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) =>
          f.path.endsWith('.txt') &&
          !f.path.contains('infernus.txt') &&
          !f.path.contains('/acervo/'));

  if (arquivos.isEmpty) {
    print('⚠️ Nenhum ritual encontrado.');
    exit(0);
  }

  for (final ritualFile in arquivos) {
    final nome = ritualFile.uri.pathSegments.last.replaceAll('.txt', '');
    final artefato = File('artefatos/$nome.dart');
    artefato.createSync(recursive: true);

    final conteudo = ritualFile.readAsLinesSync();
    final buffer = StringBuffer()
      ..writeln('// 🔮 Artefato: $nome.dart - Gerado a partir do ritual $nome')
      ..writeln('void main() {')
      ..writeln("  print('🧙 Executando ritual: $nome');");

    for (final linha in conteudo) {
      buffer.writeln("  print('📜 ${linha.replaceAll("'", "\\'")}');");
    }

    buffer.writeln('}');
    artefato.writeAsStringSync(buffer.toString());

    print('✅ Artefato criado: ${artefato.path}');
    print('🧪 Validando artefato...');
    final result = Process.runSync('dart', ['analyze', artefato.path]);
    print(result.stdout);
    print(result.stderr);
  }
}
