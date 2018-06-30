import 'dart:async';
import 'package:ml/ml.dart';

/// On-the-fly compiles a [program] into a native executable, so that it can be run.
abstract class Compiler {
  Future<RunnableProgram> compile(ProgramNode node);
}
