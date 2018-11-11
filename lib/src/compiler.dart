import 'package:c_builder/c_builder.dart';

class CCompiler {
  final header = new CompilationUnit();
  final implementation = new CompilationUnit();
}

abstract class CompilesTo<T extends Code> {
  T compile(CCompiler compiler);
}
