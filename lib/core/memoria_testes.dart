// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 📚 MemoriaTestes - Armazena e consulta rituais      ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:collection';

class MemoriaTestes {
  final Map<String, Map<String, dynamic>> _rituais = {};

  void salvar(Map<String, dynamic> relatorio) {
    final nome = 'ritual_${DateTime.now().millisecondsSinceEpoch}';
    _rituais[nome] = relatorio;
    print('📖 Ritual salvo na memória: $nome');
  }

  Map<String, dynamic>? buscar(String termo) {
    final resultado = _rituais.entries.firstWhere(
      (entry) => entry.key.contains(termo),
      orElse: () => MapEntry('', {}),
    );
    return resultado.value.isNotEmpty ? resultado.value : null;
  }

  List<String> listarRituais() {
    return _rituais.keys.toList();
  }

  void limparMemoria() {
    _rituais.clear();
    print('🧹 Memória de testes purificada.');
  }
}
