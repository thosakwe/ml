import 'package:code_buffer/code_buffer.dart';
import 'package:ml/ml.dart';

void main() {
  var b = new CodeBuffer();
  var c = new CCompiler();
  var p = new Perceptron(3)..compile(c);
  c.implementation.generate(b);
  print(b);
}
