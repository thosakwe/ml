import 'dart:math';

double sigmoid(double x) => 1.0 / (1.0 + exp(-x));

double sigmoidGradient(double x) => sigmoid(x) * (1 - sigmoid(x));

class TrainingConfig {
  static final Random _globalRandom = new Random();
  Random _rnd;
  final int batchSize, epochs, seed;
  final double learningRate;
  final List<String> inputs;
  final String output;
  final double Function(double) gradient;

  TrainingConfig(
      {Iterable<String> inputs,
      this.output,
      this.epochs: 1,
      num learningRate: 1,
      this.seed,
      this.batchSize,
      this.gradient: sigmoidGradient})
      : this.learningRate = learningRate.toDouble(),
        this.inputs = inputs.toList(growable: false);

  Random get random =>
      _rnd ??= (seed != null ? new Random(seed) : _globalRandom);
}
