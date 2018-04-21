import 'dart:math';

typedef double LossFunction(List<double> computed, List<double> expected);

double meanSquaredError(List<double> computed, List<double> expected) {
  var errors = new List<double>(computed.length);

  for (int i = 0; i < computed.length; i++) {
    errors[i] = pow(expected[i] - computed[i], 2);
  }

  // Find mean squared error
  return (errors.reduce((a, b) => a + b) / errors.length) / 2;
}
