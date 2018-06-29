import 'package:ml/ml.dart';

enum Genre { rap, disco, waltz, edm }

const String bpm = 'bpm',
    isEdm = 'is_edm',
    isDisco = 'is_disco',
    isRap = 'is_rap',
    isWaltz = 'is_waltz',
    numInstruments = 'instruments',
    lengthInSeconds = 'length',
    year = 'year';

void main() {
  var regression = new LinearRegression();
  var classifier = new LinearClassifier(regression, Genre.values);
  var data = new DataFrame.from({
    bpm: [180, 120, 150, 110],
    numInstruments: [1, 6, 2, 20],
    lengthInSeconds: [240, 194.0, 300.0, 734.12],
    year: [2018, 1976, 1994, 1603],
    isEdm: [1.0, 0.0, 0.0, 0.0],
    isDisco: [0.0, 1.0, 0.0, 0.0],
    isRap: [0.0, 0.0, 1.0, 0.0],
    isWaltz: [0.0, 0.0, 0.0, 1.0],
    /*isEdm: [
      Genre.edm,
      Genre.disco,
      Genre.rap,Genre.waltz
    ],*/
  }).toDoubles();
  print(data);

  regression.train(
    data,
    new TrainingConfig(
      inputs: [bpm, numInstruments, lengthInSeconds, year],
      output: isEdm,
      epochs: 1000,
      learningRate: 0.03,
    ),
  );

  var offTheWall = [
    120.0,
    5.0,
    200.0,
    1979.0,
  ];
  print(regression.weights);
  print(regression.compute(offTheWall));
  //print(classifier.classify(offTheWall));
}
