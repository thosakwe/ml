import 'package:func/func.dart';

abstract class Hypothesis<X, Y> {
  factory Hypothesis(Func1<X, Y> f) = _FunctionHypothesis<X, Y>;
  Hypothesis._();

  Y call(X x);

  Hypothesis<X, U> map<U>(Func1<Y, U> f);
}

abstract class _MappedHypothesisMixin<X, Y> implements Hypothesis<X, Y> {
  @override
  Hypothesis<X, U> map<U>(Func1<Y, U> f) {
    return new _MappedHypothesis<X, Y, U>(this, f);
  }
}

class _MappedHypothesis<X, Y, Z> extends Hypothesis<X, Z>
    with _MappedHypothesisMixin<X, Z> {
  final Hypothesis<X, Y> base;
  final Func1<Y, Z> f;

  _MappedHypothesis(this.base, this.f) : super._();

  @override
  Z call(X x) {
    return f(base.call(x));
  }
}

class _FunctionHypothesis<X, Y> extends Hypothesis<X, Y>
    with _MappedHypothesisMixin<X, Y> {
  final Func1<X, Y> f;

  _FunctionHypothesis(this.f) : super._();

  @override
  Y call(X x) {
    return f(x);
  }
}
