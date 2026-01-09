import 'package:counter_app/vm/counter_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  // <<<<<<<<<<<<<<<<<<<<<
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // <<<<<<<<<<<<<<<<<<<<<<<<<<<
    final counterState = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Provider State')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text('현재 카운트의 결과값은 ${counterState.totalClick} 입니다.'),
            Text('현재 카운트의 결과값은 ${counterState.count} 입니다.'),
          ],
        ),
      ),

      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              ref.read(counterProvider.notifier).increment();
            },
            backgroundColor: Colors.deepPurpleAccent,
            child: Icon(Icons.add),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              ref.read(counterProvider.notifier).decrement();
            },
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
