// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧪 Ritual: vigilancia_silenciosa                     ┃
// ┃ 📜 Autor: Thyrrel                                    ┃
// ┃ 🔍 Status: em_validacao                             ┃
// ┃ ✅ Testado: true                                     ┃
// ┃ 📊 Log: true                                         ┃
// ┃ 🧠 Descrição: Observador escuta snapshots sem ruído ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'package:flutter/widgets.dart';

class VigilanciaSilenciosa {
  final ValueNotifier<dynamic> _observador;

  VigilanciaSilenciosa(this._observador);

  void iniciar() {
    _observador.addListener(() {
      final valor = _observador.value;
      _log(valor);
    });
  }

  void _log(dynamic valor) {
    print('🔍 [Vigilância] Snapshot capturado: $valor');
  }
}
