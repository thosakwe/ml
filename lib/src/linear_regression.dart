import 'dataframe.dart';
import 'training_config.dart';

/// A mechanism for performing linear regressions.
class LinearRegression {
  final Map<String, double> weights = {};

  double compute(Iterable<double> inputs) {
    var sum = 0.0;

    for (int j = 0; j < inputs.length; j++) {
      var key = weights.keys.elementAt(j);
      sum += weights[key] * inputs.elementAt(j);
    }

    return sum;
  }

  void train(DataFrame<String, double> data, TrainingConfig config) {
    var inputs = data.select(config.inputs);
    var outputs = data[config.output];
    var batchSize = (config.batchSize ?? inputs.maxLength);
    var steps = (data.maxLength / batchSize).round();
    int currentStep = 0;

    for (var key in config.inputs) weights[key] ??= config.random.nextDouble();

    for (int epoch = 0; epoch < config.epochs; epoch++) {
      for (int i = 0; i < batchSize; i++) {
        var index = (batchSize * currentStep) + i;
        var data = inputs.values.map((s) => s[i]).toList(growable: false);
        var expected = outputs[i];

        // Compute a value
        var sum = 0.0;

        for (int j = 0; j < data.length; j++) {
          sum += weights[config.inputs[j]] * data[j];
        }

        //var delta = config.gradient(sum - expected);
        var delta = sum - expected;
        var alpha = config.learningRate;

        for (int j = 0; j < data.length; j++) {
          var key = config.inputs[j];
          var w = weights[key];
          weights[key] = w - (alpha * delta * data[j]);
        }
      }
    }
  }
}
