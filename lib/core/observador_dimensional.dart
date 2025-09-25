// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 👁️ ObservadorDimensional - Vigia o progresso dos rituais criados     ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

class ObservadorDimensional {
  /// Verifica o status atual de um ritual criado em `recipes/`
  /// Retorna o status textual ou uma mensagem ritualística.
  String observarStatus(String nomeRitual) {
    final caminho = 'recipes/$nomeRitual.txt';
    final arquivo = File(caminho);

    if (!arquivo.existsSync()) {
      return '⛔ Ritual "$nomeRitual" não encontrado em recipes/.';
    }

    final linhas = arquivo.readAsLinesSync();
    final statusLine = linhas.firstWhere(
      (linha) => linha.startsWith('status:'),
      orElse: () => '',
    );

    if (statusLine.isEmpty) {
      return '❓ Ritual "$nomeRitual" não possui campo de status.';
    }

    final status = statusLine.replaceFirst('status:', '').trim();

    switch (status) {
      case 'aguardando':
        return '🕒 Ritual "$nomeRitual" está aguardando invocação por Tutor-Demoníaco.';
      case 'em teste':
        return '🔬 Ritual "$nomeRitual" está sendo testado no LIMBO.';
      case 'validado':
        return '✅ Ritual "$nomeRitual" foi validado e está pronto para selamento.';
      case 'operacional':
        return '🧙 Ritual "$nomeRitual" está operacional e pode ser invocado por DrEstranho.';
      default:
        return '⚠️ Ritual "$nomeRitual" possui status desconhecido: "$status".';
    }
  }
}
