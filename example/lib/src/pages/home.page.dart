import 'package:flutter/material.dart';

import 'example1/example1.page.dart';
import 'example2/example2.page.dart';
import 'example3/example3.page.dart';
import 'example4/example4.page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ValueNotifier Examples')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  child: const Text('Example 1'),
                  onPressed: () => show(context, const Example1Page()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Example 2'),
                  onPressed: () => show(context, const Example2Page()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Example 3'),
                  onPressed: () => show(context, Example3Page()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Example 4'),
                  onPressed: () => show(context, const Example4Page()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void show(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }
}
