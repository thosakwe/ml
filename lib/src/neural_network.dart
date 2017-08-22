import 'dart:math' as math;
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';

double sigmoid(double x) => 1 / (1 + math.pow(math.E, -1 * x));

double sigmoidGradient(double x) => x * (1 - x);

class NeuralNetwork {
  final Iterable<Neuron> entry;
  final Iterable<Iterable<Neuron>> hidden;
  final Neuron output;

  NeuralNetwork({
    @required this.entry: const [],
    this.hidden: const [],
    @required this.output,
  });

  double calculate(Map<String, double> inputs) {
    Map<String, double> state = {};

    for (var neuron in entry) {
      state[neuron.name] = neuron.calculate(inputs);
    }

    if (hidden.isNotEmpty) {
      for (var layer in hidden) {
        var out = {};

        for (var neuron in layer) {
          out[neuron.name] = neuron.calculate(inputs);
        }

        state = out;
      }
    }

    return output.calculate(state);
  }
}

class Neuron {
  final String name;
  final Map<String, double> _weights;

  Neuron(this.name, Map<String, double> weights)
      : _weights = new Map<String, double>.from(weights);

  factory Neuron.randomWeights(
      String name, math.Random random, Iterable<String> names,
      {int minWeight, int maxWeight}) {
    minWeight ??= -1;
    maxWeight ??= 1;
    var diff = maxWeight - minWeight;

    double randomWeight() => (random.nextInt(diff) + minWeight).toDouble();
    var map = names.fold<Map<String, double>>({}, (out, k) {
      return out..[k] = randomWeight();
    });
    return new Neuron(name, map);
  }

  Map<String, double> get weights =>
      new Map<String, double>.unmodifiable(_weights);

  double calculate(Map<String, double> inputs) {
    double sum = 0.0;

    for (var key in _weights.keys) {
      if (!inputs.containsKey(key))
        throw new ArgumentError(
            'Input to neuron "$name" is missing required input "$key".');
      sum += inputs[key] * _weights[key];
    }

    return sigmoid(sum);
  }

  void propogate(double desiredOutput, double computedOutput,
      double learningRate, Map<String, double> inputs) {
    var error = desiredOutput - computedOutput;
    if (error < learningRate) return;

    var gradient = error * sigmoidGradient(computedOutput);

    for (var key in _weights.keys) {
      _weights[key] += gradient * inputs[key];
    }
  }
}

class Trainer {
  final int iterations;

  Trainer({this.iterations: 20000});

  void train(
    NeuralNetwork network,
    Iterable<Tuple2<Map<String, double>, double>> trainingSet,
  ) {
    for (int i = 0; i < iterations; i++) {
      // TODO: Back propogation for multiple layer

      for (var pair in trainingSet) {}
    }
  }

  void trainNeuron(
    Neuron neuron,
    double learningRate,
    Iterable<Tuple2<Map<String, double>, double>> trainingSet,
  ) {
    for (var pair in trainingSet) {
      var computed = neuron.calculate(pair.item1);
      neuron.propogate(pair.item2, computed, learningRate, pair.item1);
    }
  }
}
