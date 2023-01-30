// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: Apache-2.0

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:aws_common/aws_common.dart';
import 'package:file/local.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as path;
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:smithy/ast.dart';
import 'package:smithy_codegen/smithy_codegen.dart';

final modelsPath = {
  SmithyVersion.v1: path.join(Directory.current.path, 'models'),
  SmithyVersion.v2: path.join(Directory.current.path, 'models2'),
};
const skipProtocols = [
  'shared',
];
const awsProtocols = [
  'awsJson1_0',
  'awsJson1_1',
  'restJson1',
  'restXml',
  'restXmlWithNamespace'
];

Future<void> main(List<String> args) async {
  final argParser = ArgParser()
    ..addFlag(
      'update',
      help: 'Whether to update test models from git',
      defaultsTo: false,
    );
  final parsedArgs = argParser.parse(args);
  final update = parsedArgs['update'] as bool;
  if (update) {
    await updateModels();
  }
  final glob = Glob(parsedArgs.rest.length == 1 ? parsedArgs.rest.single : '*');
  final futures = <Future>[];
  for (final version in SmithyVersion.values) {
    final entites = glob.listFileSystemSync(
      const LocalFileSystem(),
      root: modelsPath[version],
    );
    for (final modelEnt in entites.whereType<Directory>()) {
      futures.add(_generateFor(version, modelEnt, update: update));
    }
  }
  await Future.wait<void>(futures);
}

String _replaceDirectory(String path, {bool create = false}) {
  final dir = Directory(path);
  if (dir.existsSync()) {
    dir.deleteSync(recursive: true);
  }
  if (create) {
    dir.createSync(recursive: true);
  }
  return path;
}

Future<void> _copy(String from, String to) async {
  final process = await Process.start(
    'cp',
    ['-R', from, to],
    mode: ProcessStartMode.inheritStdio,
    workingDirectory: Directory.current.path,
  );
  if (await process.exitCode != 0) {
    stderr.writeln('Could not copy $from to $to');
    exit(1);
  }
}

/// Updates v2 models from git.
///
/// v1 models are no longer committed to git and are fixed at the last commit
/// in which they were updated.
Future<void> updateModels() async {
  final smithyVersion = File.fromUri(
    Platform.script.resolve('../smithy-version'),
  ).readAsStringSync().trim();
  const url = 'https://github.com/awslabs/smithy';
  final tmpDir = Directory.systemTemp.createTempSync('smithy');
  final process = await Process.start(
    'git',
    [
      'clone',
      '--depth=1',
      '--branch',
      smithyVersion,
      url,
      tmpDir.path,
    ],
    mode: ProcessStartMode.inheritStdio,
    workingDirectory: Directory.current.path,
  );
  if (await process.exitCode != 0) {
    stderr.writeln('Could not clone $url');
    exit(1);
  }
  for (final protocol in awsProtocols) {
    final src = path.join(
      tmpDir.path,
      'smithy-aws-protocol-tests',
      'model',
      protocol,
    );
    final dest = _replaceDirectory(
      path.join(modelsPath[SmithyVersion.v2]!, protocol),
    );
    await _copy(src, dest);
  }

  // Copy shared types
  final sharedPath = _replaceDirectory(
    path.join(modelsPath[SmithyVersion.v2]!, 'shared'),
    create: true,
  );
  const sharedModels = [
    'aws-config.smithy',
    'shared-types.smithy',
  ];
  for (final sharedModel in sharedModels) {
    final sourcePath = path.join(
      tmpDir.path,
      'smithy-aws-protocol-tests',
      'model',
      sharedModel,
    );
    await _copy(sourcePath, sharedPath);
  }

  // Replace `coral` references
  for (final file in Directory(modelsPath[SmithyVersion.v2]!)
      .listSync(recursive: true)
      .whereType<File>()) {
    final content = file.readAsStringSync();
    file.writeAsStringSync(content.replaceAll('coral', 'example'));
  }
}

Future<void> _generateFor(
  SmithyVersion version,
  FileSystemEntity modelEnt, {
  required bool update,
}) async {
  final modelPath = path.relative(modelEnt.path, from: modelsPath[version]);
  final protocolName = path.basename(modelPath);
  if (skipProtocols.contains(protocolName)) {
    return;
  }
  final outputPath = path.join(
    version == SmithyVersion.v1 ? 'lib' : 'lib2',
    protocolName,
  );
  final dir = Directory(outputPath);
  if (dir.existsSync()) {
    dir.deleteSync(recursive: true);
  }

  stdout.writeln('Generating AST for $modelPath');

  final preCompiled = File('${modelEnt.path}.json');
  if (!preCompiled.existsSync() || (update && version == SmithyVersion.v2)) {
    final result = await Process.run(
      Platform.script.resolve('../gradlew').toFilePath(),
      [
        'run',
        '--args=${modelsPath[version]} $protocolName',
      ],
      stdoutEncoding: utf8,
      stderrEncoding: utf8,
    );
    if (result.exitCode != 0) {
      stderr.write('Could not generate model for $modelPath: ');
      stderr.writeln(result.stdout);
      stderr.writeln(result.stderr);
      exit(result.exitCode);
    }
  }

  final astJson = preCompiled.readAsStringSync();
  final packageName = '${protocolName.snakeCase}_${version.name}';
  final ast = parseAstJson(astJson);

  final outputs = generateForAst(
    ast,
    packageName: packageName,
    additionalShapes: const [
      ShapeId(namespace: 'aws.protocoltests.config', shape: 'AwsConfig'),
    ],
    generateServer: true,
  );

  final Set<String> dependencies = {};
  for (var library in outputs.values.expand((out) => out.libraries)) {
    final smithyLibrary = library.smithyLibrary;
    final outPath = path.join(outputPath, smithyLibrary.projectRelativePath);
    final output = library.emit();
    dependencies.addAll(library.dependencies);
    File(outPath)
      ..createSync(recursive: true)
      ..writeAsStringSync(output);
  }

  // Create dummy pubspec
  final pubspecPath = path.join(outputPath, 'pubspec.yaml');
  final pubspec = Pubspec(packageName);
  final localSmithyPath = Directory.current.uri.resolve('..').path;
  final pubspecYaml = PubspecGenerator(
    pubspec,
    dependencies,
    smithyPath: path.relative(localSmithyPath, from: outputPath),
  ).generate();
  File(pubspecPath).writeAsStringSync(pubspecYaml);

  // Create analysis options
  final analysisOptionsPath = path.join(outputPath, 'analysis_options.yaml');
  File(analysisOptionsPath).writeAsStringSync('''
include: package:lints/recommended.yaml

analyzer:
  errors:
    avoid_unused_constructor_parameters: ignore
    non_constant_identifier_names: ignore
    prefer_interpolation_to_compose_strings: ignore
''');

  // Create mono_pkg for testing
  final dartTestPath = path.join(outputPath, 'dart_test.yaml');
  File(dartTestPath).writeAsStringSync('''
override_platforms:
  firefox:
    settings:
      arguments: -headless
''');

  // Run `dart pub get`
  final pubGetRes = await Process.run(
    'dart',
    [
      'pub',
      'get',
    ],
    workingDirectory: outputPath,
    stdoutEncoding: utf8,
    stderrEncoding: utf8,
  );
  if (pubGetRes.exitCode != 0) {
    stderr.write('`dart pub get` failed for $outputPath: ');
    stderr.writeln(pubGetRes.stdout);
    stderr.writeln(pubGetRes.stderr);
    exit(pubGetRes.exitCode);
  }

  // Run built_value generator
  final buildRunnerCmd = await Process.start(
    'dart',
    [
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
    ],
    workingDirectory: outputPath,
  );
  buildRunnerCmd.stdout
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .listen(stdout.writeln);
  buildRunnerCmd.stderr
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .listen(stderr.writeln);
  final exitCode = await buildRunnerCmd.exitCode;
  if (exitCode != 0) {
    stderr.write(
      '`dart run build_runner build` failed for $outputPath: $exitCode.',
    );
    exit(exitCode);
  }
}