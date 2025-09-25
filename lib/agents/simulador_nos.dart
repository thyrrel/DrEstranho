// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧠 SimuladorNos - Entidades que escutam e reagem ao fluxo dimensional┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import '../core/nova/models/nova_snapshot.dart';

class SimuladorNos {
  final String id;
  final List<NovaSnapshot> _memoriaLocal = [];

  SimuladorNos(this.id);

  /// Escuta um snapshot e armazena localmente
  void escutar(NovaSnapshot snapshot) {
    _memoriaLocal.add(snapshot);
    print('🧭 Nó "$id" recebeu snapshot: ${snapshot.id} | ${snapshot.status}');
  }

  /// Retorna os últimos N snapshots escutados
  List<NovaSnapshot> ultimos({int quantidade = 5}) {
    final total = _memoriaLocal.length;
    final inicio = total < quantidade ? 0 : total - quantidade;
    return _memoriaLocal.sublist(inicio);
  }

  /// Purifica a memória local do nó
  void purificar() {
    _memoriaLocal.clear();
    print('🧼 Nó "$id" purificado. Memória zerada.');
  }

  /// Retorna o total de snapshots recebidos
  int totalRecebido() => _memoriaLocal.length;

  /// Retorna um resumo simbólico do nó
  String resumo() {
    return '🔹 Nó "$id" | Total: ${totalRecebido()} | Último: ${_memoriaLocal.isNotEmpty ? _memoriaLocal.last.id : 'nenhum'}';
  }
}
