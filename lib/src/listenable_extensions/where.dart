import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

extension ValueListenableWhereExtension<T> on ValueListenable<T> {
  ///
  /// [where] allows you to set a filter on a `ValueListenable` so that an installed
  /// handler function is only called if the passed
  /// [selector] function returns true. Because the selector function is called on
  /// every new value you can change the filter during runtime.
  ///
  /// ATTENTION: Due to the nature of ValueListeners that they always have to have
  /// a value the filter can't work on the initial value. Therefore it's not
  /// advised to use [where] inside the Widget tree if you use `setState` because that
  /// will recreate the underlying `WhereValueNotifier` again passing through the lates
  /// value of the `this` even if it doesn't fulfill the [selector] condition.
  /// Therefore it's better not to use it directly in the Widget tree but in
  /// your state objects
  ///
  /// example: lets only print even values
  /// ```dart
  /// final sourceListenable = ValueNotifier<int>(0);
  /// final subscription = sourceListenable.where((x) => x.isEven)
  ///    .subscribe((s) => print(x));
  ///```
  ValueNotifier<T> where(bool Function(T) selector) => _WhereValueNotifier(this, selector);
}

class _WhereValueNotifier<T> extends ValueNotifier<T> {
  final ValueListenable<T> _listenable;
  final bool Function(T) _selector;

  _WhereValueNotifier(this._listenable, this._selector) : super(_listenable.value) {
    _listenable.addListener(_listener);
  }

  void _listener() {
    final current = _listenable.value;
    if (_selector(current)) {
      value = current;
    }
  }

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
