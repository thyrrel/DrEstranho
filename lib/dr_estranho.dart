// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧠 DrEstranho - Orquestrador da DimensãoEspelhada    ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'agents/simulador_nos.dart';
import 'agents/gerador_snapshots.dart';
import 'agents/monitor_fluxo.dart';
import 'core/memoria_testes.dart';

// Plugins (vindos de branches separadas)
import 'core/plugin_watchhound.dart';
import 'core/plugin_purificador.dart';
import 'core/plugin_organix.dart';
import 'core/plugin_cyberguard.dart';
import 'core/plugin_digitalforge.dart';

void main() {
  final simulador = SimuladorNos();
  final gerador = GeradorSnapshots();
  final monitor = MonitorFluxo();
  final memoria = MemoriaTestes();

  final watchHound = PluginWatchHound();
  final purificador = PluginPurificador();
  final organix = PluginOrganix();
  final cyberGuard = PluginCyberGuard();
  final digitalForge = PluginDigitalForge();

  // 🧬 Inicia nós simulados
  simulador.criarNos();

  // ⚡ Inicia geração de snapshots
  gerador.iniciar();
  gerador.stream.listen((snapshot) {
    monitor.escutarSnapshot(snapshot);
    organix.registrar(snapshot);

    // 🐾 Vigilância
    watchHound.monitorar('agressivo');

    // 🛡️ Segurança
    cyberGuard.validarTransacao(snapshot.id, 'nó_0', snapshot.carga);

    // 🔨 Forja digital
    if (snapshot.status == 'anômalo') {
      digitalForge.forjarAgente('AgenteDeContenção', config: {'origem': snapshot.id});
    }

    // 🧼 Purificação
    if (snapshot.status == 'sobrecarga') {
      purificador.limpar(snapshot.id);
    }
  });

  // ⏳ Ritual de encerramento após 30 segundos
  Future.delayed(Duration(seconds: 30), () {
    final relatorio = monitor.coletarDados();
    memoria.salvar(relatorio);

    print('\n📊 Relatório Final:');
    print(relatorio);

    print('\n📚 Rituais salvos:');
    print(memoria.listarRituais());

    simulador.encerrarNos();
    gerador.parar();
  });
}
