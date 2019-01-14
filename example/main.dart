import 'package:ml/ml.dart';

main() async {
  var two = Constant(3);
  var three = Constant(2);
  var line = argv[1].asInt * three + two;

  var runnable = await c.compile(line);

  for (var i = 0; i < 6; i++) {
    var result = await runnable.run(argv: [i]);
    print('Result: $result');
  }
}

// main() async {
//   var x = Variable<int>('x');
//   var two = Constant(3);
//   var three = Constant(3);
//   var line = (x * three) + two;
//   var runnable = await c.compile(line);

//   for (var i = 0; i < 6; i++) {
//     var result = await runnable.run(values: {'x': i});
//     print('Result: $result');
//   }
// }
