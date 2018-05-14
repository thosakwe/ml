import 'package:ml/ml.dart';

void main() {
  var data = new DataFrame.from({
    'x': [1.0, 3.0, 7.0],
    'b': [1.0, 1.0, 1.0],
    'y': [2.0, 6.0, 14.0],
  });

  print(data);

  var regression = new LinearRegression();
  regression.train(
    data,
    new TrainingConfig(
      inputs: ['x', 'b'],
      output: 'y',
      epochs: 100,
      learningRate: 0.1,
    ),
  );

  print(regression.weights);

  print(regression.compute([36.0]));
}
