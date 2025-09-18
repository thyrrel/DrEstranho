// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 😈 bin/tutor.dart - Invocador de rituais individuais via GitHub Actions   ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:tutor/tutor_demoniaco.dart';
import 'package:tutor/ritual_index.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('❌ Nenhum arquivo de ritual informado.');
    exit(1);
  }

  final caminho = args.first;
  final arquivo = File(caminho);

  if (!arquivo.existsSync()) {
    stderr.writeln('❌ Arquivo não encontrado: $caminho');
    exit(1);
  }

  final nome = p.basenameWithoutExtension(caminho);
  final conteudo = arquivo.readAsStringSync();

  // 🧠 Preenchimento ritualístico do index
  ritualIndex[nome] = {
    'status': 'aprovado',
    'autor': 'Tiago',
    'conteudo': conteudo,
  };

  // 🔱 Invocação do TutorDemoníaco
  final tutor = TutorDemoníaco();
  tutor.promoverTodos();
}
