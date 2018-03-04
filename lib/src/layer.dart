import 'package:meta/meta.dart';
import 'neuron.dart';

class Layer {
  final List<Neuron> _inputs;
  final List<Neuron> _outputs;

  Layer._(this._inputs, this._outputs);

  factory Layer.dense({@required int inputs, @required int outputs}) {
    return new Layer._(
      new List.generate(inputs, (_) => new Neuron()),
      new List.generate(outputs, (_) => new Neuron()),
    );
  }
}
