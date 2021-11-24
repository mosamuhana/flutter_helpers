import 'package:flutter/material.dart';
import 'package:listenable_extensions/listenable_extensions.dart';
import 'package:flutter_disposables/flutter_disposables.dart';

import 'model.dart';

class Example2Page extends StatefulWidget {
  const Example2Page({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Example2PageState();
}

class _Example2PageState extends State<Example2Page> with DisposableStateMixin {
  final _model = Model();

  @override
  void initState() {
    Disposable.create(() => _model.dispose()).disposeBy(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _model.secondsPassed.buildValue((x) => Text("Seconds passed: $x")),
            const SizedBox(height: 50),
            _model.stringCounterValue
                .parallelWith(_model.counterColor)
                .disposeBy(this)
                .bind((text, color) {
              return Text(text, style: TextStyle(color: color));
            }),
            const SizedBox(height: 50),
            SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(
                    onPressed: _model.increment,
                    child: const Text("Increment"),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: _model.evenPrintSubscription.cancel,
                    child: const Text("Cancel print"),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: Navigator.of(context).pop,
                    child: const Text("Navigate back"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
