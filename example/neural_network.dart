import 'dart:io';
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
    inputLayer: new Layer(
      nInputs: 3,
      nOutputs: 2,
    ),
    hiddenLayers: [
      new Layer(
        nInputs: 2,
        nOutputs: 7,
      ),
      new Layer(
        nInputs: 7,
        nOutputs: 1,
      ),
      new Layer(
        nInputs: 1,
        nOutputs: 2,
      ),
    ],
    outputLayer: new Layer(
      nInputs: 2,
      nOutputs: 1,
    ),
  );

  nn.train(
    data,
    new TrainingConfig(
      learningRate: 0.03,
      epochs: 1000,
      seed: 23,
      activate: (x) => x > 0.5 ? 1.0 : 0.0,
    ),
  );

  //nn.dumpWeights();

  while (true) {
    print('Describe the Dart app in question:\n');
    var runsServer = promptBool('Runs on server?'),
        runsWeb = promptBool('Runs on Web?'),
        runsFlutter = promptBool('Runs on Flutter?');
    var data = [runsServer, runsWeb, runsFlutter].map(fromBool);
    var r = nn.compute(data);
    print(r);
    var result = toBool(r[0]);

    if (result) {
      print('This is an Angular app.');
    } else {
      print('This is not an Angular app.');
    }
  }
}

bool promptBool(String msg) {
  while (true) {
    stdout.write('$msg [y/N]: ');
    var line = stdin.readLineSync().trim().toLowerCase();
    if (line.startsWith('y'))
      return true;
    else if (line.startsWith('n') || line.isEmpty) return false;
  }
}
