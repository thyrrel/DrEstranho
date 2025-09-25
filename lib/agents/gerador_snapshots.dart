// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧪 GeradorSnapshots - Criador de dados falsos para testes rituais     ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:async';
import '../core/nova/models/nova_snapshot.dart';

class GeradorSnapshots {
  final StreamController<NovaSnapshot> _controlador = StreamController<NovaSnapshot>.broadcast();
  Timer? _timer;
  int _contador = 0;

  /// Stream pública para escuta dimensional
  Stream<NovaSnapshot> get stream => _controlador.stream;

  /// Inicia geração de snapshots falsos com metadados ritualísticos
  void iniciar({Duration intervalo = const Duration(seconds: 2)}) {
    print('🔧 GeradorSnapshots iniciado com intervalo de ${intervalo.inSeconds}s.');

    _timer = Timer.periodic(intervalo, (_) {
      final snapshot = NovaSnapshot(
        id: 'nó_${_contador + 1}',
        timestamp: DateTime.now().toIso8601String(),
        carga: (_contador * 42) % 100,
        status: _contador % 2 == 0 ? 'ativo' : 'latente',
      );

      _controlador.add(snapshot);
      print('📡 Snapshot gerado: ${snapshot.id} | ${snapshot.status}');
      _contador++;
    });
  }

  /// Encerra o ciclo de geração
  void encerrar() {
    _timer?.cancel();
    _controlador.close();
    print('🛑 GeradorSnapshots encerrado.');
  }
}
