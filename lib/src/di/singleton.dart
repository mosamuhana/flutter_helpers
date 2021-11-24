class Singleton {
  Singleton._();

  static final List _list = [];

  static T? _find<T>() {
    if (_list.isNotEmpty) {
      return _list.firstWhere((x) => x.runtimeType == T, orElse: () => null);
    }
    return null;
  }

  static T get<T>(T Function() builder) {
    T? instance = _find<T>();

    if (instance != null) {
      return instance;
    }

    instance = builder();
    _list.add(instance);
    return instance!;
  }

  static Future<T> getAsync<T>(Future<T> Function() builder) async {
    T? instance = _find<T>();

    if (instance != null) {
      return instance;
    }

    instance = await builder();
    _list.add(instance);
    return instance!;
  }

  static void register<T>(T Function() builder) => get<T>(builder);
  static Future<void> registerAsync<T>(Future<T> Function() builder) => getAsync<T>(builder);
}

/*
void main() {
  Singleton.get(
    () => Manager(Singleton.get(() => Service())),
  );
}

class Service {}

class Manager {
  final Service service;

  Manager(this.service);
}
*/
