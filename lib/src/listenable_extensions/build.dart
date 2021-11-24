import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// extension functions on `ValueListenable` that allows you to work with them almost
/// as if it was a synchronous stream. Each extension function returns a new
/// `ValueNotifier` that updates its value when the value of `this` changes
/// You can chain these functions to build complex processing
/// pipelines from a simple `ValueListenable`
/// In the examples we use [listen] to react on value changes. Instead of applying [listen] you
/// could also pass the end of the function chain to a `ValueListenableBuilder`
extension ValueListenableBuilderExtension<T> on ValueListenable<T> {
  Widget build(_ValueWidgetBuilder<T> builder) =>
      ValueListenableBuilder<T>(valueListenable: this, builder: (c, x, __) => builder(c, x));

  Widget buildValue(_ValueBuilder<T> builder) =>
      ValueListenableBuilder<T>(valueListenable: this, builder: (_, x, __) => builder(x));
}

typedef _ValueWidgetBuilder<T> = Widget Function(BuildContext, T);
typedef _ValueBuilder<T> = Widget Function(T);
