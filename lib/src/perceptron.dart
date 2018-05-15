import 'training_config.dart';

class Layer {
  final List<Perceptron> perceptrons;

  Layer(int nInputs, int size, TrainingConfig trainingConfig)
      : perceptrons = new List.generate(
            size, (_) => new Perceptron(nInputs, trainingConfig));
}

class Perceptron {
  final TrainingConfig trainingConfig;
  final List<double> weights;
  final double bias;
  final double Function(double) activate;

  Perceptron(int nInputs, this.trainingConfig)
      : activate = trainingConfig.gradient,
        bias = trainingConfig.random.nextDouble(),
        weights = new List<double>.generate(
            nInputs, (_) => trainingConfig.random.nextDouble());

  double weightedSum(Iterable<double> inputs) {
    var sum = 0.0;

    for (int j = 0; j < inputs.length; j++) {
      sum += weights[j] * inputs.elementAt(j);
    }

    return sum;
  }

  double compute(Iterable<double> inputs) {
    return activate(weightedSum(inputs));
  }

  void adjustWeights(Iterable<double> inputs, double expected) {
    var actual = compute(inputs);
    var err = expected - actual;
    if (actual == expected) return;

    for (int i = 0; i < weights.length; i++) {
      weights[i] += (err * trainingConfig.learningRate * inputs.elementAt(i));
    }
  }
}
