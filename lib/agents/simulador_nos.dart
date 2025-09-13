// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧪 SimuladorNos - Cria múltiplos MeshAgents simulados ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import '../../core/nova/mesh/mesh_agent.dart';
import '../../core/nova/models/nova_snapshot.dart';
import 'dart:async';
import 'dart:math';

class SimuladorNos {
  final List<MeshAgent> _nos = [];
  final int quantidade = 3; // Número de nós simulados

  void criarNos() {
    print('🧬 Criando $quantidade nós simulados...');
    for (int i = 0; i < quantidade; i++) {
      final agente = MeshAgent();
      agente.start();

      // Simula envio de snapshot a cada 3 segundos
      Timer.periodic(Duration(seconds: 3), (timer) {
        final snapshot = _gerarSnapshot(i);
        agente.broadcastSnapshot(snapshot);
      });

      _nos.add(agente);
    }
  }

  NovaSnapshot _gerarSnapshot(int id) {
    final random = Random();
    return NovaSnapshot(
      id: 'nó_$id',
      timestamp: DateTime.now().toIso8601String(),
      carga: random.nextDouble() * 100,
      status: random.nextBool() ? 'ativo' : 'ocioso',
    );
  }

  void encerrarNos() {
    for (final agente in _nos) {
      agente.stop();
    }
    _nos.clear();
    print('🧹 Nós simulados encerrados.');
  }
}
