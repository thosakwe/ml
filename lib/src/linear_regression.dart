import 'package:tuple/tuple.dart';
import 'algorithm.dart';
import 'hypothesis.dart';
import 'training_set.dart';

class LinearRegression extends SupervisedLearningAlgorithm<num, num> {
  const LinearRegression();

  @override
  Hypothesis<num, num> learn(TrainingSet<num, num> trainingSet) {
    var list = new List<Tuple2<num, num>>.from(trainingSet.toList());
    list.sort((a, b) => a.item1.compareTo(b.item1));

    num sumOfSlopes = 0;

    Tuple2<num, num> last;

    for (var t in list) {
      if (last != null) {
        var slope = (t.item2 - last.item2) / (t.item1 - last.item1);
        sumOfSlopes += slope;
      }

      last = t;
    }

    num averageSlope = sumOfSlopes / (list.length - 1);

    // y = mx + b
    // We have y, m, x
    // Need b
    //
    // b = y - mx
    var m0 = list.first;
    var x0 = m0.item1;
    var y0 = m0.item2;
    var yIntercept = y0 - (averageSlope * x0);

    return new Hypothesis((num x) => (averageSlope * x) + yIntercept);
  }
}
