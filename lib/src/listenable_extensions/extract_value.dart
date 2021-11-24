import 'dart:async';

import 'package:flutter/foundation.dart';

extension ExtractValueExtension<T> on Stream<T> {
  ValueNotifier<T> extractValue(T initialValue) => _ExtractedValueNotifier(this, initialValue);
}

class _ExtractedValueNotifier<T> extends ValueNotifier<T> {
  late final StreamSubscription<T> _subscription;

  _ExtractedValueNotifier(Stream<T> stream, T initialValue) : super(initialValue) {
    _subscription = stream.listen((x) => value = x);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
