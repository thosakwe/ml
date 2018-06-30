import 'dart:async';
import 'package:c_builder/c_builder.dart';
import 'package:ml/ml.dart';

class CCompiler extends Compiler {
  final CompilationUnit headerFile = new CompilationUnit();
  final CompilationUnit sourceFile = new CompilationUnit();

  final FutureOr<RunnableProgram> Function(CCompiler) compileAst;

  CCompiler(this.compileAst);

  @override
  Future<RunnableProgram> compile(ProgramNode node) {
    for (var function in node.functions ?? <FunctionNode>[]) {
      compileFunction(function);
    }

    compileEntryPoint(node);
    return new Future<RunnableProgram>.sync(() => compileAst(this));
  }

  void compileEntryPoint(ProgramNode node) {

  }

  void compileFunction(FunctionNode node) {

  }
}
