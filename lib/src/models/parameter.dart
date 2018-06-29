import 'package:angel_serialize/angel_serialize.dart';
import 'package:meta/meta.dart';
import 'expression.dart';
part 'parameter.g.dart';
part 'parameter.serializer.g.dart';

@Serializable(autoIdAndDateFields: false)
abstract class _ParameterNode {
  @required
  String get name;

  @required
  ExpressionNodeType get type;

  ExpressionNodeType get typeArgument;

  int get size;
}
