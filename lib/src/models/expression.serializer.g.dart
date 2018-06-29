// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expression.dart';

// **************************************************************************
// SerializerGenerator
// **************************************************************************

abstract class ExpressionNodeSerializer {
  static ExpressionNode fromMap(Map map) {
    if (map['type'] == null) {
      throw new FormatException(
          "Missing required field 'type' on ExpressionNode.");
    }

    return new ExpressionNode(
        type: map['type'] is ExpressionNodeType
            ? (map['type'] as ExpressionNodeType)
            : (map['type'] is int
                ? ExpressionNodeType.values[map['type'] as int]
                : null),
        typeArgument: map['type_argument'] is ExpressionNodeType
            ? (map['type_argument'] as ExpressionNodeType)
            : (map['type_argument'] is int
                ? ExpressionNodeType.values[map['type_argument'] as int]
                : null),
        unaryOperator: map['unary_operator'] is UnaryOperator
            ? (map['unary_operator'] as UnaryOperator)
            : (map['unary_operator'] is int
                ? UnaryOperator.values[map['unary_operator'] as int]
                : null),
        binaryOperator: map['binary_operator'] is BinaryOperator
            ? (map['binary_operator'] as BinaryOperator)
            : (map['binary_operator'] is int
                ? BinaryOperator.values[map['binary_operator'] as int]
                : null),
        name: map['name'] as String,
        length: map['length'] as int,
        intValue: map['int_value'] as int,
        floatValue: map['float_value'] as double,
        left: map['left'] != null
            ? ExpressionNodeSerializer.fromMap(map['left'] as Map)
            : null,
        right: map['right'] != null
            ? ExpressionNodeSerializer.fromMap(map['right'] as Map)
            : null,
        initializer: map['initializer'] != null
            ? ExpressionNodeSerializer.fromMap(map['initializer'] as Map)
            : null,
        callee: map['callee'] != null
            ? ExpressionNodeSerializer.fromMap(map['callee'] as Map)
            : null,
        arguments: map['arguments'] is Iterable
            ? new List.unmodifiable(((map['arguments'] as Iterable)
                    .where((x) => x is Map) as Iterable<Map>)
                .map(ExpressionNodeSerializer.fromMap))
            : null);
  }

  static Map<String, dynamic> toMap(ExpressionNode model) {
    if (model == null) {
      return null;
    }
    if (model.type == null) {
      throw new FormatException(
          "Missing required field 'type' on ExpressionNode.");
    }

    return {
      'type': model.type == null
          ? null
          : ExpressionNodeType.values.indexOf(model.type),
      'type_argument': model.typeArgument == null
          ? null
          : ExpressionNodeType.values.indexOf(model.typeArgument),
      'unary_operator': model.unaryOperator == null
          ? null
          : UnaryOperator.values.indexOf(model.unaryOperator),
      'binary_operator': model.binaryOperator == null
          ? null
          : BinaryOperator.values.indexOf(model.binaryOperator),
      'name': model.name,
      'length': model.length,
      'int_value': model.intValue,
      'float_value': model.floatValue,
      'left': (model.left)?.toJson(),
      'right': (model.right)?.toJson(),
      'initializer': (model.initializer)?.toJson(),
      'callee': (model.callee)?.toJson(),
      'arguments': model.arguments?.map((m) => m.toJson())?.toList()
    };
  }
}

abstract class ExpressionNodeFields {
  static const String type = 'type';

  static const String typeArgument = 'type_argument';

  static const String unaryOperator = 'unary_operator';

  static const String binaryOperator = 'binary_operator';

  static const String name = 'name';

  static const String length = 'length';

  static const String intValue = 'int_value';

  static const String floatValue = 'float_value';

  static const String left = 'left';

  static const String right = 'right';

  static const String initializer = 'initializer';

  static const String callee = 'callee';

  static const String arguments = 'arguments';
}
