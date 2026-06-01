import 'package:mason/mason.dart';

void run(HookContext context) {
  final raw = (context.vars['project_name'] as String).trim();
  context.vars['project_name'] = _snake(raw);

  final appId = (context.vars['application_id'] as String).trim();
  final parts = appId.split('.');
  final last = parts.isEmpty ? appId : parts.removeLast();
  context.vars['ios_bundle_id'] = [...parts, _camel(last)].join('.');

  context.logger.info('project_name: ${context.vars['project_name']}');
  context.logger.info('ios_bundle_id: ${context.vars['ios_bundle_id']}');
}

String _snake(String s) => s
    .replaceAll(RegExp(r'[^A-Za-z0-9]+'), '_')
    .replaceAllMapped(RegExp(r'([a-z0-9])([A-Z])'), (m) => '${m[1]}_${m[2]}')
    .toLowerCase()
    .replaceAll(RegExp(r'_+'), '_')
    .replaceAll(RegExp(r'^_|_$'), '');

String _camel(String input) {
  final segs = input.split(RegExp(r'[_\-]')).where((s) => s.isNotEmpty).toList();
  if (segs.isEmpty) return input;
  final rest = segs.skip(1).map((s) => '${s[0].toUpperCase()}${s.substring(1)}');
  return [segs.first, ...rest].join();
}
