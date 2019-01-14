abstract class Value<T> {
  // Expression compile();

  // TODO: more operators

  Value<T> operator *(Value<T> other) => Binary(this, other, '*');
  Value<T> operator /(Value<T> other) => Binary(this, other, '/');
  Value<T> operator %(Value<T> other) => Binary(this, other, '%');
  Value<T> operator +(Value<T> other) => Binary(this, other, '+');
  Value<T> operator -(Value<T> other) => Binary(this, other, '-');

  String toFullString() => toString();
}

class Func<T> extends Value<T> {
  final String name;
  final Iterable<String> parameters;
  final Value<T> returnValue;
  bool _isAnonymous = false;

  static int _anonymous = 0;

  Func(this.name, this.parameters, this.returnValue) {
    if (parameters.isEmpty) {
      throw StateError('Function "$name" cannot have 0 parameters.');
    }
  }

  factory Func.closure(Value<T> Function(FuncBuilder<T>) f) {
    var b = FuncBuilder<T>._();
    var v = f(b);

    if (v == null) {
      throw ArgumentError.notNull('closure return value');
    } else {
      return Func<T>('ml_anonymous${_anonymous++}', b._variables, v)
        .._isAnonymous = true;
    }
  }

  Value<T> call(Value<T> arg0,
      [Value<T> arg1,
      Value<T> arg2,
      Value<T> arg3,
      Value<T> arg4,
      Value<T> arg5,
      Value<T> arg6,
      Value<T> arg7,
      Value<T> arg8,
      Value<T> arg9]) {
    return Result<T>(
        this,
        [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9]
            .where((x) => x != null));
  }

  Value<T> invoke(Iterable<Value<T>> arguments) {
    return Result<T>(this, arguments);
  }

  @override
  String toFullString() {
    var b = StringBuffer(this);
    b.write(' => $returnValue');
    return b.toString();
  }

  @override
  String toString() {
    var params = parameters.join(', ');
    var b = StringBuffer('fn ');
    if (!_isAnonymous) b.write('$name ');
    b.write('($params)');
    return b.toString();
  }
}

class Result<T> extends Value<T> {
  final Func<T> callee;
  final Iterable<Value<T>> arguments;

  Result(this.callee, this.arguments) {
    if (arguments.length != callee.parameters.length) {
      throw ArgumentError.value(arguments, 'arguments',
          'must have length of ${callee.parameters.length}');
    }
  }

  @override
  String toString() {
    var c = callee._isAnonymous ? callee.toString() : callee.name;
    var args = arguments.join(', ');
    return '$c($args)';
  }
}

/// Helper class for building [Func]tions.
class FuncBuilder<T> {
  final Set<String> _variables = Set();

  FuncBuilder._();

  /// Returns a reference to a parameter, passed to this function.
  Value<T> operator [](String name) {
    _variables.add(name);
    return Variable<T>(name);
  }
}

class Variable<T> extends Value<T> {
  final String name;

  Variable(this.name);

  @override
  String toString() => name;
}

class Constant<T> extends Value<T> {
  final T value;

  Constant(this.value);

  @override
  String toString() => value.toString();
}

class Binary<T> extends Value<T> {
  final Value<T> left, right;
  final String op;

  Binary(this.left, this.right, this.op);

  @override
  String toString() => '$left $op $right';
}
