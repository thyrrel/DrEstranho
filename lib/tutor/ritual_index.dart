// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 📘 RitualIndex - Registro dos rituais da VDF         ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

final Map<String, Map<String, dynamic>> ritualIndex = {
  'vigilancia_silenciosa': {
    'autor': 'Thyrrel',
    'status': 'pronto',
    'testado': true,
    'log': true,
    'descricao': 'Observador escuta snapshots sem interferência.',
  },
  'fluxo_comparado': {
    'autor': 'Thyrrel',
    'status': 'em_validacao',
    'testado': false,
    'log': true,
    'descricao': 'MonitorFluxo e Observador comparam padrões da malha.',
  },
  'interferencia_controlada': {
    'autor': 'Thyrrel',
    'status': 'em_validacao',
    'testado': false,
    'log': false,
    'descricao': 'Plugins ativos interagem com snapshots em tempo real.',
  },
};
