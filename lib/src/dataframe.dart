import 'package:collection/collection.dart';
import 'series.dart';

class DataFrame<K, V extends num> extends DelegatingMap<K, Series<V>> {
  DataFrame() : super({});
  DataFrame.fromArray(Map<K, Series<V>> map) : super(map);

  factory DataFrame.from(Map<K, Iterable<V>> map) {
    var out = <K, Series<V>>{};

    for (var key in map.keys) {
      var value = map[key];
      out[key] = value is Series<V> ? value : new Series<V>.from(value);
    }

    return new DataFrame.fromArray(out);
  }

  void resize() {
    var maxLength = values.map((a) => a.length).reduce((a, b) => a > b ? a : b);

    for (var arr in values) {
      arr.length = maxLength;
    }
  }
}
