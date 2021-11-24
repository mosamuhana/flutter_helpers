import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

extension ValueListenableMergeExtension<T> on ValueListenable<T> {
  /// Merges value changes of [this] together with value changes of a List of
  /// `ValueListenables` so that when ever any of them changes the result of
  /// [listenables] will change too.
  ///
  /// ```
  ///     final listenable1 = ValueNotifier<int>(0);
  ///     final listenable2 = ValueNotifier<int>(0);
  ///     final listenable3 = ValueNotifier<int>(0);
  ///     final listenable4 = ValueNotifier<int>(0);
  ///
  ///     listenable1.mergeWith([listenable2, listenable3, listenable4])
  ///          .subscribe((x) => print(x));
  ///
  ///     listenable2.value = 42;
  ///     listenable1.value = 43;
  ///     listenable4.value = 44;
  ///     listenable3.value = 45;
  ///     listenable1.value = 46;
  ///     ```
  ///   Will print 42,43,44,45,46
  ///
  ValueNotifier<T> mergeWith(List<ValueListenable<T>> listenables) =>
      _MergeValueNotifier<T>([this, ...listenables]);
}

class _MergeValueNotifier<T> extends ValueNotifier<T> {
  final List<ValueListenable<T>> listenables;
  late List<VoidCallback> _disposers;

  _MergeValueNotifier(this.listenables) : super(listenables[0].value) {
    _disposers = listenables.map<VoidCallback>((notifier) {
      void notifyHandler() => value = notifier.value;
      notifier.addListener(notifyHandler);
      return () => notifier.removeListener(notifyHandler);
    }).toList();
  }

  void _removeListeners() {
    for (final handler in _disposers) {
      handler();
    }
  }

  @override
  void removeListener(VoidCallback listener) {
    if (!hasListeners) {
      _removeListeners();
    }
    super.removeListener(listener);
  }

  @override
  void dispose() {
    _removeListeners();
    super.dispose();
  }
}
