import 'package:c_builder/c_builder.dart';
import 'compiler.dart';
import 'shared.dart';

class Perceptron extends CompilesTo<CFunction> {
  static int _names = 0;
  final int numberOfInputs;
  final String name;
  final List<double> _weights;

  Perceptron(this.numberOfInputs, {String name})
      : this.name = name ?? 'ml_perceptron_${_names++}',
        _weights =
            new List<double>.generate(numberOfInputs, (_) => rnd.nextDouble());

  CFunction compile(CCompiler compiler) {
    var sig = new FunctionSignature(CType.double, name);
    var fn = new CFunction(sig);
    Expression out;

    for (int i = 0; i < numberOfInputs; i++) {
      var input = new Expression('i$i');
      var weight = new Expression('${name}_w$i');

      compiler.implementation.body.add(new Field(
          CType.double, weight.code, new Expression.value(_weights[i])));

      sig.parameters.add(new Parameter(CType.double, input.code));

      var product = input * weight;
      if (out == null)
        out = product;
      else
        out = out + product;
    }

    fn.body.add(out.asReturn());
    compiler.header.body.add(sig);
    compiler.implementation.body.add(fn);
    return fn;
  }
}
