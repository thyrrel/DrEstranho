// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 📡 MonitorFluxo - Escuta e analisa tráfego dimensional               ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:collection';
import '../core/nova/models/nova_snapshot.dart';

class MonitorFluxo {
  final List<NovaSnapshot> _fluxoCapturado = [];
  final Map<String, int> _contagemPorStatus = HashMap();

  /// Escuta um snapshot e armazena na malha dimensional
  void escutarSnapshot(NovaSnapshot snapshot) {
    _fluxoCapturado.add(snapshot);
    _contagemPorStatus.update(snapshot.status, (v) => v + 1, ifAbsent: () => 1);
    print('📥 Capturado: ${snapshot.id} | Status: ${snapshot.status}');
  }

  /// Retorna estatísticas simbólicas do tráfego escutado
  Map<String, dynamic> coletarDados() {
    return {
      'total_recebidos': _fluxoCapturado.length,
      'por_status': Map.from(_contagemPorStatus),
      'ultimo_snapshot': _fluxoCapturado.isNotEmpty ? _fluxoCapturado.last : null,
    };
  }

  /// Limpa o fluxo capturado (ritual de purificação)
  void purificar() {
    _fluxoCapturado.clear();
    _contagemPorStatus.clear();
    print('🧼 Fluxo purificado. Memória zerada.');
  }

  /// Lista todos os snapshots capturados
  List<NovaSnapshot> listarFluxo() => List.unmodifiable(_fluxoCapturado);
}
