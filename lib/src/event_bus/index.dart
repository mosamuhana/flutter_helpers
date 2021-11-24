import 'dart:async';

/// Dispatch and listen events everywhere using Dart [Stream] API.
class EventBus {
  /// [StreamController] for the event bus stream
  final StreamController<_Event> _controller;

  EventBus({bool sync = false}) : _controller = StreamController<_Event>.broadcast(sync: sync);

  /// Register a event listener. The [callback] will be called once the [name] is fired.
  StreamSubscription on(String name, void Function(dynamic) callback) {
    final sub = _controller.stream.where((x) => x.name == name).listen((x) => callback(x.data));
    return sub;
  }

  /// Emit an event, which will notify all the event listeners
  /// that listen to the event [name]. You can also pass an optional [data]
  void emit(String name, [dynamic data]) {
    _controller.add(_Event(name, data));
  }

  /// You don't have to destroy it explicitly
  Future<void> close() async {
    await _controller.close();
  }
}

/// The underlying event which is fired. You won't need it.
class _Event {
  final String name;
  final dynamic data;

  _Event(this.name, this.data);
}
