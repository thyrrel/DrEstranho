// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧠 tutor.dart - Executor de receitas ritualísticas e gerador de artefatos  ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart' as p;

void main(List<String> args) {
  final receitasDir = Directory('recipes');
  if (!receitasDir.existsSync()) {
    stderr.writeln('❌ Diretório de receitas não encontrado.');
    exit(1);
  }

  final arquivos = receitasDir.listSync().whereType<File>().toList();
  if (arquivos.isEmpty) {
    stderr.writeln('⚠️ Nenhuma receita ritualística encontrada.');
    exit(0);
  }

  for (final arquivo in arquivos) {
    final nome = p.basename(arquivo.path);
    stdout.writeln('🔮 Processando receita: $nome');

    final conteudo = arquivo.readAsStringSync();
    final ritual = loadYaml(conteudo);

    // Simulação de geração de artefato
    final artefato = File('artefatos/${nome.replaceAll('.yaml', '.dart')}');
    artefato.createSync(recursive: true);
    artefato.writeAsStringSync('// Artefato gerado a partir de $nome\n');

    stdout.writeln('✅ Artefato gerado: ${artefato.path}');
  }

  stdout.writeln('🎯 Geração ritualística concluída.');
}

// ✍️ byThyrrel  
// 💡 Formato grimório técnico seguro e elegante
