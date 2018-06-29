// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program.dart';

// **************************************************************************
// JsonModelGenerator
// **************************************************************************

class ProgramNode implements _ProgramNode {
  const ProgramNode(
      {@required this.entryPoint, @required List<FunctionNode> this.functions});

  @override
  final ExpressionNode entryPoint;

  @override
  final List<FunctionNode> functions;

  ProgramNode copyWith(
      {ExpressionNode entryPoint, List<FunctionNode> functions}) {
    return new ProgramNode(
        entryPoint: entryPoint ?? this.entryPoint,
        functions: functions ?? this.functions);
  }

  bool operator ==(other) {
    return other is _ProgramNode &&
        other.entryPoint == entryPoint &&
        const ListEquality<FunctionNode>(const DefaultEquality<FunctionNode>())
            .equals(other.functions, functions);
  }

  Map<String, dynamic> toJson() {
    return ProgramNodeSerializer.toMap(this);
  }
}
