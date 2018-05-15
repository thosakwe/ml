import 'package:meta/meta.dart';
import 'training_config.dart';

class Layer {
  final List<Perceptron> perceptrons;

  Layer(
      {@required int nInputs,
      @required int nOutputs,
      double Function(double) activate: heaviside})
      : perceptrons = new List.generate(
            nOutputs, (_) => new Perceptron(nInputs, activate));

  void init(TrainingConfig trainingConfig) {
    perceptrons.forEach((p) => p.init(trainingConfig));
  }

  void dumpWeights(StringBuffer b) {
    for (int i = 0; i < perceptrons.length; i++) {
      b.writeln('  $i: ${perceptrons[i]._weights}');
    }
  }

  List<double> train(
      Iterable<double> inputs, double expected, TrainingConfig trainingConfig) {
    var out = <double>[];

    for (var p in perceptrons) {
      out.add(p.adjustWeights(inputs, expected, trainingConfig));
    }

    return out;
  }

  List<double> compute(Iterable<double> inputs) {
    var out = <double>[];

    for (var p in perceptrons) {
      out.add(p.compute(inputs));
    }

    return out;
  }
}

class Perceptron {
  final int nInputs;
  final double Function(double) activate;
  bool _initialized = false;
  double _bias;
  List<double> _weights;

  Perceptron(this.nInputs, this.activate);

  void init(TrainingConfig trainingConfig) {
    if (!_initialized) {
      _initialized = true;
      _bias = trainingConfig.random.nextDouble();
      _weights = new List<double>.generate(
          nInputs, (_) => trainingConfig.random.nextDouble());
    }
  }

  double weightedSum(Iterable<double> inputs) {
    var sum = _bias;

    for (int j = 0; j < _weights.length; j++) {
      sum += _weights[j] * inputs.elementAt(j);
    }

    return sum;
  }

  double compute(Iterable<double> inputs) {
    return weightedSum(inputs);
    //return activate(weightedSum(inputs));
  }

  double adjustWeights(
      Iterable<double> inputs, double expected, TrainingConfig trainingConfig) {
    var actual = activate(weightedSum(inputs));
    var err = expected - actual;
    if (err == 0) return expected;

    for (int i = 0; i < _weights.length; i++) {
      _weights[i] += (err * trainingConfig.learningRate * inputs.elementAt(i));
    }

    return expected;
  }
}
