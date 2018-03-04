import 'package:meta/meta.dart';
import 'layer.dart';

class FeedForwardNeuralNetwork {
  final Layer input;
  final Iterable<Layer> hidden;
  final Layer output;

  FeedForwardNeuralNetwork(
      {@required this.input, this.hidden: const [], @required this.output});
}
