import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:typed_data/typed_buffers.dart';

/// An immutable, multi-dimensional array.
class NDArray extends IterableMixin<NDArrayStride> {
  int _rowCount, _columnCount;
  final Float64Buffer _data;

  NDArray._(this._data, this._rowCount, this._columnCount);

  Float64Buffer get data => _data;

  int get rowCount => _rowCount;

  int get columnCount => _columnCount;

  int get size => rowCount * columnCount;

  static int _computeIndex(int x, int y, int rowCount) {
    return (y * rowCount) + x;
  }

  factory NDArray.from(Float64Buffer data, int rowCount, int columnCount) {
    return new NDArray._(data, rowCount, columnCount);
  }

  factory NDArray.fromDoubles(
      Iterable<double> data, int rowCount, int columnCount) {
    return new NDArray.from(
        new Float64Buffer()..addAll(data), rowCount, columnCount);
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
      int rowCount, int columnCount, double generate(int x, y)) {
    var data = new Float64Buffer(rowCount * columnCount);

    for (int y = 0; y < rowCount; y++) {
      for (int x = 0; x < columnCount; x++) {
        data[_computeIndex(x, y, rowCount)] = generate(x, y);
      }
    }

    return new NDArray._(data, rowCount, columnCount);
  }

  factory NDArray.filled(int rowCount, int columnCount, double value) {
    return new NDArray.generate(rowCount, columnCount, (_, __) => value);
  }

  factory NDArray.zero(int rowCount, int columnCount) {
    return new NDArray.filled(rowCount, columnCount, 0.0);
  }

  factory NDArray.one(int rowCount, int columnCount) {
    return new NDArray.filled(rowCount, columnCount, 1.0);
  }

  NDArrayStride operator [](int index) {
    return new NDArrayStride._(this, index);
  }

  @override
  Iterator<NDArrayStride> get iterator => new _NDArrayIterator(this);

  void reshape(int rowCount, int columnCount) {
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

  NDArray mapAll(double f(double)) {
    return new NDArray._(new Float64Buffer()..addAll(data.map(f)),
        _rowCount, _columnCount);
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
    return _array._data[NDArray._computeIndex(index, _row, _array._rowCount)];
  }

  @override
  void operator []=(int index, double value) {
    _verify(index);
    _array._data[NDArray._computeIndex(index, _row, _array._rowCount)] = value;
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
    if (index++ >= array._columnCount - 1) {
      return false;
    }

    _current = array[index];
    return true;
  }
}
