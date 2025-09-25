// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧙‍♂️ DrEstranho - Orquestrador da DimensãoEspelhada                  ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'core/dr_estranho_promptor.dart';
import 'core/observador_dimensional.dart';

void main() {
  print('🌌 Invocando DrEstranho na DimensãoEspelhada...');
  final nomeRitual = 'vigilancia_silenciosa';
  final destinoFinal = 'Instrumentos-Magicos';

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃ 📜 Etapa 1 - Criar o prompt ritualístico em recipes/       ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  final promptor = DrEstranhoPromptor();
  promptor.criarPromptDimensional(
    nome: nomeRitual,
    destino: destinoFinal,
    autor: 'Tiago',
    workflow: 'Conjurador.yml',
    branchOrigem: 'Tutor-Demoníaco',
  );

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃ 👁️ Etapa 2 - Observar o status do ritual criado           ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  final observador = ObservadorDimensional();
  final status = observador.observarStatus(nomeRitual);

  print('🔍 Status atual do ritual "$nomeRitual":');
  print(status);
}
