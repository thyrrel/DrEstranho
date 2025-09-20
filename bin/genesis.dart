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

  final conteudo = ritualFile.readAsStringSync();

  final buffer = StringBuffer()
    ..writeln('// 🔮 Artefato gerado a partir do ritual: $nome')
    ..writeln('void main() {')
    ..writeln("  print('🧙 Executando ritual: $nome');")
    ..writeln("  print('📜 Conteúdo: ${conteudo.replaceAll('\n', ' ')}');")
    ..writeln('}');

  artefato.writeAsStringSync(buffer.toString());
  print('✅ Artefato criado: ${artefato.path}');
}
