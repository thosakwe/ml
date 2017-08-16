import 'package:ml/ml.dart';
import 'package:test/test.dart';
import 'package:tuple/tuple.dart';

main() {
  test('slope = 1', () {
    var trainingSet = new TrainingSet<int, int>.fromIterable(
      new List.generate(100, (i) => new Tuple2(i, i)),
    );

    var regression = const LinearRegression();
    var h = regression.learn(trainingSet).map<int>((n) => n.toInt());

    expect(h(100), 100);
  });

  test('slope = 2', () {
    var trainingSet = new TrainingSet<int, int>.fromIterable(
      new List.generate(100, (i) => new Tuple2(i, i * 2)),
    );

    var regression = const LinearRegression();
    var h = regression.learn(trainingSet).map<int>((n) => n.toInt());

    expect(h(100), 200);
  });
}
