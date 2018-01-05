library ml.src.gradient;

const Gradient sigmoidCurveGradient = const _SigmoidCurveGradient();

abstract class Gradient {
  double apply(double input, double computed, double expected);
}

class _SigmoidCurveGradient implements Gradient {
  const _SigmoidCurveGradient();

  @override
  double apply(double input, double computed, double expected) {
    // err * input * f(output)
    // where f = output * (1 - output)
    var error = expected - computed;
    var f = computed * (1 - computed);
    return error * input * f;
  }
}