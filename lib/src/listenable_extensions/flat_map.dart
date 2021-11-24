import 'package:flutter/foundation.dart';

import 'subscription.dart';
import 'subscribe.dart';

/// Creates a new [ValueNotifier] from the base notifier,
/// using transform function.
///
/// Works like [ValueNotifier.map] but transform function must return another
/// [ValueNotifier] instead of regular value.
extension FlatMapExtension<T> on ValueListenable<T> {
  /// Creates a new [ValueNotifier] from the base notifier,
  /// using transform function.
  ///
  /// Works like [ValueNotifier.map] but transform function must return another
  /// [ValueNotifier] instead of regular value.
  ValueNotifier<R> flatMap<R>(_FlatMapTransform<T, R> transform) =>
      _FlatMappedValueNotifier<T, R>(this, transform);
}

class _FlatMappedValueNotifier<T, R> extends ValueNotifier<R> {
  final ValueListenable<T> _listenable;
  final _FlatMapTransform<T, R> _transform;
  late final Subscription _flatMapSubscription;

  Subscription? _currentSubscription;
  ValueListenable<R>? _currentValue;

  _FlatMappedValueNotifier(this._listenable, this._transform)
      : super(_transform(_listenable.value).value) {
    _flatMapSubscription = _listenable.subscribe(_listener);
  }

  void _listener(T baseValue) {
    _currentValue = _transform(baseValue);
    value = _currentValue!.value;
    _currentSubscription?.cancel();
    _currentSubscription = _currentValue!.subscribe((x) => value = x);
  }

  @override
  void dispose() {
    _currentSubscription?.cancel();
    _flatMapSubscription.cancel();
    super.dispose();
  }
}

typedef _FlatMapTransform<T, R> = ValueListenable<R> Function(T);
