# ml
An attempt to produce a handy machine learning toolkit in Dart.
This repository has seen many changes over months, so don't
expect stability for a long time.

## `LinearRegression`
Use a `LinearRegression` to fit data into a linear equation.
This implementation uses a simple gradient descent to minimize
losses and find ideal weights for each variable. These datasets
can be multivariable, and infinite in length, only
bounded by the power of your computed.

```dart
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

  print(regression.compute([36.0])); // Almost exactly 72.0
}
```