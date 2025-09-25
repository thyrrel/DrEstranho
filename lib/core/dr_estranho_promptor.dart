// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 📜 DrEstranhoPromptor - Criador de Prompts para Tutor-Demoníaco      ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

class DrEstranhoPromptor {
  /// Cria um prompt ritualístico em formato `.txt` na pasta `recipes/`
  /// para ser lido e processado por Tutor-Demoníaco.
  void criarPromptDimensional({
    required String nome,
    required String destino,
    String autor = 'Tiago',
    String workflow = 'Conjurador.yml',
    String branchOrigem = 'Tutor-Demoníaco',
  }) {
    final conteudo = '''
nome: $nome
descricao: Ritual gerado por DrEstranho
autor: $autor
destino: $destino
branch_origem: $branchOrigem
workflow: $workflow
status: aguardando
''';

    final caminho = 'recipes/$nome.txt';
    final arquivo = File(caminho);

    if (arquivo.existsSync()) {
      print('⚠️ Ritual "$nome" já existe em recipes/.');
      return;
    }

    try {
      arquivo.writeAsStringSync(conteudo);
      print('📜 Ritual "$nome" criado com sucesso em recipes/.');
      print('🧪 Aguardando Tutor-Demoníaco iniciar o fluxo dimensional...');
    } catch (e) {
      print('⛔ Falha ao criar ritual "$nome": $e');
    }
  }
}
