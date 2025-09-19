// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🔱 genesis.dart - Invocador único: avaliação, promoção e extraplanar      ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:tutor/ritual_index.dart';
import 'package:tutor/avaliador.dart';
import 'package:tutor/promotor.dart';
import 'package:tutor/arconte.dart';
import 'package:tutor/escriba.dart';

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
    'autor': 'Tiago',
    'conteudo': conteudo,
  };

  final escriba = Escriba();
  final avaliador = Avaliador();
  final promotor = Promotor();
  final arconte = Arconte();

  avaliador.avaliar(nome);

  if (ritualIndex[nome]?['status'] == 'aprovado') {
    promotor.promover(nome);
    escriba.sucesso(nome, 'Artefato promovido');
    arconte.executar();
  } else {
    escriba.erro(nome, 'Ritual reprovado, não promovido');
  }
}
