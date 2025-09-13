// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧙‍♂️ DrEstranho - Nano IA gestora de testes da N.O.V.A. ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'agents/simulador_nos.dart';
import 'agents/gerador_snapshots.dart';
import 'agents/monitor_fluxo.dart';
import 'core/memoria_testes.dart';
import 'core/plugin_watchhound.dart';
import 'core/plugin_purificador.dart';

class DrEstranho {
  final SimuladorNos simulador = SimuladorNos();
  final GeradorSnapshots gerador = GeradorSnapshots();
  final MonitorFluxo monitor = MonitorFluxo();
  final MemoriaTestes memoria = MemoriaTestes();
  final PluginWatchHound watchHound = PluginWatchHound();
  final PluginPurificador purificador = PluginPurificador();

  void iniciarRitual(String nome) {
    print('🔮 Ritual iniciado: $nome');
    simulador.criarNos();
    gerador.iniciar();
    monitor.escutar();
  }

  void invocarWatchHound({String perfil = 'neutro'}) {
    print('🐾 Invocando WatchHound com perfil: $perfil');
    watchHound.monitorar(perfil);
  }

  void executarPurificacao({required String target}) {
    print('🧼 Executando purificação em: $target');
    purificador.limpar(target);
  }

  void finalizarRitual() {
    print('🧾 Ritual encerrado. Salvando grimório...');
    final resultados = monitor.coletarDados();
    memoria.salvar(resultados);
  }

  void criarBranchLimpa(String nomeBranch) {
    print('🪄 Criando branch limpa: $nomeBranch');
    // Aqui pode integrar com GitHub API futuramente
  }

  void consultarMemoria(String termo) {
    final dados = memoria.buscar(termo);
    print('📚 Memória retornada: $dados');
  }
}
