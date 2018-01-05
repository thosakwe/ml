library ml.src.layer;

import 'functions.dart';
import 'gradient.dart';
import 'neuron.dart';

class Layer {
  final List<Neuron> neurons;
  final List<double> _weights;

  Layer(this.neurons)
      : _weights = new List.generate(
            neurons.length, (_) => Neuron.random.nextDouble());

  factory Layer.size(int size, {double activate(double input)}) {
    return new Layer(new List<Neuron>.generate(
        size, (_) => new SimpleNeuron(activate: activate ?? sigmoid)));
  }

  List<double> compute(List<double> inputs) {
    List<double> out = new List(neurons.length);

    for (int i = 0; i < _weights.length; i++) {
      out[i] = _weights[i] * neurons[i].compute(inputs[i]);
    }

    return out;
  }

  void train(
    List<double> inputs,
    List<double> expected,
    int iterations, {
    Gradient gradient: sigmoidCurveGradient,
  }) {
    for (int it = 0; it < iterations; it++) {
      for (int i = 0; i < _weights.length; i++) {
        var input = inputs[i];
        var computed = _weights[i] * neurons[i].compute(input);
        var expectation = expected[i];
        var adjustment = gradient.apply(input, computed, expectation);
        //print('$input, $computed, $expectation => $adjustment');
        //print('${_weights[i]} += $adjustment');
        _weights[i] += adjustment;
      }
    }
  }

  void trainAll(
    List<List<double>> inputs,
    List<List<double>> expected,
    int iterations, {
    Gradient gradient: sigmoidCurveGradient,
  }) {
    for (int i = 0; i < inputs.length; i++) {
      train(inputs[i], expected[i], iterations, gradient: gradient);
    }
  }

  String dump() {
    var b = new StringBuffer();
    b..writeln('Layer (${neurons.length})')..writeln('  * Weights: $_weights');
    return b.toString();
  }
}
