import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:c_builder/c_builder.dart';
import 'package:code_buffer/code_buffer.dart';
import 'argv.dart';
import 'backend.dart';
import 'value.dart';

const Backend c = const CBackend();

class CBackend extends Backend {
  const CBackend();

  @override
  FutureOr<Runnable<T>> compile<T>(Value<T> program) async {
    var unit = CompilationUnit();
    var sig = FunctionSignature(CType.int, 'main');
    var main = CFunction(sig);

    sig.parameters.addAll([
      Parameter(CType.int, 'argc'),
      Parameter(CType.char.pointer().pointer(), 'argv'),
    ]);

    unit.body.addAll([
      Include.system('stdio.h'),
      Include.system('stdlib.h'),
      main,
    ]);

    var value = compileValue(program);

    main.body.add(Expression('printf').invoke([
      Expression.value('%f'),
      value.cast(CType.double),
    ]));

    main.body.add(Expression.value(0).asReturn());

    var buffer = CodeBuffer();
    unit.generate(buffer);

    var dir = await Directory.systemTemp.createTemp();
    var file = File.fromUri(dir.uri.resolve('ml$hashCode.c'));

    // gcc -o lexer.o -xc -
    var gcc = await Process.start('gcc', ['-o', file.absolute.path, '-xc', '-'],
        runInShell: true);
    gcc.stdin.write(buffer.toString());
    await gcc.stdin.close();

    var exit = await gcc.exitCode;
    await gcc.stdout.drain();

    if (exit != 0) {
      var err = await gcc.stderr.transform(utf8.decoder).join();
      throw StateError(
          '`gcc` terminated with exit code $exit and stderr: $err');
    } else {
      await gcc.stderr.drain();
      return _CRunnable<T>(file);
    }
  }

  Expression compileValue<T>(Value<T> value) {
    if (value is Constant<T>) {
      return Expression(value.value.toString());
    } else if (value is Variable<T>) {
      return Expression(value.name.toString());
    } else if (value is Binary<T>) {
      var left = compileValue(value.left).parentheses().code,
          right = compileValue(value.right).parentheses().code;
      return Expression('$left ${value.op} $right');
    } else if (value is ArgvValueParser<T>) {
      var callee = Expression(value.parserFunctionName);
      var arg = Expression('argv')[Expression(value.index.toString())];
      return callee.invoke([arg]);
    }

    throw ArgumentError.value(value, 'value', 'unsupported value');
  }
}

class _CRunnable<T> extends Runnable<T> {
  final File file;

  _CRunnable(this.file);

  @override
  FutureOr<T> run({Iterable<T> argv = const []}) async {
    var result = await Process.run(
        file.absolute.path, argv.map((x) => x.toString()).toList(),
        stdoutEncoding: utf8, stderrEncoding: utf8, runInShell: true);

    if (result.exitCode != 0) {
      throw StateError(
          'Runnable terminated with exit code ${result.exitCode} and stderr: ${result.stderr}');
    } else {
      // TODO: Other values
      var n = num.parse(result.stdout as String);
      if (T == int)
        return n.toInt() as T;
      else if (T == double)
        return n.toDouble() as T;
      else if (T == num)
        return n as T;
      else
        throw ArgumentError.value(T, 'T', 'must be int, double, or num');
    }
  }
}
