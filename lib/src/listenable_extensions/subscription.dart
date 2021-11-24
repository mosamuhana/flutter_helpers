/// Object that is returned by [listen] that allows you to stop the calling of the
/// handler that you passed to it.
abstract class Subscription {
  void cancel();
  bool get isCanceled;
}
