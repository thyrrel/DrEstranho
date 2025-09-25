// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧙‍♂️ DrEstranho - Conjurador central da malha dimensional            ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'core/dr_estranho_promptor.dart';
import 'core/observador_dimensional.dart';
import 'core/memoria_testes.dart';
import 'core/veritas_index.dart';

import 'agents/gerador_snapshots.dart';
import 'agents/monitor_fluxo.dart';
import 'agents/simulador_nos.dart';

void main() {
  print('🌌 Invocando DrEstranho na DimensãoEspelhada...');

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃ 📜 Etapa 1 - Criar ritual em recipes/                      ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  final nomeRitual = 'vigilancia_silenciosa';
  final destinoFinal = 'Instrumentos-Magicos';

  final promptor = DrEstranhoPromptor();
  promptor.criarPromptDimensional(
    nome: nomeRitual,
    destino: destinoFinal,
    autor: 'Tiago',
    workflow: 'Conjurador.yml',
    branchOrigem: 'Tutor-Demoníaco',
  );

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃ 👁️ Etapa 2 - Observar status do ritual                    ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  final observador = ObservadorDimensional();
  final status = observador.observarStatus(nomeRitual);
  print('🔍 Status ritual "$nomeRitual": $status');

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃ 🧠 Etapa 3 - Registrar ritual na memória de testes         ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  final memoria = MemoriaTestes();
  memoria.registrar(
    nome: nomeRitual,
    origem: 'recipes/',
    destino: destinoFinal,
    status: status.contains('operacional') ? 'operacional' : 'pendente',
  );

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃ 📡 Etapa 4 - Iniciar escuta de snapshots                   ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  final gerador = GeradorSnapshots();
  final monitor = MonitorFluxo();
  final noSimulado = SimuladorNos('nó_espelho');

  gerador.stream.listen((snapshot) {
    monitor.escutarSnapshot(snapshot);
    noSimulado.escutar(snapshot);
  });

  gerador
