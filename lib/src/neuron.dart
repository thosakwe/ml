library ml.src.neuron;

import 'dart:math';
import 'functions.dart';

abstract class Neuron {
  static Random _random;

  static Random get random => _random ??= new Random();

  static void seed(int n) {
    _random = new Random(n);
  }

  double compute(double input);

  void train(double input, double targetValue, int iterations);
}

class SimpleNeuron extends Neuron {
  final double Function(double) activate;
  double _factor = Neuron.random.nextDouble();

  SimpleNeuron({this.activate: sigmoid});

  @override
  double compute(double input) => activate(input) * _factor;

  @override
  void train(double input, double targetValue, int iterations) {
    for (int i = 0; i < iterations; i++) {
      var computed = compute(input);
      var loss = targetValue / computed;
      if (loss == 1.0) return;
      _factor *= loss;
    }
  }
}
