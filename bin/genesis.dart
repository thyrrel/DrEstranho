// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃ ⚙️ bin/genesis.dart – Vasculha repos, cria prompt, gera artefato            ┃
// ┃ 🔮 byThyrrel | IA local | Fallback GEMINI_API_KEY                          ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  // 1. Vasculha TODOS os repos do dono
  final repos = await _listRepos();
  for (final repo in repos) {
    final name = repo['name'] as String;
    final cloneUrl = repo['clone_url'] as String;
    final dir = Directory.systemTemp.createTempSync('repo_$name');
    print('🔍 Analisando $name');
    await _clone(cloneUrl, dir.path);
    if (await _isValidPlugin(dir)) {
      final prompt = await _buildPrompt(dir, name);
      File('recipes/$name.txt').writeAsStringSync(prompt);
      print('✅ Prompt real gerado: recipes/$name.txt');
    }
    dir.deleteSync(recursive: true);
  }

  // 2. Processa apenas .txt reais em recipes/
  final recipesDir = Directory('recipes');
  if (!recipesDir.existsSync()) return;
  final txts = recipesDir
      .listSync(recursive: false)
      .whereType<File>()
      .where((f) => f.path.endsWith('.txt'))
      .toList();

  for (final txt in txts) {
    final base = _basename(txt.path, '.txt');
    final rituaisDir = Directory('rituais')..createSync(recursive: true);
    final artefato = File('rituais/$base.dart');

    // Gera código com IA local; se falhar usa Gemini
    final conteudo = txt.readAsStringSync();
    final code = await _gerarCodigo(conteudo, base);
    artefato.writeAsStringSync(code);
    print('✅ Artefato criado: rituais/$base.dart');
  }
}

/* ---------- IA ---------- */
Future<String> _gerarCodigo(String prompt, String nome) async {
  // 1. Tenta IA local (dart:io + Process)
  try {
    final local = await _iaLocal(prompt, nome);
    if (local.isNotEmpty) return local;
  } catch (e) {
    print('⚠️ IA local falhou: $e');
  }

  // 2. Fallback Gemini
  final gemini = await _iaGemini(prompt, nome);
  return gemini.isNotEmpty ? gemini : '// Artefato $nome - código placeholder';
}

Future<String> _iaLocal(String prompt, String nome) async {
  // Prompt simples para gerar plugin Dart
  final pr = await Process.run('dart', [
    'run',
    'tool/ia_local.dart',
    nome,
    prompt,
  ]);
  return pr.exitCode == 0 ? pr.stdout.trim() : '';
}

Future<String> _iaGemini(String prompt, String nome) async {
  final key = Platform.environment['GEMINI_API_KEY'] ?? '';
  if (key.isEmpty) return '';
  final url = Uri.https('generativelanguage.googleapis.com',
      '/v1beta/models/gemini-pro:generateContent', {'key': key});
  final body = jsonEncode({
    "contents": [
      {
        "parts": [
          {
            "text":
                "Crie um plugin Dart completo (apenas código) para o app descrito:\n$prompt\nNome do arquivo: $nome.dart"
          }
        ]
      }
    ]
  });
  final client = HttpClient();
  final req = await client.postUrl(url)
    ..headers.contentType = ContentType.json
    ..write(body);
  final res = await req.close();
  if (res.statusCode != 200) return '';
  final raw = await res.transform(utf8.decoder).join();
  client.close();
  final data = jsonDecode(raw);
  return data['candidates']?[0]?['content']?['parts']?[0]?['text'] ?? '';
}

/* ---------- UTILS ---------- */
Future<List<dynamic>> _listRepos() async {
  final user = Platform.environment['GITHUB_REPOSITORY_OWNER'] ?? 'thyrrel';
  final client = HttpClient();
  final req = await client.getUrl(Uri.https('api.github.com', '/users/$user/repos'));
  final res = await req.close();
  if (res.statusCode != 200) throw Exception('Erro ao listar repos (HTTP ${res.statusCode})');
  final raw = await res.transform(utf8.decoder).join();
  client.close();
  return jsonDecode(raw) as List;
}

Future<void> _clone(String url, String path) async {
  final pr = await Process.run('git', ['clone', '--depth', '1', url, path]);
  if (pr.exitCode != 0) throw Exception('Clone falhou: ${pr.stderr}');
}

Future<bool> _isValidPlugin(Directory dir) async {
  final pubspec = File('${dir.path}/pubspec.yaml');
  if (!pubspec.existsSync()) return false;
  final content = pubspec.readAsStringSync();
  return content.contains('executables:') || Directory('${dir.path}/bin').existsSync();
}

Future<String> _buildPrompt(Directory dir, String repo) async {
  final buffer = StringBuffer()..writeln('Plugin: $repo');
  final binDir = Directory('${dir.path}/bin');
  if (binDir.existsSync()) {
    for (final f in binDir.listSync().whereType<File>().where((f) => f.path.endsWith('.dart'))) {
      buffer.writeln('Código: ${_basename(f.path, '.dart')}');
    }
  }
  return buffer.toString();
}

String _basename(String path, String ext) =>
    path.split('/').last.replaceAll(ext, '');
