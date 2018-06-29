import 'package:angel_serialize/angel_serialize.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'expression.dart';
import 'function.dart';

part 'program.g.dart';

part 'program.serializer.g.dart';

@Serializable(autoIdAndDateFields: false)
abstract class _ProgramNode {
  @required
  ExpressionNode get entryPoint;

  @required
  List<FunctionNode> get functions;
}
