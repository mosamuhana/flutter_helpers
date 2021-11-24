import 'dart:async';
import 'package:rxdart/rxdart.dart';

class Model {
  final _fooSubject = BehaviorSubject.seeded(0);
  final _barSubject = BehaviorSubject.seeded(0);

  Model() {
    //_fooSubject.mergeWith(streams)
    //MergeExtension
  }

  int get foo => _fooSubject.value;
  int get bar => _barSubject.value;

  Stream<int> get foo$ => _fooSubject.stream;
  Stream<int> get bar$ => _barSubject.stream;
  //Stream get both$ => _fooSubject.withLatestFrom(_barSubject, (foo, bar) => {'foo': foo, 'bar': bar});
  Stream get both$ => _fooSubject.mergeWith([_barSubject]);

  set foo(int value) => _fooSubject.add(value);
  set bar(int value) => _barSubject.add(value);

  void incrementBoth() {
    foo++;
    bar++;
  }

  Future<void> dispose() async {
    await _fooSubject.close();
    await _barSubject.close();
  }
}
