import 'dart:math';
import 'package:collection/collection.dart';

T _add<T extends num>(T a, T b) => a + b;
T _sub<T extends num>(T a, T b) => a - b;
double _div<T extends num>(T a, T b) => a / b;
T _mod<T extends num>(T a, T b) => a % b;
T _mul<T extends num>(T a, T b) => a * b;
T _pow<T extends num>(T a, T b) => pow(a, b);

class Series<E extends num> extends DelegatingList<E> {
  Series() : super([]);
  Series.from(Iterable<E> list) : super(list.toList());

  Series<double> average() {
    var sum = fold<double>(0.0, (sum, x) => sum + x);
    return new Series.from([sum / length]);
  }

  Series<E> operator %(Iterable<E> other) => combine(other, _mod);

  Series<E> operator *(Iterable<E> other) => combine(other, _mul);

  Series<double> operator /(Iterable<E> other) => combineBinary(other, _div);

  Series<E> operator -(Iterable<E> other) => combine(other, _sub);

  Series<E> pow(Iterable<E> other) => combine(other, _pow);

  Series<E> operator +(Iterable<E> other) {
    if (other is Series<E>) {
      return combine(other, _add);
    } else {
      return this + new Series<E>.from(other);
    }
  }

  Series<T> mapToArray<T extends num>(T Function(E) f) {
    return new Series<T>.from(map<T>(f));
  }

  Series<E> combine(Iterable<E> other, E Function(E, E) f) =>
      combineBinary<E>(other, f);

  Series<T> combineBinary<T extends num>(
      Iterable<E> other, T Function(E, E) f) {
    if (other is Series<T>) {
      var list = new List<T>(max(length, other.length));

      for (int i = 0; i < list.length; i++) {
        if (i < length && i < other.length) {
          list[i] = f(this[i], other.elementAt(i));
        } else if (i < length) {
          list[i] = f(this[i], other.last);
        } else if (i < other.length) {
          list[i] = f(last, other.elementAt(i));
        }
      }

      return new Series<T>.from(list);
    }

    return combineBinary(new Series<E>.from(other), f);
  }

  @override
  void set length(int length) {
    if (length > this.length) {
      while (this.length < length) add(last);
    } else
      super.length = length;
  }

  @override
  bool operator ==(other) {
    return other is Series && const ListEquality().equals(this, other);
  }
}
