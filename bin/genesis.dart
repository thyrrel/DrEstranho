import 'dart:convert';
import 'dart:io';

Future<void> main() async {
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

  final recipeDir = Directory('recipe');
  if (!recipeDir.existsSync()) return;
  final txts = recipeDir
      .listSync(recursive: false)
      .whereType<File>()
      .where((f) => f.path.endsWith('.txt'))
      .toList();

  for (final txt in txts) {
    final base = _basename(txt.path, '.txt');
    final artefatosDir = Directory('artefatos')..createSync(recursive: true);
    final artefato = File('${artefatosDir.path}/$base.dart');

    final buffer = StringBuffer()
      ..writeln('// Plugin: $base')
      ..writeln('void main() => print("Plugin $base carregado");');
    artefato.writeAsStringSync(buffer.toString());

    final result = await Process.run('dart', ['analyze', '--fatal-infos', artefato.path]);
    if (result.exitCode != 0) {
      txt.renameSync('recipe/${base}_infernus');
      print('⚠️  Falhou: $base → ${base}_infernus');
    } else {
      final acervo = Directory('recipes/acervo')..createSync(recursive: true);
      txt.renameSync('recipes/acervo/$base');
      print('✅ OK: $base movido para acervo');
    }
  }
}

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
  return content.contains('executables:') || Directory('${dir.path}/bin').existsSync;
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
