import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final dir = context.vars['project_name'] as String;
  if (!Directory(dir).existsSync()) {
    context.logger.warn('Papka topilmadi: $dir'); return;
  }

  final kroot = '$dir/android/app/src/main/kotlin';
  final marker = Directory('$kroot/__KOTLIN_PKG__');
  if (marker.existsSync()) {
    final appId = context.vars['application_id'] as String;
    final target = Directory('$kroot/${appId.split('.').join('/')}')..createSync(recursive: true);
    for (final e in marker.listSync()) {
      if (e is File) e.renameSync('${target.path}/${e.uri.pathSegments.last}');
    }
    marker.deleteSync(recursive: true);
  }

  Future<void> sh(String exe, List<String> a) async {
    context.logger.info('> $exe ${a.join(' ')}');
    final r = await Process.run(exe, a, workingDirectory: dir, runInShell: true);
    if (r.exitCode != 0) context.logger.warn('${r.stderr}');
  }

  await sh('flutter', ['pub', 'get']);
  await sh('dart', ['run', 'build_runner', 'build', '--delete-conflicting-outputs']);
  context.logger.success('✅ Tayyor: $dir');
}
