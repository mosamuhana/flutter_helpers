import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

extension ValueListenableMapExtension<T> on ValueListenable<T> {
  ///
  /// converts a ValueListenable to another type [T] by returning a new connected
  /// `ValueListenable<T>`
  /// on each value change of `this` the conversion funcion
  /// [transform] is called to do the type conversion
  ///
  /// example (lets pretend that print wouldn't automatically call toString):
  /// ```dart
  /// final sourceListenable = ValueNotifier<int>(0);
  /// final subscription = sourceListenable
  ///   .map<String>((x) => x.toString())
  ///   .subscribe((x) => print(x));
  ///```
  ValueNotifier<R> map<R>(_MapFunc<T, R> transform) => _MapValueNotifier<T, R>(this, transform);
}

class _MapValueNotifier<T, R> extends ValueNotifier<R> {
  final _MapFunc<T, R> _transform;
  final ValueListenable<T> _listenable;

  _MapValueNotifier(
    this._listenable,
    this._transform,
  ) : super(_transform(_listenable.value)) {
    _listenable.addListener(_listener);
  }

  void _listener() => value = _transform(_listenable.value);

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    if (!hasListeners) {
      _listenable.removeListener(_listener);
    }
  }

  @override
  void dispose() {
    _listenable.removeListener(_listener);
    super.dispose();
  }
}

typedef _MapFunc<T, R> = R Function(T);
