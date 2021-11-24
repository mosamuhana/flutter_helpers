import 'package:flutter/material.dart';
import 'package:listenable_extensions/listenable_extensions.dart';

import 'model.dart';

class Example3Page extends StatelessWidget {
  final model = Model();

  Example3Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Example3Page build()');
    return Scaffold(
      body: PropertyChangeProvider<Model, String>(
        value: model,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              GlobalListener(),
              FooListener(),
              BarListener(),
              FooUpdater(),
              BarUpdater(),
              BothUpdater(),
            ],
          ),
        ),
      ),
    );
  }
}

class GlobalListener extends StatelessWidget {
  const GlobalListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('GlobalListener build()');
    return PropertyChangeConsumer<Model, String>(
      builder: (context, model, properties) {
        print('GlobalListener builder()');
        if (properties!.isEmpty) return Container();
        return Text('$properties changed');
      },
    );
  }
}

class FooListener extends StatelessWidget {
  const FooListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('FooListener build()');
    return PropertyChangeConsumer<Model, String>(
      properties: const ['foo'],
      builder: (context, model, properties) {
        print('FooListener builder()');
        return Text('Foo is ${model?.foo}');
      },
    );
  }
}

class BarListener extends StatelessWidget {
  const BarListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('BarListener build()');
    return PropertyChangeConsumer<Model, String>(
      properties: const ['bar'],
      builder: (context, model, properties) {
        print('BarListener builder()');
        return Text('Bar is ${model?.bar}');
      },
    );
  }
}

class FooUpdater extends StatelessWidget {
  const FooUpdater({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('FooUpdater build()');
    final model = PropertyChangeProvider.of<Model, String>(context, listen: false)!.value;
    return ElevatedButton(
      child: const Text('Update foo'),
      onPressed: () => model.foo++,
    );
  }
}

class BarUpdater extends StatelessWidget {
  const BarUpdater({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('BarUpdater build()');
    final model = PropertyChangeProvider.of<Model, String>(context, listen: false)!.value;
    return ElevatedButton(
      child: const Text('Update bar'),
      onPressed: () => model.bar++,
    );
  }
}

class BothUpdater extends StatelessWidget {
  const BothUpdater({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('BothUpdater build()');
    Model model = PropertyChangeProvider.of<Model, String>(context, listen: false)!.value;
    return ElevatedButton(
      child: const Text('Update both'),
      onPressed: () {
        model.foo++;
        model.bar++;
      },
    );
  }
}
