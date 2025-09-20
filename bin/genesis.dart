# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃ ⚙️ genesis.yml - Ritual completo: geração, testes, invocação e arquivamento┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

name: Genesis Ritual

on:
  push:
    paths:
      - 'Tutor-Demoníaco/recipes/**'
      - 'bin/genesis.dart'
      - '.github/workflows/genesis.yml'

jobs:
  conjurar_ritual:
    runs-on: ubuntu-latest
    steps:
      - name: 📦 Checkout do grimório
        uses: actions/checkout@v3

      - name: 🧙 Instalar Dart
        uses: dart-lang/setup-dart@v1

      - name: 📦 Instalar dependências
        run: dart pub get

      - name: 🔮 Invocar genesis.dart
        run: |
          echo "🔮 Varredura por apps completos em repositórios thyrrel/"
          dart run bin/genesis.dart

      - name: 🧪 Avaliar ritual
        run: |
          nome=$(basename "${{ github.event.head_commit.modified[0] }}" .txt)
          ritual="Tutor-Demoníaco/recipes/$nome.txt"
          artefato="artefatos/$nome.dart"

          mkdir -p LIMBO/lib/limbo/
          mkdir -p LIMBO/lib/infernus/

          echo "🔧 Gerando artefato para $ritual"
          dart run bin/genesis.dart "$ritual"

          if [ -f "$artefato" ]; then
            echo "🧪 Testando artefato: $artefato"
            dart analyze "$artefato" || STATUS=falhou

            if [ "$STATUS" = "falhou" ]; then
              mv "$artefato" LIMBO/lib/infernus/
              mv "$ritual" "Tutor-Demoníaco/recipes/${nome}infernus.txt"
              echo "❌ Ritual reprovado: artefato → infernus, ritual renomeado"
            else
              mv "$artefato" LIMBO/lib/limbo/
              echo "✅ Ritual aprovado: artefato → limbo"
              echo "🚀 Invocando workflow do artefato: $nome"
              gh workflow run "artefato-${nome}.yml" --ref LIMBO
            fi
          else
            echo "⚠️ Nenhum artefato gerado para $nome"
          fi
