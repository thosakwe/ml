import 'package:ml/ml.dart';

const String runsServer = 'runs_server',
    runsWeb = 'runs_web',
    runsFlutter = 'runs_flutter',
    isAngular = 'is_angular';

void main() {
  var data = DataFrame.fromBooleans({
    runsServer: [false, true, true, false, false],
    runsWeb: [true, true, false, false, true],
    runsFlutter: [false, true, true, false, true],
    isAngular: [true, false, false, false, true],
  });

  var nn = new NeuralNetwork.feedForward(
    new TrainingConfig(
      nInputs: 3,
      nOutputs: 1,
      learningRate: 0.03,
      epochs: 1000,
    ),
  );

  nn.train(data);
}
