import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_bmi_image_app/vm/bmi_notifier.dart';

class Home extends ConsumerWidget {
  Home({super.key});

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bmiState = ref.watch(bmiProvider);

    return Scaffold(
      appBar: AppBar(title: Text('BMI')),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                buildInputTextField('키를 입력 하세요', _heightController, false),
                buildInputTextField('체중을 입력 하세요', _weightController, false),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      calcActon(context, ref);
                    },
                    child: Text('계산'),
                  ),
                ),
                Text(bmiState.notiText),
                Image.asset('images/${bmiState.imagePath}.png'),
              ],
            ),
          ),
        ),
      ),
    );
  } // build

  // === Widgets ===
  Widget buildInputTextField(
    String label,
    TextEditingController controller,
    bool readOnly,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  } // buildInputTextField

  // === Functions ===

  void calcActon(BuildContext context, WidgetRef ref) {
    final heightText = _heightController.text.toString();
    final weightText = _weightController.text.toString();

    if (heightText.isEmpty || weightText.isEmpty) {
      errorSnackBar(context);
      return;
    }

    final num1 = double.tryParse(heightText) ?? 0.0;
    final num2 = double.tryParse(weightText) ?? 0.0;
    // print('$num1 / $num2');

    ref.read(bmiProvider.notifier).calcAction(num1 / 100, num2);
    successSnackBar(context);
  }

  void errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        //SnackBar 는 디자인
        content: Text('숫자를 입력하여라'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ),
    );
  }

  void successSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        //SnackBar 는 디자인
        content: Text('계산 성공'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  }
}
