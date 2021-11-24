import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

extension ValueListenableDebouncedExtension<T> on ValueListenable<T> {
  ///
  /// If you get too much value changes during a short time period and you don't
  /// want or can handle them all [debounce] can help you.
  /// If you add a [debounce] to your listenable processing pipeline the returned
  /// `ValueListenable` will not emit an updated value before at least
  /// [timeout] time has passed since the last value change. All value changes
  /// before will be discarded.
  ///
  /// ATTENTION: If you use [debounce] inside the Widget tree in combination with
  /// `setState` it can happen that debounce doesn't have any effect. Better to use it
  /// inside your model objects
  ///
  /// example:
  /// ```
  /// final listenable = ValueNotifier<int>(0);
  ///
  /// listenable
  ///     .debounce(const Duration(milliseconds: 500))
  ///     .listen((x, _) => print(x));
  ///
  /// listenable.value = 42;
  /// await Future.delayed(const Duration(milliseconds: 100));
  /// listenable.value = 43;
  /// await Future.delayed(const Duration(milliseconds: 100));
  /// listenable.value = 44;
  /// await Future.delayed(const Duration(milliseconds: 350));
  /// listenable.value = 45;
  /// await Future.delayed(const Duration(milliseconds: 550));
  /// listenable.value = 46;
  ///
  /// ```
  ///  will print out 42,45,46
  ///
  ValueNotifier<T> debounce(Duration timeout) => _DebouncedValueNotifier(this, timeout);
}

class _DebouncedValueNotifier<T> extends ValueNotifier<T> {
  final ValueListenable<T> listenable;
  final Duration timeout;
  Timer? _timer;

  _DebouncedValueNotifier(this.listenable, this.timeout) : super(listenable.value) {
    listenable.addListener(_handler);
  }

  void _handler() {
    _timer?.cancel();
    _timer = Timer(timeout, () => value = listenable.value);
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    if (!hasListeners) {
      listenable.removeListener(_handler);
    }
  }

  @override
  void dispose() {
    listenable.removeListener(_handler);
    super.dispose();
  }
}
