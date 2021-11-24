import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:listenable_extensions/listenable_extensions.dart';
import 'package:flutter_disposables/flutter_disposables.dart';

class Model {
  /// Object main dispose bag.
  //final DisposeBag _disposeBag = DisposeBag();
  final _disposeBag = DisposableBag();

  /// Base private notifier that every other derives its value from.
  final ValueNotifier<int> _counter = ValueNotifier(0);

  /// Base stream for conversion demonstration
  final Stream<int> _timer = Stream.periodic(const Duration(seconds: 1), (x) => x);

  /// Derived notifiers through [map()] extension
  late final ValueNotifier<Color> counterColor;
  late final ValueNotifier<String> stringCounterValue;

  /// Converted stream through [extractValue()] extension
  late final ValueNotifier<int> secondsPassed;

  /// Derived subscription using [where()] and [subscribe()] extensions
  late final Subscription evenPrintSubscription;

  Model() {
    _counter.disposeBy(_disposeBag);

    counterColor =
        _counter.map<Color>((x) => x.isEven ? Colors.red : Colors.blue).disposeBy(_disposeBag);

    stringCounterValue = _counter.map((x) => '$x').disposeBy(_disposeBag);

    secondsPassed = _timer.extractValue(0).disposeBy(_disposeBag);

    evenPrintSubscription = _counter.where((value) => value.isEven).subscribe(print);
  }

  void increment() => _counter.set((value) => value + 1);

  void dispose() {
    if (!evenPrintSubscription.isCanceled) evenPrintSubscription.cancel();
    _disposeBag.dispose();
    print("Disposed $this");
  }
}
