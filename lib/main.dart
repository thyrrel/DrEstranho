// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧙‍♂️ DrEstranho - Orquestrador da DimensãoEspelhada                  ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'core/dr_estranho_promptor.dart';

void main() {
  print('🌀 Invocando DrEstranho na DimensãoEspelhada...');

  final promptor = DrEstranhoPromptor();

  // Nome do ritual e destino final
  final nomeRitual = 'vigilancia_silenciosa';
  final destinoFinal = 'Instrumentos-Magicos';

  // Criação do prompt ritualístico
  promptor.criarPromptDimensional(
    nome: nomeRitual,
    destino: destinoFinal,
    autor: 'Tiago',
    workflow: 'Conjurador.yml',
    branchOrigem: 'Tutor-Demoníaco',
  );

  print('🔮 Ritual "$nomeRitual" preparado. Tutor-Demoníaco deve iniciar o fluxo.');
  print('👁️ DrEstranho aguardando validação e selamento dimensional...');
}
