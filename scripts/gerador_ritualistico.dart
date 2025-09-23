
// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔮 Gerador Ritualístico - ExtraPlanares                       ┃
// ┃ 📜 Atualiza o índice dos extraplanar consagrados              ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

final instrumentosPath = 'extraplanar/';
final indexPath = 'lib/ritual_index.dart';

void main() {
  final dir = Directory(extraplanarPath);
  final arquivos = dir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  final buffer = StringBuffer('final ritualIndex = {\n');

  for (var file in arquivos) {
    final nome = file.uri.pathSegments.last.replaceAll('.dart', '');
    buffer.writeln("  '$nome': {");
    buffer.writeln("    'autor': 'Thyrrel',");
    buffer.writeln("    'status': 'consagrado',");
    buffer.writeln("    'testado': true,");
    buffer.writeln("    'log': true,");
    buffer.writeln("    'descricao': '',");
    buffer.writeln("  },");
  }

  buffer.writeln('};');

  final indexFile = File(indexPath);
  indexFile.writeAsStringSync(buffer.toString());
  print('📜 ritual_index.dart atualizado com ${arquivos.length} extraplanar.');
}
