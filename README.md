# ml
A stupid-simple machine learning library in Dart.

# Hypotheses
All learning algorithms return *hypotheses*, which take a single input, `x`,
and produce a single output, `y`.

If it were a typedef (it's not), it might look like:

```dart
typedef Y Hypothesis<X, Y>(X x);
```

In `package:ml`, however, these are classes. The benefit here is that you can chain them together.

```dart
main() {
  var h = myAlgo.learn(trainingSet).map(
    myAlgo2.learn(trainingSet2)
  );
}
```

They can be infinitely changed, which to say the least allows for some interesting experiences.

# Training Sets
Training sets are a wrapper over `Tuple2`, and are passed to learning algorithms.

In the linear regression test, we can easily generate a training set:

```dart
var trainingSet = new TrainingSet<int, int>.fromIterable(
  new List.generate(100, (i) => new Tuple2(i, i)),
);
```

And learn via linear regression:

```dart
main() {
    var regression = const LinearRegression();
    var h = regression.learn(trainingSet).map<int>((n) => n.toInt());
    
    expect(h(100), 100);
}
```