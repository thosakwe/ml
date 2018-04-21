import 'package:meta/meta.dart';
import 'loss_functions.dart';
import 'util.dart';

/// A mechanism that can fit the weights of inputs on a line, via gradient descent.
class LinearRegressor {
  final List<double> _weights;

  /// The function used to calculate the error of a computation.
  final LossFunction lossFunction;

  LinearRegressor({@required int nInputs, this.lossFunction: meanSquaredError})
      : _weights = new List<double>.generate(nInputs, (_) => rnd.nextDouble());

  /// The current weight vector.
  List<double> get weights => new List<double>.unmodifiable(_weights);

  ///
  double compute(List<double> inputs) {
    // a = mx + ny + oz + bias...
    var computed = 0.0;

    for (int j = 0; j < _weights.length; j++) {
      // Add the weight times the input datum
      computed += inputs[j] * _weights[j];
    }

    return computed;
  }

  List<double> __compute(List<List<double>> dataset, List<double> weights) {
    // Each dataset is a list of sets of numbers (could be ordered pairs, or more variables).
    //
    //

    // Keep track of the errors.
    var out = new List<double>(dataset.length);

    for (int j = 0; j < dataset.length; j++) {
      out[j] = compute(dataset[j]);
    }

    return out;
  }

  /// Trains the regressor against a series of training sets.
  void train(
      {@required List<List<List<double>>> trainingData,
      @required int epochs,
      @required double learningRate,
      @required double threshold}) {
    for (int i = 0; i < epochs; i++) {
      for (var dataset in trainingData) {
        // Expected output is always the last in each point
        var expected = dataset.map((i) => i.last).toList();

        // For each dataset, find the MSE.
        var computed = __compute(dataset, _weights);
        var mse = lossFunction(computed, expected);

        // For each weight, adjust it by a given amount and see what happens to the MSE.
        for (int i = 0; i < _weights.length; i++) {
          var currentWeight = _weights[i];
          _weights[i] *= (1 + learningRate);

          var computed = __compute(dataset, _weights);
          var newMse = lossFunction(computed, expected);

          if ((newMse - mse) > threshold) {
            _weights[i] = currentWeight * (1 - learningRate);
          }
        }
      }
    }
  }
}
