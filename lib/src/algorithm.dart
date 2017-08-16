import 'hypothesis.dart';
import 'training_set.dart';

abstract class SupervisedLearningAlgorithm<X, Y> {
  const SupervisedLearningAlgorithm();

  Hypothesis<X, Y> learn(TrainingSet<X, Y> trainingSet);
}
