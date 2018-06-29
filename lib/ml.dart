export 'src/dataframe.dart';
export 'src/neural_network.dart';
export 'src/linear_classifier.dart';
export 'src/linear_regression.dart';
export 'src/perceptron.dart';
export 'src/series.dart';
export 'src/training_config.dart';

bool toBool(double n) {
  return n > 0.5 ? true : false;
}

double fromBool(bool b) => b ? 1.0 : 0.0;
