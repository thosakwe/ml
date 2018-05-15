import 'dataframe.dart';
import 'perceptron.dart';
import 'training_config.dart';

abstract class NeuralNetwork {
  final TrainingConfig _trainingConfig;
  final List<Layer> _hiddenLayers = [];
  Layer _inputLayer, _outputLayer;

  factory NeuralNetwork.feedForward(TrainingConfig trainingConfig) =
      _FeedForwardNetwork;

  NeuralNetwork._(this._trainingConfig) {
    int nInputs = _trainingConfig.nInputs;
    _inputLayer = new Layer(nInputs, _trainingConfig.nInputs, _trainingConfig);

    for (var hidden in _trainingConfig.hiddenLayers ?? []) {
      _hiddenLayers.add(new Layer(nInputs, hidden, _trainingConfig));
      nInputs = hidden;
    }

    _outputLayer =
        new Layer(nInputs, _trainingConfig.nOutputs, _trainingConfig);
  }

  void train(DataFrame<String, double> data);
}

class _FeedForwardNetwork extends NeuralNetwork {
  _FeedForwardNetwork(TrainingConfig trainingConfig) : super._(trainingConfig);

  @override
  void train(DataFrame<String, double> data) {
    var config = _trainingConfig;
    var inputs = data.select(config.inputs);
    var outputs = data[config.output];
    var batchSize = (config.batchSize ?? inputs.maxLength);
    int currentStep = 0;

    for (int epoch = 0; epoch < config.epochs; epoch++) {
      for (int i = 0; i < batchSize; i++) {
        var index = (batchSize * currentStep) + i;
        var data = inputs.values.map((s) => s[index]).toList(growable: false);
        var expected = outputs[i];
      }
    }
  }
}
