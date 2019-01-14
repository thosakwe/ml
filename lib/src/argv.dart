import 'value.dart';

const Argv argv = Argv._();

class Argv {
  const Argv._();

  ArgvValue operator [](int index) => ArgvValue(index);
}

class ArgvValue {
  final int index;

  ArgvValue(this.index) {
    if (index <= 0) throw ArgumentError.value(index, 'index', 'must be >= 1');
  }

  Value<int> get asInt => ArgvValueParser(index, 'atoi');

  Value<double> get asDouble => ArgvValueParser(index, 'atof');
}

class ArgvValueParser<T> extends Value<T> {
  final int index;
  final String parserFunctionName;

  ArgvValueParser(this.index, this.parserFunctionName);

  @override
  String toString() => 'argv[$index]';
}
