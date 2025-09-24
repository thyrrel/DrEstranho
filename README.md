🧙‍♂️ DrEstranho — Nano IA da DimensãoEspelhada

DrEstranho é uma IA auxiliar criada para testar, validar, purificar e evoluir os agentes da N.O.V.A. dentro de um ambiente isolado chamado DimensãoEspelhada. Ele simula múltiplos nós, invoca agentes externos, monitora fluxos e decide quando um módulo está pronto para ser promovido à realidade principal.

✨ Propósito

Simular agentes da malha N.O.V.A.

Testar funcionalidades antes de irem para produção

Integrar ferramentas externas como WatchHound e Agente-de-Limpeza

Gerenciar memória de testes e decisões

Criar branches limpas com módulos validados

🧩 Estrutura

lib/
├── dr_estranho.dart               // IA principal
├── agents/
│   ├── simulador_nos.dart        // Cria múltiplos MeshAgents
│   ├── gerador_snapshots.dart    // Gera dados falsos
│   ├── monitor_fluxo.dart        // Escuta e analisa tráfego
├── core/
│   ├── memoria_testes.dart       // Armazena e consulta resultados
│   ├── plugin_watchhound.dart    // Integração com vigilância
│   ├── plugin_purificador.dart   // Integração com limpeza

🔮 Principais Funções

iniciarRitual(nome): inicia um teste completo

invocarWatchHound(perfil): simula comportamento suspeito

executarPurificacao(target): limpa nó ou agente específico

finalizarRitual(): salva resultados e encerra o teste

criarBranchLimpa(nomeBranch): prepara branch pós-validação

consultarMemoria(termo): busca testes anteriores
