import 'dart:math';
import 'dart:typed_data';
import 'package:meta/meta.dart';
import 'activation.dart';
import 'array.dart';
import 'neuron.dart';
import 'weight_init.dart';

class Layer {
  final _LayerType _type;
  final int _inputs;
  final List<Neuron> _outputs;

  Layer._(this._type, WeightInitializer init, this._inputs, this._outputs);

  factory Layer.dense(
      {@required int inputs,
      @required int outputs,
      ActivationFunction activation: sin,
      WeightInitializer weightInitializer: WeightInitializers.random}) {
    return new Layer._(
      _LayerType.dense,
      weightInitializer,
      inputs,
      new List.generate(
          outputs, (_) => new Neuron(inputs, activation, weightInitializer)),
    );
  }

  NDArray compute(NDArray inputs) {
    var arr = new NDArray.zero(_outputs.length, inputs.rowCount);

    for (int i = 0; i < inputs.length; i++) {
      var outStride = arr[i];

      for (int j = 0; j < _inputs; j++) {
        outStride[j] = _outputs[j].compute(inputs[i]);
      }
    }

    return arr;
  }

  NDArray errorDelta(NDArray error) {
    var errorDeltas = <NDArray>[];

    for (int i = 0; i < _inputs; i++) {
      // The error delta should be equal to the input delta
      // times the weight
      var errorDelta = error *
          new NDArray.filled(_outputs.length, error.rowCount, _weights[i]);
      errorDeltas.add(errorDelta);
    }

    return errorDeltas.reduce((a, b) => a + b);
  }
}

enum _LayerType { dense }
