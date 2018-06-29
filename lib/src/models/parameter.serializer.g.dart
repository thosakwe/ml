// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameter.dart';

// **************************************************************************
// SerializerGenerator
// **************************************************************************

abstract class ParameterNodeSerializer {
  static ParameterNode fromMap(Map map) {
    if (map['name'] == null) {
      throw new FormatException(
          "Missing required field 'name' on ParameterNode.");
    }

    if (map['type'] == null) {
      throw new FormatException(
          "Missing required field 'type' on ParameterNode.");
    }

    return new ParameterNode(
        name: map['name'] as String,
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
        size: map['size'] as int);
  }

  static Map<String, dynamic> toMap(ParameterNode model) {
    if (model == null) {
      return null;
    }
    if (model.name == null) {
      throw new FormatException(
          "Missing required field 'name' on ParameterNode.");
    }

    if (model.type == null) {
      throw new FormatException(
          "Missing required field 'type' on ParameterNode.");
    }

    return {
      'name': model.name,
      'type': model.type == null
          ? null
          : ExpressionNodeType.values.indexOf(model.type),
      'type_argument': model.typeArgument == null
          ? null
          : ExpressionNodeType.values.indexOf(model.typeArgument),
      'size': model.size
    };
  }
}

abstract class ParameterNodeFields {
  static const String name = 'name';

  static const String type = 'type';

  static const String typeArgument = 'type_argument';

  static const String size = 'size';
}
