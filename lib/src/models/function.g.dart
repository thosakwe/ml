// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'function.dart';

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

class FunctionNode implements _FunctionNode {
  const FunctionNode(
      {@required this.name,
      @required this.returnType,
      @required List<ParameterNode> this.parameters});

  @override
  final String name;

  @override
  final ExpressionNodeType returnType;

  @override
  final List<ParameterNode> parameters;

  FunctionNode copyWith(
      {String name,
      ExpressionNodeType returnType,
      List<ParameterNode> parameters}) {
    return new FunctionNode(
        name: name ?? this.name,
        returnType: returnType ?? this.returnType,
        parameters: parameters ?? this.parameters);
  }

  bool operator ==(other) {
    return other is _FunctionNode &&
        other.name == name &&
        other.returnType == returnType &&
        const ListEquality<ParameterNode>(
                const DefaultEquality<ParameterNode>())
            .equals(other.parameters, parameters);
  }

  Map<String, dynamic> toJson() {
    return FunctionNodeSerializer.toMap(this);
  }
}
