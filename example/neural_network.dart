import 'dart:io';
import 'dart:math' as math;
import 'package:ml/ml.dart';
import 'package:tuple/tuple.dart';

main() {
  var rnd = new math.Random();
  var neuron = new Neuron.randomWeights(
    'creepy_crawlie',
    rnd,
    ['legs', 'exoskeleton'],
  );
  var trainer = new Trainer(iterations: 10000);
  trainer.trainNeuron(
    neuron,
    0.3,
    [
      new Tuple2({'legs': 1.0, 'exoskeleton': 0.0}, 0.0),
      new Tuple2({'legs': 2.0, 'exoskeleton': 0.0}, 0.0),
      new Tuple2({'legs': 4.0, 'exoskeleton': 0.0}, 0.0),
      new Tuple2({'legs': 4.0, 'exoskeleton': 1.0}, 0.0),
      new Tuple2({'legs': 6.0, 'exoskeleton': 1.0}, 1.0),
      new Tuple2({'legs': 8.0, 'exoskeleton': 1.0}, 1.0),
      new Tuple2({'legs': 100.0, 'exoskeleton': 1.0}, 1.0),
    ],
  );
  print(neuron.weights);

  while (true) {
    stdout.write('Enter a number: ');
    var n = int.parse(stdin.readLineSync()).toDouble();
    var guess = neuron.calculate({'legs': n, 'exoskeleton': 1.0});
    bool isCreepy = guess > 0.5;

    if (isCreepy) {
      print('Ew! $n leg(s)? So creepy!');
    } else {
      print('$n leg(s) is pretty normal.');
    }
  }
}
