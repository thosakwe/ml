import 'package:meta/meta.dart';

import 'dataframe.dart';
import 'perceptron.dart';
import 'training_config.dart';

abstract class NeuralNetwork {
  List<Layer> get hiddenLayers;
  Layer get inputLayer;
  Layer get outputLayer;

  NeuralNetwork._();

  List<Layer> get allLayers {
    var out = [inputLayer]..addAll(hiddenLayers);
    if (outputLayer != null) out.add(outputLayer);
    return out;
  }

  factory NeuralNetwork.feedForward(
      {@required Layer inputLayer,
      List<Layer> hiddenLayers,
      Layer outputLayer}) = _FeedForwardNetwork;

  void train(DataFrame<String, double> data, TrainingConfig config);

  void dumpWeights() {
    var b = new StringBuffer();
    var layers = allLayers;

    for (int i = 0; i < layers.length; i++) {
      b.writeln('Layer $i:');
      layers[i].dumpWeights(b);
    }

    print(b);
  }

  List<double> compute(Iterable<double> inputs) {
    var data = inputs;

    for (var layer in allLayers) {
      data = layer.compute(data);
    }

    return data;
  }
}

class _FeedForwardNetwork extends NeuralNetwork {
  final List<Layer> hiddenLayers;
  final Layer inputLayer, outputLayer;

  _FeedForwardNetwork(
      {@required this.inputLayer,
      this.hiddenLayers: const [],
      this.outputLayer})
      : super._();

  @override
  void train(DataFrame<String, double> data, TrainingConfig config) {
    var inputs = data; //.take(inputLayer.perceptrons.length);
    var outputs = data.toList().last;
    var batchSize = (config.batchSize ?? inputs.maxLength);
    int currentStep = 0;

    for (var layer in allLayers) {
      layer.init(config);
    }

    for (int epoch = 0; epoch < config.epochs; epoch++) {
      //for (int i = 0; i < inputs.maxLength; i++) {
      //var index = i;
      for (int i = 0; i < batchSize; i++) {
        var index = (batchSize * currentStep) + i;
        var data = inputs.values.map((s) => s[index]).toList(growable: false);
        var expected = outputs[i];

        for (var layer in allLayers) {
          data = layer.train(data, expected, config);
        }
      }
    }
  }
}
