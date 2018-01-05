import 'package:ml/ml.dart';
import 'package:test/test.dart';

void main() {
  // https://medium.com/technology-invention-and-more/how-to-build-a-simple-neural-network-in-9-lines-of-python-code-cc8f23647ca1
  test('simple', () {
    Neuron.seed(1);
    var layer = new Layer.size(1); // x -> [y]
    layer.trainAll(
      [
        [0.0, 0.0, 1.0],
        [1.0, 1.0, 1.0],
        [1.0, 0.0, 1.0],
        [0.0, 1.0, 1.0],
      ],
      [
        [0.0],
        [1.0],
        [1.0],
        [0.0],
      ],
      10000,
    );
    print(layer.compute([1.0, 1.0, 0.0])); // Very close to 1
  });
}
