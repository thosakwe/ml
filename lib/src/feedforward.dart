import 'package:meta/meta.dart';
import 'array.dart';
import 'layer.dart';

class FeedForwardNeuralNetwork {
  final Layer input;
  final Iterable<Layer> hidden;
  final Layer output;

  FeedForwardNeuralNetwork(
      {@required this.input, this.hidden: const [], @required this.output});

  List<Layer> get allLayers {
    return <Layer>[]
      ..add(input)
      ..addAll(hidden ?? [])
      ..add(output);
  }

  NDArray compute(NDArray inputs) {
    return allLayers.fold<NDArray>(inputs, (currentInputs, layer) {
      return layer.compute(currentInputs);
    });
  }

  void fit(NDArray inputs, NDArray outputs, [int nTimes = 1]) {
    var layers = allLayers;
    var reversed = layers.reversed;

    for (int i = 0; i < nTimes; i++) {
      var computed = compute(inputs);
      var error = outputs - computed;

      // Backprop this through each layer.
      //
      // Each layer will return an Iterable of error arrays,
      // which are then propagated as well.
      for (var layer in reversed) {
        error = layer.errorDelta(error);
      }
    }

    /*
    for (int i = 0; i < nTimes; i++) {
      layers.fold<NDArray>(inputs, (currentInputs, layer) {
        var computed = layer.compute(currentInputs);
        var error = outputs - computed;
        //print('result: ${computed.data}, expected: ${outputs.data}, err: ${error.data}');
        layer.fit(error);
        return computed;
      });
    }
    */
  }
}
