import 'dart:math';

import 'package:ml/ml.dart';

void main() {
  // z = 3x + 2y
  var trainingData = [
    [
      [1.0, 2.0, 7.0],
      [2.0, 4.0, 14.0],
      [3.0, 8.0, 25.0],
    ],
  ];

  var regressor = new LinearRegressor(nInputs: 2);

  regressor.train(
    trainingData: trainingData,
    epochs: 100000,
    learningRate: 0.3,
    threshold: 0.0,
  );

  print('WEIGHTS:');
  print('* x: ${regressor.weights[0]} (should be 3)');
  print('* y: ${regressor.weights[1]} (should be 2)');

  for (double x = 4.0; x < 100.0; x++) {
    var y = pow(2, x);
    var computed = regressor.compute([x, y]).toStringAsFixed(1);
    var z = (x * 3.0) + (y * 2.0);
    print('x:  $x, y: $y, z: $z, predicted z: $computed');
  }
}
