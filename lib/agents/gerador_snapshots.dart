// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ ⚡ GeradorSnapshots - Gera dados falsos para testes  ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import '../../core/nova/models/nova_snapshot.dart';
import 'dart:async';
import 'dart:math';

class GeradorSnapshots {
  final StreamController<NovaSnapshot> _stream = StreamController.broadcast();
  final Random _random = Random();
  Timer? _timer;

  void iniciar({Duration intervalo = const Duration(seconds: 3)}) {
    _timer = Timer.periodic(intervalo, (_) {
      final snapshot = _gerar();
      _stream.add(snapshot);
    });
  }

  void parar() {
    _timer?.cancel();
    _stream.close();
  }

  Stream<NovaSnapshot> get stream => _stream.stream;

  NovaSnapshot _gerar() {
    final carga = _random.nextDouble() * 100;
    final status = _definirStatus(carga);

    return NovaSnapshot(
      id: 'snapshot_${DateTime.now().millisecondsSinceEpoch}',
      timestamp: DateTime.now().toIso8601String(),
      carga: carga,
      status: status,
    );
  }

  String _definirStatus(double carga) {
    if (carga > 90) return 'sobrecarga';
    if (carga < 10) return 'ocioso';
    if (_random.nextDouble() < 0.05) return 'anômalo';
    return 'estável';
  }
}
