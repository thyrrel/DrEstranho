// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ ⚙️ bin/genesis.dart - Invocador de rituais e gerador de artefatos mágicos ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('⚠️ Nenhum ritual fornecido. Use: dart run bin/genesis.dart <caminho>');
    exit(1);
  }

  final caminho = args[0];
  final ritual = File(caminho);

  if (!ritual.existsSync()) {
    print('⚠️ Ritual não encontrado: $caminho');
    exit(1);
  }

  final linhas = ritual.readAsLinesSync();
  String tipo = '';
  String autor = '';
  final conteudo = <String>[];

  for (final linha in linhas) {
    if (linha.startsWith('tipo:')) {
      tipo = linha.replaceFirst('tipo:', '').trim();
    } else if (linha.startsWith('autor:')) {
      autor = linha.replaceFirst('autor:', '').trim();
    } else {
      conteudo.add(linha);
    }
  }

  if (tipo.isEmpty || autor.isEmpty || conteudo.isEmpty) {
    print('⚠️ Ritual incompleto: tipo, autor ou conteúdo ausente.');
    exit(1);
  }

  final nome = ritual.uri.pathSegments.last.replaceAll('.txt', '');
  final artefato = File('artefatos/$nome.dart');
  artefato.createSync(recursive: true);

  final buffer = StringBuffer()
    ..writeln('// 🧙 Artefato gerado por $autor')
    ..writeln('// 🔮 Tipo: $tipo')
    ..writeln('')
    ..writeln('class ${_formatClassName(nome)} {')
    ..writeln('  final String tipo = "$tipo";')
    ..writeln('  final String autor = "$autor";')
    ..writeln('  final String conteudo = """')
    ..writeln(conteudo.join('\n'))
    ..writeln('""";')
    ..writeln('}');

  artefato.writeAsStringSync(buffer.toString());
  print('✅ Artefato criado: ${artefato.path}');
}

String _formatClassName(String nome) {
  final limpo = nome.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
  final capitalizado = limpo.split('_').map((p) => p.isEmpty ? '' : '${p[0].toUpperCase()}${p.substring(1)}').join();
  return capitalizado;
}
