class DI {
  DI._();

  static final List<_Entry> _entryList = [];

  static void _checkRegistered<T>() {
    if (_entryList.where((x) => x.type == T).isNotEmpty) {
      throw Exception('$T is already registered');
    }
  }

  static _Entry? _findEntry<T>() {
    if (_entryList.isNotEmpty) {
      final matches = _entryList.where((x) => x.type == T);
      if (matches.isNotEmpty) {
        return matches.first;
      }
    }
    return null;
  }

  static void registerSingleton<T>(_Builder<T> builder) {
    _checkRegistered<T>();
    _entryList.add(
      _Entry(
        type: T,
        builder: builder,
        isSingleton: true,
        isAsync: false,
      ),
    );
  }

  static Future<void> registerAsyncSingleton<T>(_AsyncBuilder<T> builder) async {
    _checkRegistered<T>();
    _entryList.add(
      _Entry(
        type: T,
        builder: builder,
        isSingleton: true,
        isAsync: true,
      ),
    );
  }

  static void register<T>(_Builder<T> builder) {
    _checkRegistered<T>();
    _entryList.add(
      _Entry(
        type: T,
        builder: builder,
        isSingleton: false,
        isAsync: false,
      ),
    );
  }

  static void registerAsync<T>(_AsyncBuilder<T> builder) {
    _checkRegistered<T>();
    _entryList.add(
      _Entry(
        type: T,
        builder: builder,
        isSingleton: false,
        isAsync: true,
      ),
    );
  }

  static T get<T>() {
    _Entry? entry = _findEntry<T>();

    if (entry == null) {
      throw Exception('$T is not registered');
    }

    if (entry.isAsync) {
      return throw 'builder is async';
    }

    if (entry.isSingleton) {
      entry.instance ??= entry.builder!.call();
      return entry.instance as T;
    }

    return entry.builder!.call() as T;
  }

  static Future<T> getAsync<T>(Future<T> Function() builder) async {
    _Entry? entry = _findEntry<T>();

    if (entry == null) {
      throw Exception('$T is not registered');
    }

    if (entry.isSingleton) {
      if (entry.instance == null) {
        if (entry.isAsync) {
          entry.instance = await entry.builder!.call();
        } else {
          entry.instance = entry.builder!.call();
        }
      }
      return entry.instance as T;
    }

    if (entry.isAsync) {
      return await entry.builder!.call();
    } else {
      return entry.builder!.call();
    }
  }
}

typedef _Builder<T> = T Function();
typedef _AsyncBuilder<T> = Future<T> Function();

class _Entry {
  final Type type;
  final Function? builder;
  final bool isSingleton;
  final bool isAsync;
  dynamic instance;

  _Entry({
    required this.type,
    this.builder,
    this.isSingleton = false,
    this.isAsync = false,
    this.instance,
  });
}
