import 'package:flutter/foundation.dart';
import 'package:flutter_helpers/flutter_helpers.dart';

class Model {
  final _input = ValueNotifier<String>('');
  final _counter = ValueNotifier<int>(0);

  late final ValueListenable<String> debouncedInput;
  late final ValueListenable<String> evenCounter;
  ValueListenable<String> get merged =>
      debouncedInput.combineLatest<String, String>(evenCounter, (s1, s2) => '$s1:$s2');

  Model() {
    debouncedInput = _input
        .debounce(const Duration(milliseconds: 500)) //...
        .map((s) => s.toUpperCase());
    evenCounter = _counter
        .where((x) => x.isEven) //...
        .map<String>((x) => '$x');
  }

  void incrementCounter() {
    _counter.value++;
  }

  void updateText(String s) {
    _input.value = s;
  }

  void dispose() {
    _input.dispose();
    _counter.dispose();
  }
}
