import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_helpers/flutter_helpers.dart';

import 'model.dart';

class Example1Page extends StatefulWidget {
  const Example1Page({Key? key}) : super(key: key);

  @override
  _Example1PageState createState() => _Example1PageState();
}

class _Example1PageState extends State<Example1Page> {
  final _model = Model();

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Type any value here'),
              const SizedBox(height: 16),
              TextField(
                onChanged: _model.updateText,
              ),
              const SizedBox(height: 16),
              const Text('The following field displays the entered text in uppercase.\n'
                  'It gets only updated if the user pauses its input for at lease 500ms'),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _model.debouncedInput.buildValue((x) => Text(x)),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'This counter only displays even Numbers',
                textAlign: TextAlign.center,
              ),
              _model.evenCounter.buildValue((value) {
                return Text(
                  value,
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                );
              }),
              const Text(
                'The following field gets updated whenever one of the others changes:',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _model.merged.buildValue((value) {
                return Text(
                  value,
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _model.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
