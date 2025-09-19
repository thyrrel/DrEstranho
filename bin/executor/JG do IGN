// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔱 executor.dart - Orquestrador de rituais e validações extraplanares     ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:tutor/tutor_demoniaco.dart';
import 'package:tutor/ritual_index.dart';
import 'package:tutor/arconte.dart';

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

  ritualIndex[nome] = {
    'status': 'pendente',
    'autor': 'Thyrrel',
    'conteudo': conteudo,
  };

  final tutor = TutorDemoniaco();
  tutor.promoverTodos();

  if (ritualIndex[nome]?['status'] == 'aprovado') {
    final arconte = Arconte();
    arconte.executar();
  }
}
