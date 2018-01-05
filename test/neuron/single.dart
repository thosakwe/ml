import 'dart:math';
import 'package:ml/ml.dart';
import 'package:test/test.dart';

void main() {
  test('single training', () {
    var neuron = new SimpleNeuron(activate: sigmoid);
    neuron.train(10.0, 2.0, 1000000);
    expect(neuron.compute(10.0), 2.0);
  });
}