// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ 🧿 Olho de Agamoto - Executor dimensional                                  ┃
// ┃ 🔮 byThyrrel | Reescreve prompt na branch Tutor-Demoniaco/recipes         ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

import 'dart:convert';
import 'dart:io';
import 'package:github/github.dart';

Future<void> main(List<String> args) async {
  final file = File(args[0]);
  final prompt = await file.readAsString();

  final nome = extractNome(prompt);
  final github = GitHub(auth: Authentication.withToken('YOUR_PERSONAL_TOKEN'));
  final repo = RepositorySlug('usuario', 'repositorio');

  await github.repositories.createOrUpdateFileContents(
    repo,
    'recipes/$nome.txt',
    CreateOrUpdateFileContents(
      message: '📜 Recipe criada para $nome',
      content: base64Encode(utf8.encode(prompt)),
      branch: 'Tutor-Demoniaco',
    ),
  );
}

String extractNome(String prompt) {
  final match = RegExp(r'\{(.+?)\.txt\}').firstMatch(prompt);
  return match != null ? match.group(1)! : 'ritual_${DateTime.now().millisecondsSinceEpoch}';
}
