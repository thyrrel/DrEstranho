# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃ 🧭 Arconte.yml - Ritual de inspeção extraplanar e migração de rituais      ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

name: Arconte Ritual

on:
  workflow_dispatch:
  schedule:
    - cron: '0 3 * * *' # Executa diariamente às 03:00 UTC

jobs:
  vasculhar_extraplanares:
    runs-on: ubuntu-latest

    steps:
      - name: 📦 Checkout do grimório
        uses: actions/checkout@v3

      - name: 🧙 Instalar Dart
        uses: dart-lang/setup-dart@v1

      - name: 📦 Instalar dependências
        run: dart pub get

      - name: 🧭 Invocar Arconte
        run: dart run lib/tutor/arconte.dart
