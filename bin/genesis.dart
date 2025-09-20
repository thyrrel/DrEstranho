// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ ⚙️ bin/genesis.dart - Invocador de rituais e gerador de artefatos         ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

void main() async {
  print('🔮 Iniciando ritual de geração de artefatos...');
  
  // Verificar se a pasta recipe existe
  final recipeDir = Directory('recipe');
  if (!recipeDir.existsSync()) {
    print('⚠️ Pasta recipe/ não encontrada. Criando estrutura básica...');
    recipeDir.createSync(recursive: true);
    
    // Criar um ritual de exemplo
    final exemploRitual = File('recipe/exemplo.txt');
    exemploRitual.writeAsStringSync('''Este é um ritual de exemplo
Ele demonstra como criar artefatos
A partir de receitas simples
Cada linha vira um comando no artefato''');
    
    print('📝 Ritual de exemplo criado em recipe/exemplo.txt');
  }

  // Criar pasta de artefatos se não existir
  final artefatosDir = Directory('artefatos');
  if (!artefatosDir.existsSync()) {
    artefatosDir.createSync(recursive: true);
    print('📁 Pasta artefatos/ criada');
  }

  // Buscar arquivos de ritual
  final arquivos = recipeDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) =>
          f.path.endsWith('.txt') &&
          !f.path.contains('_infernus') &&
          !f.path.contains('/acervo/'))
      .toList();

  if (arquivos.isEmpty) {
    print('⚠️ Nenhum ritual válido encontrado na pasta recipe/');
    print('💡 Certifique-se de que há arquivos .txt na pasta recipe/');
    return;
  }

  print('🧙 Encontrados ${arquivos.length} rituais para processar');

  var artefatosCriados = 0;

  for (final ritualFile in arquivos) {
    try {
      final nome = ritualFile.uri.pathSegments.last.replaceAll('.txt', '');
      print('⚡ Processando ritual: $nome');
      
      final artefato = File('artefatos/$nome.dart');
      
      // Ler conteúdo do ritual
      final conteudo = ritualFile.readAsLinesSync();
      
      // Gerar código do artefato
      final buffer = StringBuffer()
        ..writeln('// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓')
        ..writeln('// ┃ 🔮 Artefato: $nome.dart - Gerado a partir do ritual $nome     ┃')
        ..writeln('// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛')
        ..writeln('')
        ..writeln('/// Artefato mágico gerado automaticamente')
        ..writeln('/// Ritual origem: ${ritualFile.path}')
        ..writeln('void main() {')
        ..writeln("  print('🧙 Executando ritual: $nome');")
        ..writeln("  print('━' * 50);");

      // Processar cada linha do ritual
      for (var i = 0; i < conteudo.length; i++) {
        final linha = conteudo[i].trim();
        if (linha.isNotEmpty) {
          // Escapar aspas simples
          final linhaEscapada = linha.replaceAll("'", "\\'");
          buffer.writeln("  print('📜 Passo ${i + 1}: $linhaEscapada');");
        }
      }

      buffer
        ..writeln("  print('━' * 50);")
        ..writeln("  print('✨ Ritual $nome concluído com sucesso!');")
        ..writeln('}')
        ..writeln('')
        ..writeln('/// Função para obter informações do artefato')
        ..writeln('String getArtefatoInfo() {')
        ..writeln("  return 'Artefato $nome - Gerado automaticamente';")
        ..writeln('}');

      // Escrever artefato
      artefato.writeAsStringSync(buffer.toString());
      artefatosCriados++;
      
      print('✅ Artefato criado: ${artefato.path}');
      
      // Validar sintaxe básica do artefato
      print('🧪 Validando artefato $nome...');
      final result = await Process.run('dart', ['analyze', artefato.path]);
      
      if (result.exitCode == 0) {
        print('✅ Validação passou: $nome');
      } else {
        print('⚠️ Avisos na validação de $nome:');
        if (result.stdout.toString().isNotEmpty) {
          print(result.stdout);
        }
        if (result.stderr.toString().isNotEmpty) {
          print(result.stderr);
        }
      }
      
    } catch (e) {
      print('❌ Erro ao processar ritual ${ritualFile.path}: $e');
    }
  }

  print('');
  print('🎉 Ritual de geração concluído!');
  print('📊 Total de artefatos criados: $artefatosCriados');
  print('📁 Artefatos disponíveis em: ./artefatos/');
  
  // Listar artefatos criados
  if (artefatosCriados > 0) {
    print('🔮 Artefatos gerados:');
    final artefatosFiles = Directory('artefatos')
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));
    
    for (final artefato in artefatosFiles) {
      final nome = artefato.uri.pathSegments.last;
      print('  ✨ $nome');
    }
  }
}
