import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

extension ValueListenableCombineLatestExtension<T> on ValueListenable<T> {
  ///
  /// Imagine having two `ValueNotifier` in your model and you want to update
  /// a certain region of the screen with their values every time one of them
  /// get updated.
  /// [combineLatest] combines two `ValueListenable` in that way that it returns
  /// a new `ValueNotifier` that changes its value of [R] whenever one of the
  /// input listenables [this] or [otherListenable] updates its value. This new value
  /// is built by the [transform] function that is called on any value change of
  /// the input listenables.
  ///
  /// example:
  /// ```
  ///    class StringIntWrapper {
  ///      final String s;
  ///      final int i;
  ///
  ///      StringIntWrapper(this.s, this.i);
  ///
  ///      @override
  ///      String toString() {
  ///        return '$s:$i';
  ///      }
  ///    }
  ///
  ///    final listenable1 = ValueNotifier<int>(0);
  ///    final listenable2 = ValueNotifier<String>('Start');
  ///
  ///    final destValues = <StringIntWrapper>[];
  ///    final subscription = listenable1
  ///        .combineLatest<String, StringIntWrapper>(
  ///            listenable2, (i, s) => StringIntWrapper(s, i))
  ///        .listen((x, _) {
  ///      destValues.add(x);
  ///    });
  ///
  ///    listenable1.value = 42;
  ///    listenable1.value = 43;
  ///    listenable2.value = 'First';
  ///    listenable1.value = 45;
  ///
  ///    expect(destValues[0].toString(), 'Start:42');
  ///    expect(destValues[1].toString(), 'Start:43');
  ///    expect(destValues[2].toString(), 'First:43');
  ///    expect(destValues[3].toString(), 'First:45');
  ///  ```
  ///
  ValueNotifier<R> combineLatest<U, R>(
          ValueListenable<U> other, _TransformFunc2<T, U, R> transform) =>
      _CombineLatestValueNotifier<T, U, R>(this, other, transform);
}

class _CombineLatestValueNotifier<T, U, R> extends ValueNotifier<R> {
  final ValueListenable<T> _listenable1;
  final ValueListenable<U> _listenable2;
  final _TransformFunc2<T, U, R> _transform;

  _CombineLatestValueNotifier(
    this._listenable1,
    this._listenable2,
    this._transform,
  ) : super(_transform(_listenable1.value, _listenable2.value)) {
    _listenable1.addListener(_listener);
    _listenable2.addListener(_listener);
  }

  void _listener() => value = _transform(_listenable1.value, _listenable2.value);

  @override
  void removeListener(VoidCallback listener) {
    if (!hasListeners) {
      _listenable1.removeListener(_listener);
      _listenable2.removeListener(_listener);
    }
    super.removeListener(listener);
  }

  @override
  void dispose() {
    _listenable1.removeListener(_listener);
    _listenable2.removeListener(_listener);
    super.dispose();
  }
}

typedef _TransformFunc2<T, U, R> = R Function(T, U);
