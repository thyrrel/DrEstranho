// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔮 Gerador Ritualístico - Grimório                                         ┃
// ┃ 📜 Atualiza o índice dos rituais consagrados com base em rituais/*.dart   ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

final rituaisPath = 'rituais/';
final indexPath = 'lib/ritual_index.dart';

void main() {
  final dir = Directory(rituaisPath);
  final arquivos = dir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  final buffer = StringBuffer('''
/// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
/// 📜 ritual_index.dart - Índice dos rituais consagrados
/// 🔮 Gerado automaticamente pelo gerador ritualístico
/// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

final ritualIndex = {
''');

  for (var file in arquivos) {
    final nome = file.uri.pathSegments.last.replaceAll('.dart', '');
    buffer.writeln("  '$nome': {");
    buffer.writeln("    'autor': 'Thyrrel',");
    buffer.writeln("    'status': 'consagrado',");
    buffer.writeln("    'testado': true,");
    buffer.writeln("    'log': true,");
    buffer.writeln("    'descricao': '', // descrição pendente");
    buffer.writeln("  },");
  }

  buffer.writeln('};');

  final indexFile = File(indexPath);
  indexFile.writeAsStringSync(buffer.toString());

  print('📜 ritual_index.dart atualizado com ${arquivos.length} rituais.');
}
