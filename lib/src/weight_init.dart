import 'dart:math';

typedef double WeightInitializer();

abstract class WeightInitializers {
  static final Random _rnd = new Random();

  static double random([int seed]) =>
      (seed == null ? _rnd : new Random(seed)).nextDouble();
}
