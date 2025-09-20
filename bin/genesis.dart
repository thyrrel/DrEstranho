import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  // 1. Vasculha todos os repositórios do usuário
  final repos = await _listRepos();
  for (final repo in repos) {
    final name = repo['name'] as String;
    final cloneUrl = repo['clone_url'] as String;
    final dir = Directory.systemTemp.createTempSync('repo_$name');
    print('🔍 Analisando $name');
    await _clone(cloneUrl, dir.path);
    if (await _isValidPlugin(dir)) {
      final prompt = await _buildPrompt(dir, name);
      File('recipe/$name').writeAsStringSync(prompt);
      print('✅ Prompt gerado: recipe/$name');
    }
    dir.deleteSync(recursive: true);
  }

  // 2. Processa arquivos .txt na pasta recipe
  final recipeDir = Directory('recipe');
  if (!recipeDir.existsSync()) return;
  final txts = recipeDir
      .listSync(recursive: false)
      .whereType<File>()
      .where((f) => f.path.endsWith('.txt'))
      .toList();

  for (final txt in txts) {
    final base = basename(txt.path, '.txt');
    final artefato = File('artefatos/$base.dart');
    final artefatosDir = Directory('artefatos')..createSync(recursive: true);

    // Gera artefato
    final buffer = StringBuffer()
      ..writeln('// Plugin: $base')
      ..writeln('void main() => print(\'Plugin $base carregado\');');
    artefato.writeAsStringSync(buffer.toString());

    // Valida
    final result = await Process.run('dart', ['analyze', artefato.path]);
    if (result.exitCode != 0) {
      // Falha → renomeia para *_infernus
      txt.renameSync('recipe/${base}_infernus');
      print('⚠️ Falhou: $base → ${base}_infernus');
    } else {
      // Sucesso → move para /recipes/acervo (sem .txt)
      final acervo = Directory('recipes/acervo')..createSync(recursive: true);
      txt.renameSync('recipes/acervo/$base');
      print('✅ OK: $base movido para acervo');
    }
  }
}

Future<List<dynamic>> _listRepos() async {
  final user = Platform.environment['GITHUB_REPOSITORY_OWNER'] ?? 'thyrrel';
  final res = await get(Uri.https('api.github.com', '/users/$user/repos'));
  if (res.statusCode != 200) throw Exception('Erro ao listar repos');
  return jsonDecode(res.body) as List;
}

Future<void> _clone(String url, String path) async {
  final pr = await Process.run('git', ['clone', '--depth', '1', url, path]);
  if (pr.exitCode != 0) throw Exception('Clone falhou');
}

Future<bool> _isValidPlugin(Directory dir) async {
  // Presença de pubspec.yaml com executável ou bin/
  final pubspec = File('${dir.path}/pubspec.yaml');
  if (!pubspec.existsSync()) return false;
  final content = pubspec.readAsStringSync();
  if (content.contains('executables:') || Directory('${dir.path}/bin').existsSync()) {
    return true;
  }
  return false;
}

Future<String> _buildPrompt(Directory dir, String repo) async {
  final buffer = StringBuffer()..writeln('Plugin: $repo');
  final binDir = Directory('${dir.path}/bin');
  if (binDir.existsSync()) {
    for (final f in binDir.listSync().whereType<File>().where((f) => f.path.endsWith('.dart'))) {
      buffer.writeln('Código: ${basename(f.path, '.dart')}');
    }
  }
  return buffer.toString();
}

Future<HttpClientResponse> get(Uri uri) =>
    HttpClient().getUrl(uri).then((r) => r.close());

String basename(String path, String ext) =>
    path.split('/').last.replaceAll(ext, '');
