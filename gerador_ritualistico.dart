// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔮 Gerador Ritualico - Instrumento Mágico da VDF    ┃
// ┃ 🧪 Gera testes, simulações e index ritualístico      ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

final limboPath = 'lib/limbo/';
final testesPath = '${limboPath}testes/';
final simulacoesPath = '${limboPath}simulacoes/';
final indexPath = '${limboPath}ritual_index.dart';

void main() {
  final limboDir = Directory(limboPath);
  final ritualFiles = limboDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart') && !f.path.contains('testes') && !f.path.contains('simulacoes') && !f.path.contains('ritual_index'))
      .toList();

  final indexBuffer = StringBuffer('final ritualIndex = {\n');

  for (var file in ritualFiles) {
    final ritualName = file.uri.pathSegments.last.replaceAll('.dart', '');

    // 🧪 Teste
    final testFile = File('$testesPath${ritualName}_test.dart');
    if (!testFile.existsSync()) {
      testFile.writeAsStringSync('''
import 'package:test/test.dart';
import '../${ritualName}.dart';

void main() {
  test('$ritualName deve iniciar sem falhas', () {
    // TODO: implementar teste
    expect(true, isTrue);
  });
}
''');
      print('🧪 Teste gerado para "$ritualName"');
    }

    // 🧬 Simulação
    final simFile = File('$simulacoesPath${ritualName}_simulacao.dart');
    if (!simFile.existsSync()) {
      simFile.writeAsStringSync('''
void simular_$ritualName() {
  print('🔮 Simulação de "$ritualName" iniciada...');
  // TODO: implementar malha simulada
}
''');
      print('🧬 Simulação gerada para "$ritualName"');
    }

    // 📜 ritualIndex
    indexBuffer.writeln("  '$ritualName': {");
    indexBuffer.writeln("    'autor': 'Thyrrel',");
    indexBuffer.writeln("    'status': 'em_validacao',");
    indexBuffer.writeln("    'testado': false,");
    indexBuffer.writeln("    'log': false,");
    indexBuffer.writeln("    'descricao': '',");
    indexBuffer.writeln("  },");
  }

  indexBuffer.writeln('};');

  final indexFile = File(indexPath);
  indexFile.writeAsStringSync(indexBuffer.toString());
  print('📜 ritual_index.dart atualizado com ${ritualFiles.length} rituais.');
}
