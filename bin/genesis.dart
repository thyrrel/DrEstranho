# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃ 🔮 genesis.yml - Ritual de geração, validação e promoção de artefatos      ┃
# ┃ 📜 byThyrrel | Upload→Download sincronizados | Retention curto pra testes  ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
name: Genesis Ritual

on:
  push:
    branches: [Tutor-Demoníaco]
    paths: [recipe/**, bin/genesis.dart, .github/workflows/genesis.yml]
  workflow_dispatch:

permissions:
  contents: write

jobs:
  artefato:
    name: criar artefato
    runs-on: ubuntu-latest
    steps:
      - name: Checkout do grimório
        uses: actions/checkout@v4

      - name: Instalar Dart
        uses: dart-lang/setup-dart@v1

      - name: Invocar rituais
        run: dart pub get && dart run bin/genesis.dart

      - name: Upload artefatos (ZIP interno)
        uses: actions/upload-artifact@v4
        with:
          name: artefatos-v4
          path: artefatos/*.dart
          retention-days: 1          # <-- evita expiração durante testes
          if-no-files-found: error   # <-- garante que algo foi gerado

  movendo_artefato:
    name: mover artefato
    needs: artefato
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/download-artifact@v4
        with:
          name: artefatos-v4
          path: artefatos/

      - name: Copiar para lib/limbo
        run: |
          mkdir -p lib/limbo
          for f in artefatos/*.dart; do
            [ -f "$f" ] && cp "$f" lib/limbo/
          done

      - name: Upload da pasta limbo (opcional, se quiser reusar)
        uses: actions/upload-artifact@v4
        with:
          name: limbo-v4
          path: lib/limbo/
          retention-days: 1

  testes:
    name: validar artefatos
    needs: movendo_artefato
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          ref: LIMBO
          token: ${{ secrets.GITHUB_TOKEN }}

      - uses: actions/download-artifact@v4
        with:
          name: artefatos-v4          # <-- MESMO nome do upload
          path: artefatos/

      - name: Mover falhos para infernus
        run: |
          mkdir -p lib/infernus
          for f in artefatos/*.dart; do
            if [ -f "$f" ] && ! dart analyze --fatal-infos "$f"; then
              cp "$f" lib/infernus/
            fi
          done

      - name: Commitar falhos na LIMBO
        uses: stefanzweifel/git-auto-commit-action@v5
        with:
          commit_message: '⚠️ Artefatos falhos enviados ao infernus'
          branch: LIMBO
          create_branch: true

  valido:
    name: registrar conjuração
    needs: testes
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: |
          mkdir -p .github/workflows
          echo "# Job gerado automaticamente" >> .github/workflows/conjurafor.yml

  ok:
    name: promover artefatos
    needs: valido
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/download-artifact@v4
        with:
          name: artefatos-v4
          path: artefatos/

      - name: Distribuir para diretórios finais
        run: |
          mkdir -p instrumento ritual extraplanar
          for f in artefatos/*.dart; do
            [ -f "$f" ] && cp "$f" instrumento/ && cp "$f" ritual/ && cp "$f" extraplanar/
          done

      - name: Atualizar README
        run: |
          for f in artefatos/*.dart; do
            [ -f "$f" ] && echo "- $(basename "$f" .dart)" >> README.md
          done

      - name: Commitar promoções
        uses: stefanzweifel/git-auto-commit-action@v5
        with:
          commit_message: '✅ Artefatos promovidos e README atualizado'
          branch: Tutor-Demoníaco
