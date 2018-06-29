// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameter.dart';

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

class ParameterNode implements _ParameterNode {
  const ParameterNode(
      {@required this.name, @required this.type, this.typeArgument, this.size});

  @override
  final String name;

  @override
  final ExpressionNodeType type;

  @override
  final ExpressionNodeType typeArgument;

  @override
  final int size;

  ParameterNode copyWith(
      {String name,
      ExpressionNodeType type,
      ExpressionNodeType typeArgument,
      int size}) {
    return new ParameterNode(
        name: name ?? this.name,
        type: type ?? this.type,
        typeArgument: typeArgument ?? this.typeArgument,
        size: size ?? this.size);
  }

  bool operator ==(other) {
    return other is _ParameterNode &&
        other.name == name &&
        other.type == type &&
        other.typeArgument == typeArgument &&
        other.size == size;
  }

  Map<String, dynamic> toJson() {
    return ParameterNodeSerializer.toMap(this);
  }
}
