# ml
An attempt to produce a handy machine learning toolkit in Dart.
This repository has seen many changes over months, so don't
expect stability for a long time.

## `LinearRegressor
Use a `LinearRegressor` to fit data into a linear equation.
This implementation uses a simple gradient descent to minimize
losses and find ideal weights for each variable. These datasets
can be multivariable, and infinite in length, only
bounded by the power of your computed.

```dart
void main() {
  var trainingData = [
      [
        [5.0, 2.0, 3.0],
        [10.0, 4.0, 6.0],
        [15.0, 8.0, 9.0],
      ],
    ];
  
    var regressor = new LinearRegressor(nInputs: 2);
  
    regressor.train(
      trainingData: trainingData,
      epochs: 100000,
      learningRate: 0.001,
      threshold: 0.0,
    );
    
    var prediction = regressor.predict([20.0, ]);
}
```