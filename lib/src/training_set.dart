import 'package:tuple/tuple.dart';

class TrainingSet<X, Y> {
  final List<Tuple2<X, Y>> _data = [];

  TrainingSet();

  TrainingSet.fromIterable(Iterable<Tuple2<X, Y>> tuples) {
    _data.addAll(tuples ?? []);
  }

  TrainingSet.fromMap(Map<X, Y> map) {
    map.forEach((x, y) {
      _data.add(new Tuple2(x, y));
    });
  }

  void add(X x, Y y) {
    _data.add(new Tuple2(x, y));
  }

  void forEach(void f(int i, X x, Y y)) {
    for (int i = 0; i < _data.length; i++) {
      var t = _data[i];
      f(i, t.item1, t.item2);
    }
  }

  TrainingSet<X, U> map<U>(U f(X x, Y y)) {
    return new TrainingSet.fromIterable(
        _data.map((t) => new Tuple2<X, U>(t.item1, f(t.item1, t.item2))));
  }

  List<Tuple2<X, Y>> toList() => new List<Tuple2<X, Y>>.unmodifiable(_data);

  Map<X, Y> toMap() {
    return _data.fold<Map<X, Y>>({}, (out, t) {
      return out..[t.item1] = t.item2;
    });
  }
}
