import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'combine_latest.dart';

class Pair<T, U> {
  final T first;
  final U second;
  Pair(this.first, this.second);
}

/// Allows to avoid nesting by paralleling two [ValueNotifiers]. This is a
/// wrapper over the [ValueNotifier.combineLatest] extensions.
///
/// Performance note – this extensions is often used inside UI, and its result
/// must be disposed as any other [ValueNotifier]. To avoid memory leaks,
/// use [DisposableBuilder] when using this extension.
extension ParallelWithExtension<T> on ValueListenable<T> {
  /// Allows to avoid nesting by paralleling two [ValueNotifiers]. This is a
  /// wrapper over the [ValueNotifier.combineLatest] extensions.
  ///
  /// Performance note – this extensions is often used inside UI, and its result
  /// must be disposed as any other [ValueNotifier]. To avoid memory leaks,
  /// use [DisposableBuilder] when using this extension.
  ValueNotifier<Pair<T, U>> parallelWith<U>(ValueListenable<U> other) => //...
      combineLatest(other, (T t, U u) => Pair(t, u));
}

extension BindParallelWithExtension<T, U> on ValueListenable<Pair<T, U>> {
  Widget bind(Widget Function(T first, U second) to) => //...
      ValueListenableBuilder<Pair<T, U>>(
        valueListenable: this,
        builder: (_, value, __) => to(value.first, value.second),
      );
}
