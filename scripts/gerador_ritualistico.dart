// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ ⚙️ Gerador Ritualístico - ExtraPlanares                                   ┃
// ┃ 📜 Atualiza o índice com artefatos em extraplanar/*.dart                  ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

final origem = 'extraplanar/';
final destino = 'lib/ritual_index.dart';

void main() {
  final dir = Directory(origem);
  final arquivos = dir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  final buffer = StringBuffer('''
/// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
/// 📜 ritual_index.dart - Índice dos rituais extraplanares
/// ⚙️ Gerado automaticamente pelo gerador ritualístico
/// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

final ritualIndex = {
''');

  for (var file in arquivos) {
    final nome = file.uri.pathSegments.last.replaceAll('.dart', '');
    buffer.writeln("  '$nome': {");
    buffer.writeln("    'autor': 'Thyrrel',");
    buffer.writeln("    'status': 'em teste',");
    buffer.writeln("    'testado': false,");
    buffer.writeln("    'log': true,");
    buffer.writeln("    'descricao': '', // descrição pendente");
    buffer.writeln("  },");
  }

  buffer.writeln('};');

  File(destino).writeAsStringSync(buffer.toString());
  print('📜 ritual_index.dart atualizado com ${arquivos.length} rituais dimensionais.');
}
