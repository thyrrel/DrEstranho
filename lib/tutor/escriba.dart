// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 📁 escriba.dart - Registro ritualístico de eventos e diagnósticos         ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:io';

class Logista {
  final File logFile = File('grimorio.log');

  void registrar(String mensagem) {
    final timestamp = DateTime.now().toIso8601String();
    logFile.writeAsStringSync('[$timestamp] $mensagem\n', mode: FileMode.append);
  }

  void erro(String ritual, String detalhe) {
    registrar('❌ Erro no ritual "$ritual": $detalhe');
  }

  void sucesso(String ritual, String acao) {
    registrar('✅ Ritual "$ritual" - $acao concluída.');
  }

  void aviso(String ritual, String nota) {
    registrar('⚠️ Ritual "$ritual" - $nota');
  }
}
