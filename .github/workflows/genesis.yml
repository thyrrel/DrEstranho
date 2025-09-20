# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃ 🔮 genesis.yml - Ritual de geração, validação e promoção de artefatos      ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

name: Genesis Ritual

on:
  push:
    branches: [Tutor-Demoníaco]
    paths: [recipe/**, bin/genesis.dart, .github/workflows/genesis.yml]
  workflow_dispatch:

jobs:
  artefato:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: dart-lang/setup-dart@v1
      - run: dart pub get
      - run: dart run bin/genesis.dart
      - uses: actions/upload-artifact@v4
        with:
          name: artefatos
          path: artefatos/

  movendo_artefato:
    needs: artefato
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/download-artifact@v4
        with: {name: artefatos, path: artefatos/}
      - run: |
          mkdir -p lib/limbo
          for f in artefatos/*.dart; do [ -f "$f" ] && cp "$f" lib/limbo/; done

  testes:
    needs: movendo_artefato
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/download-artifact@v4
        with: {name: artefatos, path: artefatos/}
      - run: |
          mkdir -p lib/infernus
          for f in artefatos/*.dart; do
            if [ -f "$f" ] && ! dart analyze --fatal-infos "$f"; then
              nome=$(basename "$f" .dart)
              cp "$f" lib/infernus/
              [ -f "recipe/$nome.txt" ] && mv "recipe/$nome.txt" "recipe/${nome}_infernus"
            fi
          done

  valido:
    needs: testes
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: |
          mkdir -p .github/workflows
          echo "# Novo job para artefato gerado" >> .github/workflows/conjurafor.yml

  ok:
    needs: valido
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/download-artifact@v4
        with: {name: artefatos, path: artefatos/}
      - run: |
          mkdir -p instrumento ritual extraplanar
          for f in artefatos/*.dart; do
            [ -f "$f" ] && cp "$f" instrumento/ && cp "$f" ritual/ && cp "$f" extraplanar/
          done
      - run: |
          for f in artefatos/*.dart; do
            [ -f "$f" ] && echo "- $(basename "$f" .dart)" >> README.md
          done
      - uses: actions/upload-artifact@v4
        with:
          name: artefatos-finais
          path: |
            instrumento/
            ritual/
            extraplanar/

# Sugestões
# - 🛡️ Adicionar verificação de duplicidade antes de promover artefatos
# - 🔤 Criar mecanismo de rollback para artefatos corrompidos
# - 📦 Publicar artefatos como release ou pacote externo
# - 🧩 Integrar com sistema de aprovação manual para artefatos críticos
# - 🎨 Gerar badges visuais para artefatos aprovados no README

# ✍️ byThyrrel  
# 💡 Workflow formatado com estilo técnico, seguro e elegante  
# 🧪 Ideal para conjuradores de código com foco em automação limpa e confiável
