import 'dart:math';

double sigmoid(double x) => 1.0 / (1.0 + exp(-x));

double sigmoidGradient(double x) => sigmoid(x) * (1 - sigmoid(x));

double heaviside(double x) => x < 0 ? 0.0 : 1.0;

class TrainingConfig {
  static final Random _globalRandom = new Random();
  Random _rnd;
  final int batchSize, epochs, seed;
  final int nInputs, nOutputs;
  final List<int> hiddenLayers;
  final double learningRate;
  final List<String> inputs, outputs;
  final String output;
  final double Function(double) gradient, activate;

  TrainingConfig(
      {Iterable<String> inputs,
      Iterable<String> outputs,
      this.output,
      this.epochs: 1,
      num learningRate: 1,
      this.seed,
      this.batchSize,
      this.nInputs,
      this.nOutputs,
      this.hiddenLayers: const [],
      this.gradient: sigmoidGradient,
      this.activate: sigmoid})
      : this.learningRate = learningRate?.toDouble(),
        this.inputs = inputs?.toList(growable: false),
        this.outputs = outputs?.toList(growable: false);

  Random get random =>
      _rnd ??= (seed != null ? new Random(seed) : _globalRandom);
}
