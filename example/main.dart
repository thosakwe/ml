import 'package:ml/ml.dart';

void main() {
  var arr = new Series.from([1, 2, 3, 4]);
  var arr2 = arr + [2, 3];
  print(arr);
  print(arr2);
  print(arr2 * [2]);

  var frame = new DataFrame.from({
    'x': arr,
    'y': arr * [3],
    'avg': arr.average()..length = 3,
  }).uniform();

  print(frame);

  var roundedFrame = frame.transform((s) => s.map((x) => x.roundToDouble()));
  print(roundedFrame);

  var intFrame = roundedFrame.toInts();
  print(intFrame);

  print(intFrame.toDoubles().toList());
}
