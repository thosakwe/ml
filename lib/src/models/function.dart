import 'package:angel_serialize/angel_serialize.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'expression.dart';
import 'parameter.dart';
part 'function.g.dart';
part 'function.serializer.g.dart';

@Serializable(autoIdAndDateFields: false)
abstract class _FunctionNode {
  @required
  String get name;

  @required
  ExpressionNodeType get returnType;

  @required
  List<ParameterNode> get parameters;
}
