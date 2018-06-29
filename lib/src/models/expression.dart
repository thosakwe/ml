import 'package:angel_serialize/angel_serialize.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

part 'expression.g.dart';

part 'expression.serializer.g.dart';

enum ExpressionNodeType {
  // Standalone
  ref,
  array,
  declaration,
  assignment,
  int,
  float,
  bool,

  // Composite
  unary,
  binary,
  call,
}

enum BinaryOperator {
  // bitwise
  xor,
  and,
  or,
  shiftLeft,
  shiftRight,

  // pemdas
  pow,
  multiply,
  divide,
  modulo,
  add,
  subtract,

  // bool
  booleanXor,
  booleanAnd,
  booleanOr,
}

enum UnaryOperator {
  negate,
  booleanNegate,
  increment,
  decrement,
}

ExpressionNode integer(int n, int size) =>
    new ExpressionNode(type: ExpressionNodeType.int, length: size, intValue: n);

ExpressionNode float(double n, int size) =>
    new ExpressionNode(type: ExpressionNodeType.float, length: size, floatValue: n);

@Serializable(autoIdAndDateFields: false)
abstract class _ExpressionNode {
  @required
  ExpressionNodeType get type;

  ExpressionNodeType get typeArgument;

  UnaryOperator get unaryOperator;

  BinaryOperator get binaryOperator;

  String get name;

  int get length;

  int get intValue;

  double get floatValue;

  _ExpressionNode get left;

  _ExpressionNode get right;

  _ExpressionNode get initializer;

  _ExpressionNode get callee;

  List<_ExpressionNode> get arguments;

  Map<String, dynamic> toJson();

  // ignore: unused_element
  int get _fake => 2;

  ExpressionNode call(Iterable<ExpressionNode> arguments) {
    if (type != ExpressionNodeType.ref) {
      throw ArgumentError('Can only call a reference as a function.');
    }

    return new ExpressionNode(
        type: ExpressionNodeType.call,
        callee: this,
        arguments: arguments.toList());
  }

  ExpressionNode operator ~() => _unary(UnaryOperator.negate);

  ExpressionNode booleanNegate() {
    if (type == ExpressionNodeType.array &&
        typeArgument != ExpressionNodeType.bool) {
      throw ArgumentError('Can only negate a boolean array.');
    } else if (type != ExpressionNodeType.bool) {
      throw ArgumentError('Can only negate a boolean.');
    }

    return new ExpressionNode(
        type: ExpressionNodeType.unary,
        unaryOperator: UnaryOperator.negate,
        length: length,
        arguments: [this]);
  }

  ExpressionNode increment() => _unary(UnaryOperator.increment, true);

  ExpressionNode decrement() => _unary(UnaryOperator.decrement, true);

  ExpressionNode operator *(ExpressionNode right) =>
      _binary(BinaryOperator.multiply, right);

  ExpressionNode operator /(ExpressionNode right) =>
      _binary(BinaryOperator.multiply, right);

  ExpressionNode operator %(ExpressionNode right) =>
      _binary(BinaryOperator.multiply, right);

  ExpressionNode operator +(ExpressionNode right) =>
      _binary(BinaryOperator.multiply, right);

  ExpressionNode operator -(ExpressionNode right) =>
      _binary(BinaryOperator.multiply, right);

  ExpressionNode operator &(ExpressionNode right) =>
      _binary(BinaryOperator.and, right);

  ExpressionNode operator |(ExpressionNode right) =>
      _binary(BinaryOperator.or, right);

  ExpressionNode operator ^(ExpressionNode right) =>
      _binary(BinaryOperator.xor, right);

  ExpressionNode operator <<(ExpressionNode right) =>
      _shift(BinaryOperator.shiftLeft, right);

  ExpressionNode operator >>(ExpressionNode right) =>
      _shift(BinaryOperator.shiftRight, right);

  ExpressionNode pow(ExpressionNode right) =>
      _binary(BinaryOperator.pow, right);

  ExpressionNode booleanXor(ExpressionNode right) =>
      _boolean(BinaryOperator.booleanXor, right);

  ExpressionNode booleanOr(ExpressionNode right) =>
      _boolean(BinaryOperator.booleanOr, right);

  ExpressionNode booleanAnd(ExpressionNode right) =>
      _boolean(BinaryOperator.booleanAnd, right);

  ExpressionNode _unary(UnaryOperator operator, [bool allowFloat = false]) {
    var expected = allowFloat ? 'a number' : 'an integer';
    ;

    if (type == ExpressionNodeType.array &&
        (typeArgument != ExpressionNodeType.int &&
            (!allowFloat || typeArgument != ExpressionNodeType.float))) {
      throw ArgumentError('Can only apply this operator to $expected array.');
    } else if (type != ExpressionNodeType.int &&
        (!allowFloat || type != ExpressionNodeType.float)) {
      throw ArgumentError('Can only apply this operator $expected.');
    }

    return new ExpressionNode(
        type: ExpressionNodeType.unary,
        unaryOperator: operator,
        length: length,
        arguments: [this]);
  }

  ExpressionNode _binary(BinaryOperator operator, ExpressionNode right) {
    if (right.type != type) {
      throw ArgumentError('Type mismatch between $type and $right.');
    } else if (type == ExpressionNodeType.array) {
      if (right.typeArgument != typeArgument) {
        throw ArgumentError(
            'Type mismatch between array of $typeArgument and array of ${right
                .typeArgument}.');
      }
    }

    return new ExpressionNode(
        type: ExpressionNodeType.binary,
        binaryOperator: operator,
        left: this,
        right: right,
        length: length);
  }

  ExpressionNode _boolean(BinaryOperator operator, ExpressionNode right) {
    if (type == ExpressionNodeType.array) {
      if (typeArgument != ExpressionNodeType.bool) {
        throw ArgumentError(
            'This operator can only be applied to a boolean array.');
      }

      if (right.type == ExpressionNodeType.array &&
          right.typeArgument != bool) {
        throw ArgumentError('Right-hand-side is not a boolean array.');
      }

      if (right.type != ExpressionNodeType.array &&
          right.typeArgument != bool) {
        throw ArgumentError('Right-hand-side is not a boolean.');
      }
    } else {
      if (type != ExpressionNodeType.bool) {
        throw ArgumentError('This operator can only be applied to booleans.');
      }

      if (right.type != ExpressionNodeType.bool) {
        throw ArgumentError('Right-hand-side is not a boolean.');
      }
    }

    return new ExpressionNode(
        type: ExpressionNodeType.binary,
        binaryOperator: operator,
        left: this,
        right: right,
        length: length);
  }

  ExpressionNode _shift(BinaryOperator operator, ExpressionNode right) {
    if (type == ExpressionNodeType.array) {
      if (typeArgument != ExpressionNodeType.int &&
          typeArgument != ExpressionNodeType.float) {
        throw new ArgumentError('Cannot shift an array of type $type.');
      }

      if (right.type != ExpressionNodeType.array &&
          right.type != ExpressionNodeType.int) {
        throw new ArgumentError('Right-hand-side of shift must be an integer.');
      }

      if (right.type == ExpressionNodeType.array &&
          right.typeArgument != ExpressionNodeType.int) {
        throw new ArgumentError(
            'Right-hand-side of array shift must be an integer array.');
      }
    } else if (type != ExpressionNodeType.int &&
        type != ExpressionNodeType.float) {
      throw new ArgumentError('Cannot shift a value of type $type.');
    } else {
      return new ExpressionNode(
          type: ExpressionNodeType.binary, left: this, right: right);
    }

    return new ExpressionNode(
        type: ExpressionNodeType.binary,
        binaryOperator: operator,
        left: this,
        right: right,
        length: length);
  }
}
