import 'package:flutter/foundation.dart';

import 'subscription.dart';

/// extension functions on `ValueListenable` that allows you to work with them almost
/// as if it was a synchronous stream. Each extension function returns a new
/// `ValueNotifier` that updates its value when the value of `this` changes
/// You can chain these functions to build complex processing
/// pipelines from a simple `ValueListenable`
/// In the examples we use [subscribe] to react on value changes. Instead of applying [subscribe] you
/// could also pass the end of the function chain to a `ValueListenableBuilder`
extension ValueListenableSubscribeExtension<T> on ValueListenable<T> {
  ///
  /// let you work with a `ValueListenable` as it should be by installing a
  /// [handler] function that is called on any value change of `this` and gets
  /// the new value passed as an argument.
  /// It returns a subscription object that lets you stop the [handler] from
  /// being called by calling [cancel()] on the subscription.
  /// The [handler] get the subscription object passed on every call so that it
  /// is possible to uninstall the [handler] from the [handler] itself.
  ///
  /// example:
  /// ```dart
  ///
  /// final listenable = ValueNotifier<int>(0);
  /// final subscription = listenable.subscribe((x, _) => print(x));
  /// ```
  ///
  Subscription subscribe(void Function(T) handler) => _Subscription<T>(this, () => handler(value));
}

class _Subscription<T> extends Subscription {
  final ValueListenable<T> _listenable;
  final void Function() _handler;
  bool _isCanceled = false;

  _Subscription(this._listenable, this._handler) {
    _listenable.addListener(_handler);
  }

  @override
  void cancel() {
    if (!_isCanceled) {
      _listenable.removeListener(_handler);
      _isCanceled = true;
    }
  }

  @override
  bool get isCanceled => _isCanceled;
}
