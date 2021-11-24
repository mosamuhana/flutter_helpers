import 'package:listenable_extensions/listenable_extensions.dart';

class Model extends PropertyChangeNotifier<String> {
  int _foo = 0;
  int _bar = 0;

  int get foo => _foo;
  int get bar => _bar;

  set foo(int value) {
    _foo = value;
    notifyListeners('foo');
  }

  set bar(int value) {
    _bar = value;
    notifyListeners('bar');
  }

  incrementBoth() {
    _foo = _foo + 1;
    _bar = _bar + 1;
    notifyListeners('foo');
    notifyListeners('bar');
  }
}
