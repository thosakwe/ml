import 'linear_regression.dart';

class LinearClassifier<T> {
  final LinearRegression regression;
  final List<T> alternatives;

  LinearClassifier(this.regression, this.alternatives);

  double operator [](T t) {
    var increment = 1 / alternatives.length;
    return (increment * alternatives.indexOf(t)) + 0.001;
  }

  T classify(Iterable<double> inputs) {
    var score = regression.compute(inputs);
    double smallestDiff;
    int index;

    for (int i = 0; i < alternatives.length; i++) {
      var target = this[alternatives.elementAt(i)];
      var diff = (score - target).abs();

      if (smallestDiff == null || diff < smallestDiff) {
        smallestDiff = diff;
        index = i;
      }
    }

    return alternatives.elementAt(index);
  }
}
