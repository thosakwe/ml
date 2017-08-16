import 'dart:math' as math;
import 'package:ml/ml.dart';
import 'package:tuple/tuple.dart';

main() {
  // Let x be the number of questions on a test.
  // Let y be the grade a student receives, out of 100.
  var rnd = new math.Random();

  int max = 10000;

  // Create 10-$max random grades. Min grade: 50.
  var trainingSet =
      new TrainingSet.fromIterable(new List.generate(rnd.nextInt(max - 10) + 10, (i) {
    return new Tuple2(rnd.nextInt(max) + 1, rnd.nextInt(50) + 50);
  }));

  var list = trainingSet.toList();
  for (var t in list)
    print('${t.item1} question(s): ${t.item2}%');

  var h = const LinearRegression().learn(trainingSet).map(getGrade);
  var nQuestions = rnd.nextInt(max) + 1;
  var result = h(nQuestions);

  print('\nProjected: $nQuestions question(s): $result');

  var existing = list.firstWhere((t) => t.item1 == nQuestions, orElse: () => null);

  if (existing != null)
    print('Compare this to the actual: ${existing.item2}%');
}

String getGrade(num n) {
  String type;

  if (n >= 90)
    type = 'A';
  else if (n >= 80)
    type = 'B';
  else if (n >= 70)
    type = 'C';
  else if (n >= 60)
    type = 'D';
  else
    type = 'F';

  return '$type: ${n.toStringAsPrecision(5)}%';
}
