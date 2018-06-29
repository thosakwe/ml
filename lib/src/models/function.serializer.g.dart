// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'function.dart';

// **************************************************************************
// SerializerGenerator
// **************************************************************************

abstract class FunctionNodeSerializer {
  static FunctionNode fromMap(Map map) {
    if (map['name'] == null) {
      throw new FormatException(
          "Missing required field 'name' on FunctionNode.");
    }

    if (map['return_type'] == null) {
      throw new FormatException(
          "Missing required field 'return_type' on FunctionNode.");
    }

    if (map['parameters'] == null) {
      throw new FormatException(
          "Missing required field 'parameters' on FunctionNode.");
    }

    return new FunctionNode(
        name: map['name'] as String,
        returnType: map['return_type'] is ExpressionNodeType
            ? (map['return_type'] as ExpressionNodeType)
            : (map['return_type'] is int
                ? ExpressionNodeType.values[map['return_type'] as int]
                : null),
        parameters: map['parameters'] as List<ParameterNode>);
  }

  static Map<String, dynamic> toMap(FunctionNode model) {
    if (model == null) {
      return null;
    }
    if (model.name == null) {
      throw new FormatException(
          "Missing required field 'name' on FunctionNode.");
    }

    if (model.returnType == null) {
      throw new FormatException(
          "Missing required field 'return_type' on FunctionNode.");
    }

    if (model.parameters == null) {
      throw new FormatException(
          "Missing required field 'parameters' on FunctionNode.");
    }

    return {
      'name': model.name,
      'return_type': model.returnType == null
          ? null
          : ExpressionNodeType.values.indexOf(model.returnType),
      'parameters': model.parameters
    };
  }
}

abstract class FunctionNodeFields {
  static const String name = 'name';

  static const String returnType = 'return_type';

  static const String parameters = 'parameters';
}
