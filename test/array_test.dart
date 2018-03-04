import 'package:ml/ml.dart';
import 'package:test/test.dart';

void main() {
  var arr = new NDArray.zero(3, 5);

  test('size', () => expect(arr.size, 15));

  test('data', () {
    expect(arr.data, new List.filled(arr.size, 0));
  });

  test('mapAll', () {
    var threes = arr.mapAll((_) => 3.0);
    expect(threes.data, new List.filled(arr.size, 3.0));
  });

  group('stride', () {
    test('iterator', () {
      expect(arr.length, arr.columnCount);
    });

    test('get', () {
      expect(arr[1][2], 0);
    });

    test('set', () {
      var a = arr.copy();
      a[1][2] = 3.5;
      expect(a[1][2], 3.5);
    });
  });
}