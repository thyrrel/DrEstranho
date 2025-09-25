// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧠 MemoriaTestes - Guardião dos registros rituais                    ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:collection';

class RegistroRitual {
  final String nome;
  final String origem;
  final String destino;
  final String status;
  final DateTime criadoEm;
  final Map<String, dynamic> resultados;

  RegistroRitual({
    required this.nome,
    required this.origem,
    required this.destino,
    required this.status,
    required this.criadoEm,
    required this.resultados,
  });

  @override
  String toString() {
    return '🔮 $nome | $status → $destino | Criado em: ${criadoEm.toIso8601String()}';
  }
}

class MemoriaTestes {
  final _registros = HashMap<String, RegistroRitual>();

  /// Armazena um novo ritual na memória
  void registrar({
    required String nome,
    required String origem,
    required String destino,
    required String status,
    Map<String, dynamic> resultados = const {},
  }) {
    final ritual = RegistroRitual(
      nome: nome,
      origem: origem,
      destino: destino,
      status: status,
      criadoEm: DateTime.now(),
      resultados: resultados,
    );

    _registros[nome] = ritual;
    print('🧠 Ritual "$nome" registrado com status "$status".');
  }

  /// Consulta um ritual pelo nome
  RegistroRitual? consultar(String nome) => _registros[nome];

  /// Lista todos os rituais registrados
  List<RegistroRitual> listarTodos() => _registros.values.toList();

  /// Atualiza o status de um ritual existente
  void atualizarStatus(String nome, String novoStatus) {
    final ritual = _registros[nome];
    if (ritual != null) {
      _registros[nome] = RegistroRitual(
        nome: ritual.nome,
        origem: ritual.origem,
        destino: ritual.destino,
        status: novoStatus,
        criadoEm: ritual.criadoEm,
        resultados: ritual.resultados,
      );
      print('🔁 Status do ritual "$nome" atualizado para "$novoStatus".');
    } else {
      print('⚠️ Ritual "$nome" não encontrado na memória.');
    }
  }
}
