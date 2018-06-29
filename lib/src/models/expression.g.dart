// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expression.dart';

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

class ExpressionNode extends _ExpressionNode {
  ExpressionNode(
      {@required this.type,
      this.typeArgument,
      this.unaryOperator,
      this.binaryOperator,
      this.name,
      this.length,
      this.intValue,
      this.floatValue,
      this.left,
      this.right,
      this.initializer,
      this.callee,
      List<_ExpressionNode> arguments})
      : this.arguments = new List.unmodifiable(arguments ?? []);

  @override
  final ExpressionNodeType type;

  @override
  final ExpressionNodeType typeArgument;

  @override
  final UnaryOperator unaryOperator;

  @override
  final BinaryOperator binaryOperator;

  @override
  final String name;

  @override
  final int length;

  @override
  final int intValue;

  @override
  final double floatValue;

  @override
  final _ExpressionNode left;

  @override
  final _ExpressionNode right;

  @override
  final _ExpressionNode initializer;

  @override
  final _ExpressionNode callee;

  @override
  final List<_ExpressionNode> arguments;

  ExpressionNode copyWith(
      {ExpressionNodeType type,
      ExpressionNodeType typeArgument,
      UnaryOperator unaryOperator,
      BinaryOperator binaryOperator,
      String name,
      int length,
      int intValue,
      double floatValue,
      _ExpressionNode left,
      _ExpressionNode right,
      _ExpressionNode initializer,
      _ExpressionNode callee,
      List<_ExpressionNode> arguments}) {
    return new ExpressionNode(
        type: type ?? this.type,
        typeArgument: typeArgument ?? this.typeArgument,
        unaryOperator: unaryOperator ?? this.unaryOperator,
        binaryOperator: binaryOperator ?? this.binaryOperator,
        name: name ?? this.name,
        length: length ?? this.length,
        intValue: intValue ?? this.intValue,
        floatValue: floatValue ?? this.floatValue,
        left: left ?? this.left,
        right: right ?? this.right,
        initializer: initializer ?? this.initializer,
        callee: callee ?? this.callee,
        arguments: arguments ?? this.arguments);
  }

  bool operator ==(other) {
    return other is _ExpressionNode &&
        other.type == type &&
        other.typeArgument == typeArgument &&
        other.unaryOperator == unaryOperator &&
        other.binaryOperator == binaryOperator &&
        other.name == name &&
        other.length == length &&
        other.intValue == intValue &&
        other.floatValue == floatValue &&
        other.left == left &&
        other.right == right &&
        other.initializer == initializer &&
        other.callee == callee &&
        const ListEquality<_ExpressionNode>(
                const DefaultEquality<_ExpressionNode>())
            .equals(other.arguments, arguments);
  }

  Map<String, dynamic> toJson() {
    return ExpressionNodeSerializer.toMap(this);
  }
}
