import 'package:ml/ml.dart';
import 'package:test/test.dart';

void main() {
  var net = new FeedForwardNeuralNetwork(
    input: new Layer.dense(inputs: 1, outputs: 1),
    output: new Layer.dense(inputs: 1, outputs: 1),
  );

  var trainingInputs = new NDArray.fromDoubles([2.0], 1, 1);
  var trainingOutputs = new NDArray.fromDoubles([3.0], 1, 1);

  net.fit(trainingInputs, trainingOutputs);

  test('run', () {
    var value = net.compute(new NDArray.fromDoubles([4.0], 1, 1));
    print(value.data);
  });
}
