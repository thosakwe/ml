import 'package:collection/collection.dart';
import 'series.dart';

class DataFrame<K, V extends num> extends DelegatingMap<K, Series<V>> {
  DataFrame() : super({});
  DataFrame.fromArrays(Map<K, Series<V>> map) : super(map);

  factory DataFrame.from(Map<K, Iterable<V>> map) {
    var out = <K, Series<V>>{};

    for (var key in map.keys) {
      var value = map[key];
      out[key] = value is Series<V> ? value : new Series<V>.from(value);
    }

    return new DataFrame.fromArrays(out);
  }

  void resize() {
    var maxLength = values.map((a) => a.length).reduce((a, b) => a > b ? a : b);

    for (var arr in values) {
      arr.length = maxLength;
    }
  }

  DataFrame<K, double> toDoubles() => transform((s) => s.toDoubles());

  DataFrame<K, int> toInts() => transform((s) => s.toInts());

  DataFrame<K, T> transform<T extends num>(Iterable<T> Function(Series<V>) f) {
    var out = <K, Series<T>>{};

    for (var key in keys) {
      out[key] = new Series<T>.from(f(this[key]));
    }

    return new DataFrame.fromArrays(out);
  }
}
