// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 📡 MonitorFluxo - Escuta e analisa tráfego da malha ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import '../../core/nova/models/nova_snapshot.dart';
import 'dart:collection';

class MonitorFluxo {
  final List<NovaSnapshot> _recebidos = [];
  final Set<String> _idsUnicos = {};
  final Map<String, int> _statusCount = {};
  final Map<String, double> _cargaMediaPorNo = {};

  void escutarSnapshot(NovaSnapshot snapshot) {
    _recebidos.add(snapshot);
    _idsUnicos.add(snapshot.id);

    _statusCount[snapshot.status] = (_statusCount[snapshot.status] ?? 0) + 1;

    final cargaAtual = _cargaMediaPorNo[snapshot.id] ?? 0;
    final total = _recebidos.where((s) => s.id == snapshot.id).length;
    _cargaMediaPorNo[snapshot.id] = ((cargaAtual * (total - 1)) + snapshot.carga) / total;
  }

  Map<String, dynamic> coletarDados() {
    return {
      'total_recebidos': _recebidos.length,
      'ids_unicos': _idsUnicos.length,
      'status': _statusCount,
      'carga_media_por_no': _cargaMediaPorNo,
      'duplicados': _recebidos.length - _idsUnicos.length,
    };
  }

  void escutar() {
    print('📡 MonitorFluxo escutando...');
    // Este método pode ser plugado em um stream externa
  }
}
