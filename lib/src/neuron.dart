import 'dart:typed_data';
import 'activation.dart';
import 'array.dart';
import 'weight_init.dart';

class Neuron {
  final int length;
  final ActivationFunction activation;
  final Float64List _weights;

  Neuron(this.length, this.activation, WeightInitializer init)
      : _weights = new Float64List(length) {
    for (int i = 0; i < length; i++) _weights[i] = init();
  }

  double compute(List<double> inputs) {
    // Weighted product of inputs * weights
    double product = 0.0;

    for (int i = 0; i < length; i++) {
      product += inputs[i] * _weights[i];
    }

    return activation(product);
  }
}
