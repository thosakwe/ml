import 'package:collection/collection.dart';
import 'series.dart';

class DataFrame<K, V extends num> extends DelegatingMap<K, Series<V>> {
  DataFrame() : super({});
  DataFrame.fromArrays(Map<K, Series<V>> map) : super(map);

  static DataFrame<K, double> fromBooleans<K>(Map<K, Iterable<bool>> map) {
    var out = <K, Series<double>>{};

    for (var key in map.keys) {
      var value = map[key];
      out[key] = new Series<double>.from(value.map((b) => b ? 1.0 : 0.0));
    }

    return new DataFrame.fromArrays(out);
  }

  factory DataFrame.from(Map<K, Iterable<V>> map) {
    var out = <K, Series<V>>{};

    for (var key in map.keys) {
      var value = map[key];
      out[key] = value is Series<V> ? value : new Series<V>.from(value);
    }

    return new DataFrame.fromArrays(out);
  }

  factory DataFrame.fromIterable(
      Iterable<K> keys, Iterable<Iterable<V>> values) {
    var out = <K, Series<V>>{};

    for (int i = 0; i < keys.length; i++) {
      var key = keys.elementAt(i);
      var arr = values.elementAt(i);
      out[key] = arr is Series<V> ? arr : new Series<V>.from(arr);
    }

    return new DataFrame.fromArrays(out);
  }

  List<K> get keys => new List<K>.from(super.keys, growable: false);

  int get maxLength =>
      values.map((a) => a.length).reduce((a, b) => a > b ? a : b);

  DataFrame<K, V> convertIterable(Iterable<Iterable<V>> values) {
    return new DataFrame<K, V>.fromIterable(keys, values);
  }

  DataFrame<K, V> uniform() {
    var out = <K, Series<V>>{};
    var m = maxLength;

    for (var key in keys) {
      var value = new Series.from(this[key]);
      out[key] = value..length = m;
    }

    return new DataFrame.fromArrays(out);
  }

  DataFrame<K, V> select(Iterable<K> keys) {
    var out = <K, Series<V>>{};

    for (var key in keys) {
      out[key] = new Series.from(this[key]);
    }

    return new DataFrame.fromArrays(out);
  }

  DataFrame<K, V> skip(int n) => transform((s) => s.skip(n));

  DataFrame<K, V> take(int n) => transform((s) => s.take(n));

  DataFrame<K, double> toDoubles() => transform((s) => s.toDoubles());

  DataFrame<K, int> toInts() => transform((s) => s.toInts());

  DataFrame<K, T> transform<T extends num>(Iterable<T> Function(Series<V>) f) {
    var out = <K, Series<T>>{};

    for (var key in keys) {
      out[key] = new Series<T>.from(f(this[key]));
    }

    return new DataFrame.fromArrays(out);
  }

  List<Series<V>> toList({bool growable: true}) {
    return values.toList(growable: growable);
  }
}
