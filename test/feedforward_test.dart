import 'package:ml/ml.dart';
import 'package:test/test.dart';

void main() {
  var net = new FeedForwardNeuralNetwork(
    input: new Layer.dense(inputs: 5, outputs: 2),
    output: null,
  );
}
