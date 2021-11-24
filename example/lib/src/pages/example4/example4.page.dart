import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class Example4Page extends StatelessWidget {
  const Example4Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Example4Page build()');
    return Provider(
      create: (_) => Model(),
      child: Scaffold(
        body: Center(
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
    Model model = Provider.of<Model>(context);
    return StreamBuilder(
      stream: model.both$,
      builder: (context, snapshot) {
        print('GlobalListener builder()');
        return Text('Foo: ${model.foo}, Bar: ${model.bar}');
      },
    );
  }
}

class FooListener extends StatelessWidget {
  const FooListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('FooListener build()');
    Model model = Provider.of<Model>(context);
    return StreamBuilder(
      stream: model.foo$,
      builder: (context, snapshot) {
        print('FooListener builder()');
        return Text('Foo is ${snapshot.data}');
      },
    );
  }
}

class BarListener extends StatelessWidget {
  const BarListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('BarListener build()');
    Model model = Provider.of<Model>(context);
    return StreamBuilder(
      stream: model.bar$,
      builder: (context, snapshot) {
        print('BarListener builder()');
        return Text('Bar is ${snapshot.data}');
      },
    );
  }
}

class FooUpdater extends StatelessWidget {
  const FooUpdater({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('FooUpdater build()');
    Model model = Provider.of<Model>(context);
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
    Model model = Provider.of<Model>(context);
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
    Model model = Provider.of<Model>(context);
    return ElevatedButton(
      child: const Text('Update both'),
      onPressed: () {
        model.foo++;
        model.bar++;
      },
    );
  }
}
