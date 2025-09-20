// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ ⚙️ bin/genesis.dart - Invocador de rituais e gerador de artefatos         ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('⚠️ Nenhum ritual especificado.');
    exit(1);
  }

  final ritualPath = args.first;
  final ritualFile = File(ritualPath);

  if (!ritualFile.existsSync()) {
    print('❌ Ritual não encontrado: $ritualPath');
    exit(1);
  }

  final nome = ritualFile.uri.pathSegments.last.replaceAll('.txt', '');
  final artefato = File('artefatos/$nome.dart');
  artefato.createSync(recursive: true);

  final conteudo = ritualFile.readAsLinesSync();

  final buffer = StringBuffer()
    ..writeln('// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓')
    ..writeln('// ┃ 🔮 Artefato: $nome.dart - Gerado a partir do ritual $nome     ┃')
    ..writeln('// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛')
    ..writeln('')
    ..writeln('void main() {')
    ..writeln("  print('🧙 Executando ritual: $nome');");

  for (final linha in conteudo) {
    buffer.writeln("  print('📜 ${linha.replaceAll("'", "\\'")}');");
  }

  buffer.writeln('}');

  artefato.writeAsStringSync(buffer.toString());
  print('✅ Artefato criado: ${artefato.path}');
}
