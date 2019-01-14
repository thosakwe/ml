import 'dart:async';
import 'value.dart';

abstract class Backend {
  const Backend();

  FutureOr<Runnable<T>> compile<T>(Value<T> program);
}

abstract class Runnable<T> {
  FutureOr<T> run({Iterable<T> argv = const []});
}
