import 'dart:collection';
import 'dart:math' as math;
import 'package:collection/collection.dart';
import 'package:typed_data/typed_buffers.dart';

/// An immutable, multi-dimensional array.
class NDArray extends IterableMixin<NDArrayStride> {
  int _rowCount, _columnCount;
  final Float64Buffer _data;

  NDArray._(this._data, this._columnCount, this._rowCount);

  Float64Buffer get data => _data;

  int get rowCount => _rowCount;

  int get columnCount => _columnCount;

  int get size => rowCount * columnCount;

  static int _computeIndex(int x, int y, int columnCount) {
    //print('x: $x, y: $y; ($y * $columnCount) + $x = ${(y * columnCount) + x}');
    return (y * columnCount) + x;
  }

  factory NDArray.from(Float64Buffer data, int columnCount, int rowCount) {
    return new NDArray._(data, columnCount, rowCount);
  }

  factory NDArray.fromDoubles(
      Iterable<double> data, int columnCount, int rowCount) {
    return new NDArray.from(
        new Float64Buffer()..addAll(data), columnCount, rowCount);
  }

  factory NDArray.fromStrides(Iterable<NDArrayStride> strides) {
    var b = new Float64Buffer();
    int columnCount = 0;

    for (var stride in strides) {
      b.addAll(stride);
      columnCount = stride.length;
    }

    return new NDArray._(b, strides.length, columnCount);
  }

  factory NDArray.generate(
      int columnCount, int rowCount, double generate(int x, y)) {
    var data = new Float64Buffer(rowCount * columnCount);

    for (int y = 0; y < rowCount; y++) {
      for (int x = 0; x < columnCount; x++) {
        data[_computeIndex(x, y, columnCount)] = generate(x, y);
      }
    }

    return new NDArray._(data, columnCount, rowCount);
  }

  factory NDArray.filled(int columnCount, int rowCount, double value) {
    return new NDArray.generate(columnCount, rowCount, (_, __) => value);
  }

  factory NDArray.zero(int columnCount, int rowCount) {
    return new NDArray.filled(columnCount, rowCount, 0.0);
  }

  factory NDArray.one(int columnCount, int rowCount) {
    return new NDArray.filled(columnCount, rowCount, 1.0);
  }

  NDArrayStride operator [](int index) {
    if (index >= rowCount) throw new RangeError.range(index, 0, rowCount);
    return new NDArrayStride._(this, index);
  }

  @override
  Iterator<NDArrayStride> get iterator => new _NDArrayIterator(this);

  void reshape(int columnCount, int rowCount) {
    if ((rowCount * columnCount) != (this._rowCount * this._columnCount)) {
      throw new ArgumentError(
          'The product of rowCount and columnCount must be equal to ${this
              ._rowCount * this._columnCount}.');
    }

    _rowCount = rowCount;
    _columnCount = columnCount;
  }

  NDArray copy() {
    var b = new Float64Buffer()..addAll(_data);
    return new NDArray._(b, _rowCount, _columnCount);
  }

  NDArray mapAll(double f(double x)) {
    return new NDArray._(
        new Float64Buffer()..addAll(data.map(f)), _rowCount, _columnCount);
  }

  NDArray reduceAgainst(NDArray other, double f(double x, double y)) {
    var b = new Float64Buffer(_data.length);

    for (int i = 0; i < b.length; i++) {
      b[i] = f(_data[i], other._data[i]);
      //print('x: ${_data[i]}, y: ${other._data[i]}, new: ${f(_data[i], other._data[i])}');
    }

    return new NDArray._(b, _columnCount, _rowCount);
  }

  NDArray pow(double exponent) {
    return mapAll((x) => math.pow(x, exponent));
  }

  NDArray operator *(NDArray other) {
    return reduceAgainst(other, (x, y) => x * y);
  }

  NDArray operator /(NDArray other) {
    return reduceAgainst(other, (x, y) => x / y);
  }

  NDArray operator %(NDArray other) {
    return reduceAgainst(other, (x, y) => x % y);
  }

  NDArray operator +(NDArray other) {
    return reduceAgainst(other, (x, y) => x + y);
  }

  NDArray operator -(NDArray other) {
    return reduceAgainst(other, (x, y) => x - y);
  }
}

class NDArrayStride extends ListBase<double> with NonGrowableListMixin<double> {
  final NDArray _array;
  final int _row;

  NDArrayStride._(this._array, this._row);

  @override
  get length => _array._columnCount;

  void _verify(int index) {
    if (index >= _array._columnCount) {
      throw new RangeError.range(index, 0, _array._columnCount);
    }
  }

  @override
  double operator [](int index) {
    _verify(index);
    return _array._data[NDArray._computeIndex(index, _row, _array._columnCount)];
  }

  @override
  void operator []=(int index, double value) {
    _verify(index);
    _array._data[NDArray._computeIndex(index, _row, _array._columnCount)] = value;
  }
}

class _NDArrayIterator extends Iterator<NDArrayStride> {
  final NDArray array;
  int index = -1;
  NDArrayStride _current;

  _NDArrayIterator(this.array);

  @override
  NDArrayStride get current => _current;

  @override
  bool moveNext() {
    if (index++ >= array._rowCount - 1) {
      return false;
    }

    _current = array[index];
    return true;
  }
}
